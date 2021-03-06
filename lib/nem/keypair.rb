require 'securerandom'

module Nem
  class Keypair
    attr_reader :private, :public

    # @param [String] Hex Private Key
    def initialize(private_key)
      @private = private_key
      @public  = calc_public_key
    end

    # @param [String] Hex string
    # @return  [String] Signed hex string
    def sign(data)
      bin_data = Nem::Util::Convert.hex2bin(data)
      bin_signed = Nem::Util::Ed25519.signature_hash_unsafe(bin_data, bin_secret, bin_public)
      bin_signed.unpack('H*').first
    end

    def verify_signature(signer, hash, apostille_hash)
      # TODO: support private apostille
      raise NotImplementedError, 'Not implemented private apostille'
    end

    # @return [Nem::Keypair] new key pair
    def self.generate(seed = SecureRandom.hex(32))
      unless seed =~ /\A\h{64}\z/ || seed =~ /\A\h{66}\z/
        raise ArgumentError, 'PrivateKey is not valid!'
      end
      new(seed)
    end

    private

    def fix_private_key(key)
      "#{'0' * 64}#{key.sub(/^00/i, '')}"[-64, 64]
    end

    def calc_public_key
      bin_public.unpack('H*').first
    end

    def bin_secret
      @bin_secret ||= Nem::Util::Convert.hex2bin_rev(fix_private_key(@private))
    end

    def bin_public
      @bin_public ||= Nem::Util::Ed25519.publickey_hash_unsafe(bin_secret)
    end
  end
end
