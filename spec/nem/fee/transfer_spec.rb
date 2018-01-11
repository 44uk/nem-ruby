require 'spec_helper'

describe Nem::Fee::Transfer do
  let(:recipient) { 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF' }
  let(:amount)  { 1 }
  let(:message) { '' }
  let(:network) { :testnet }
  let(:tx) do
    Nem::Transaction::Transfer.new(
      recipient,
      amount,
      message,
      mosaics: mosaics,
      network: network
    )
  end
  let(:mosaics) { [] }
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context '1xem, no message' do
    it { is_expected.to eq 50_000 }
  end

  context '1xem, with message' do
    let(:message) { 'Good luck!' }
    it { is_expected.to eq 100_000 }
  end

  context '19,999xem, no message' do
    let(:amount)  { 19_999_000_000 }
    it { is_expected.to eq 50_000 }
  end

  context '20,000xem, no message' do
    let(:amount)  { 20_000_000_000 }
    it { is_expected.to eq 100_000 }
  end

  context 'small business mosaic transfer' do
    let(:mosaic_klass) do
      Class.new do
        include Nem::Mixin::MosaicAttachable
        namespace_id 'smallbusiness'
        name 'mosaic'
        divisibility 0
        initial_supply 10_000
      end
    end

    context '1ns:mos, no message' do
      let(:mosaics) { [ mosaic_klass.new(1_000_000) ] }
      it { is_expected.to eq 50_000 }
    end
  end

  context 'nem:xem transfer' do
    let(:mosaic_klass) do
      [
        Nem::Model::MosaicAttachment.new(
          mosaic_id: Nem::Model::MosaicId.new(
            namespace_id: 'nem', name: 'xem'
          ),
          properties: Nem::Model::MosaicProperties.new(
            divisibility: 6,
            initial_supply: 8_999_999_999,
            supply_mutable: false,
            transferable: true
          ),
          quantity: 1_000_000
        )
      ]
    end

    context '1nem:xem, no message' do
      it { is_expected.to eq 50_000 }
    end

    context '19,999nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(19_999_000_000) ] }
      it { is_expected.to eq 50_000 }
    end

    context '20,000nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(20_000_000_000) ] }
      it { is_expected.to eq 100_000 }
    end
  end

  context 'ns:mos transfer' do
    let(:mosaic_klass) do
      Class.new do
        include Nem::Mixin::MosaicAttachable
        namespace_id 'foo'
        name 'bar'
        divisibility 3
        initial_supply 100_000_000
      end
    end

    context '1,222.212ns:mos, no message' do
      let(:mosaics) { [ mosaic_klass.new(1_222_212) ] }
      it { is_expected.to eq 100_000 }
    end

    context '1,333.323ns:mos, no message' do
      let(:mosaics) { [ mosaic_klass.new(1_333_323) ] }
      it { is_expected.to eq 150_000 }
    end
  end

  context 'nem:xem and ns:mos transfer' do
    let(:mosaic_klass) do
      Class.new do
        include Nem::Mixin::MosaicAttachable
        namespace_id 'foo'
        name 'bar'
        divisibility 3
        initial_supply 100_000_000
      end
    end

    context '1ns:mos and 1nem:xem, no message' do
      let(:mosaics) {
        [ Nem::Mosaic::Xem.new(1_000_000), mosaic_klass.new(1_000) ]
      }
      it { is_expected.to eq 100_000 }
    end

    context '1,222.212ns:mos and 19,999.000001nem:xem, no message' do
      let(:mosaics) {
        [ Nem::Mosaic::Xem.new(19_999_000_001), mosaic_klass.new(1_222_212) ]
      }
      it { is_expected.to eq 200_000 }
    end
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context '1xem, no message' do
      it { is_expected.to eq 50_000 }
    end

    context '1xem, with message' do
      let(:message) { 'Good luck!' }
      it { is_expected.to eq 100_000 }
    end

    context '19,999xem, no message' do
      it { is_expected.to eq 50_000 }
    end

    context '20,000xem, no message' do
      let(:amount) { 20_000_000_000 }
      it { is_expected.to eq 100_000 }
    end
  end
end
