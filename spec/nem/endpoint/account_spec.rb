require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Account do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#historical' do
    subject { endpoint.historical('NALICELGU3IVY4DPJKHYLSSVYFFWYS5QPLYEZDJJ',
      start_height: 17592,
      end_height: 17592,
      increment: 1
    ) }
    it { is_expected.to be_a Array }
  end

  describe '#generate' do
    subject { endpoint.generate }
    it { is_expected.to be_a Nem::Model::Keypair }
    it { expect(subject.public_key).to eq 'a567f3fb61c81e75643e8c11984abb1039341868e657397b5a33bf14d045cf49' }
  end

  describe '#find' do
    context 'with TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' do
      subject { endpoint.find('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS') }
      it { is_expected.to be_a Nem::Model::Account }
      it { expect(subject.public_key).to eq 'a11a1a6c17a24252e674d151713cdf51991ad101751e4af02a20c61b59f1fe1a' }
    end
  end

  describe '#get' do
    context 'with TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' do
      subject { endpoint.get('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS') }
      it { is_expected.to be_a Nem::Model::Account }
      it { expect(subject.public_key).to eq 'a11a1a6c17a24252e674d151713cdf51991ad101751e4af02a20c61b59f1fe1a' }
    end
  end

  describe '#find_by_public_key' do
    context 'with a11a1a6c17a24252e674d151713cdf51991ad101751e4af02a20c61b59f1fe1a' do
      subject { endpoint.find_by_public_key('a11a1a6c17a24252e674d151713cdf51991ad101751e4af02a20c61b59f1fe1a') }
      it { is_expected.to be_a Nem::Model::Account }
      it { expect(subject.address).to eq 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' }
    end
  end

  describe '#harvests' do
    context 'with TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' do
      subject { endpoint.harvests('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS') }
      it { is_expected.to be_a Array }
    end
  end

  describe '#importances' do
    context 'with ' do
      subject { endpoint.importances }
      it { is_expected.to be_a Array }
    end
  end

  describe '#status' do
    context 'with TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' do
      subject { endpoint.status('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS') }
      it { is_expected.to be_a Nem::Model::Account }
    end
  end

  describe '#transfers_incoming' do
    context 'with TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' do
      subject { endpoint.transfers_incoming('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS') }
      it { is_expected.to be_a Array }
    end
  end

  describe '#transfers_outgoing' do
    context 'with TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' do
      subject { endpoint.transfers_outgoing('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS') }
      it { is_expected.to be_a Array }
    end
  end

  describe '#transfer_unconfirmed' do
    context 'with TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' do
      subject { endpoint.transfers_unconfirmed('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS') }
      it { is_expected.to be_a Array }
    end
  end

  describe '#transfer_all' do
    context 'with TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' do
      subject { endpoint.transfers_all('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS') }
      it { is_expected.to be_a Array }
    end
  end

  describe '#namespace' do
    context 'with TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH, makoto.metal' do
      subject { endpoint.namespace('TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH', parent: 'makoto.metal') }
      it { is_expected.to be_a Array }
    end
  end

  describe '#mosaic_definition' do
    context 'with TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH, makoto.metal.coins' do
      subject { endpoint.mosaic_definition('TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH', parent: 'makoto.metal.coins') }
      it { is_expected.to be_a Array }
    end
  end

  describe '#mosaic_owned' do
    context 'with TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH' do
      subject { endpoint.mosaic_owned('TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH') }
      it { is_expected.to be_a Array }
    end
  end
end
