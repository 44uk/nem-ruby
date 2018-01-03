require 'digest/md5'
require 'digest/sha1'
require 'digest/sha2'
require 'digest/sha3'

class Nem::Apostille
  CHECKSUM = 'fe4e5459'.freeze

  attr_reader :dedicated_keypair

  # @param [Nem::Keypair] keypair
  # @param [String] file - The file
  # @param [Symbol] hashing - An hashing type (md5, sha1, sha256, sha3-256, sha3-512)
  # @param [Boolean] multisig - true if transaction is multisig, false otherwise
  # @param [Symbol] signed - true if apostille is private / transferable / updateable, false if public
  def initialize(keypair, file, hashing = :sha256, multisig: false, signed: false, network: nil)
    @keypair = keypair
    @file = file
    @hashing = hashing
    @multisig = multisig
    @signed = signed
    @network = network || Nem.default_network

    # TDOD: support multisig apostille
    raise NotImplementedError, 'Sorry, Not yet multisig apostille' if multisig?
  end

  def signed?
    @signed
  end

  def multisig?
    @multisig
  end

  def transaction
    if signed?
      @dedicated_keypair = generate_keypair
      apostille_hash = header << @keypair.sign(calc_hash)
      dedicated_address = Nem::Unit::Address.from_public_key(@dedicated_keypair.public, @network)
    else
      apostille_hash = header << calc_hash
      dedicated_address = apostille[:sink]
    end

    # TDOD: support multisig apostille
    Nem::Transaction::Transfer.new(dedicated_address, 0, apostille_hash)
  end

  def apostille_format(transaction_hash)
    ext = File.extname(@file.path)
    name = File.basename(@file.path, ext)
    date = Date.today.strftime('%Y-%m-%d')
    '%s -- Apostille TX %s -- Date %s%s' % [
      name,
      transaction_hash,
      date,
      ext
    ]
  end

  private

  def generate_keypair
    filename = File.basename(@file.path)
    signed_filename = @keypair.sign(Digest::SHA256.hexdigest(filename))
    signed_filename = "#{'0' * 64}#{signed_filename.sub(/^00/i, '')}"[-64, 64]
    Nem::Keypair.new(signed_filename)
  end

  def header
    "#{CHECKSUM}#{hex_type}"
  end

  def calc_hash
    hashed = case @hashing
             when /\Amd5\z/      then Digest::MD5.file(@file)
             when /\Asha1\z/     then Digest::SHA1.file(@file)
             when /\Asha256\z/   then Digest::SHA256.file(@file)
             when /\Asha3-256\z/ then Digest::SHA3.file(@file, 256)
      else Digest::SHA3.file(@file, 512)
    end
    hashed.hexdigest
  end

  def algo
    case @hashing
    when /\Amd5\z/      then 0x01
    when /\Asha1\z/     then 0x02
    when /\Asha256\z/   then 0x03
    when /\Asha3-256\z/ then 0x08
    when /\Asha3-512\z/ then 0x09
      else raise "Undefined hashing: #{@hashing}"
    end
  end

  def version
    signed? ? 0x80 : 0x00
  end

  def hex_type
    '%02x' % (version | algo)
  end

  def apostille
    raise 'No need SINK Address for private apostille.' if signed?
    if @network == :mainnet
      { private_key: nil,
        sink: 'NCZSJHLTIMESERVBVKOW6US64YDZG2PFGQCSV23J' }
    else
      { private_key: nil,
        sink: 'TC7MCY5AGJQXZQ4BN3BOPNXUVIGDJCOHBPGUM2GE' }
    end
  end
end
