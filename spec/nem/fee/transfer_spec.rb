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

  context '19,999.999999xem, no message' do
    let(:amount)  { 19_999.999999 }
    it { is_expected.to eq 50_000 }
  end

  context '20,000.000000xem, no message' do
    let(:amount)  { 20_000.000000 }
    it { is_expected.to eq 100_000 }
  end

  context '29,999.999999xem, no message' do
    let(:amount)  { 29_999.999999 }
    it { is_expected.to eq 100_000 }
  end

  context '30,000.000000xem, no message' do
    let(:amount)  { 30_000.000000 }
    it { is_expected.to eq 150_000 }
  end

  context '39,999.999999xem, no message' do
    let(:amount)  { 39_999.999999 }
    it { is_expected.to eq 150_000 }
  end

  context '40,000.000000xem, no message' do
    let(:amount)  { 40_000.000000 }
    it { is_expected.to eq 200_000 }
  end

  context '249,999.999999xem, no message' do
    let(:amount)  { 249_999.999999 }
    it { is_expected.to eq 1_200_000 }
  end

  context '250,000.000000xem, no message' do
    let(:amount)  { 250_000.000000 }
    it { is_expected.to eq 1_250_000 }
  end

  context '500,000.000000xem, no message' do
    let(:amount)  { 500_000.000000 }
    it { is_expected.to eq 1_250_000 }
  end

  context 'small business mosaic transfer' do
    let(:mosaic_klass) do
      Class.new do
        include Nem::Mixin::MosaicAttachable
        namespace_id 'sb'
        name 'mos'
        divisibility 0
        initial_supply 10_000
      end
    end

    context '1sb:mos, no message' do
      let(:mosaics) { [ mosaic_klass.new(1_000_000) ] }
      it { is_expected.to eq 50_000 }
    end

    context '10,000sb:mos, no message' do
      let(:mosaics) { [ mosaic_klass.new(10_000_000_000) ] }
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

    context '19,999.999999nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(19_999.999999) ] }
      it { is_expected.to eq 50_000 }
    end

    context '20,000.000000nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(20_000.000000) ] }
      it { is_expected.to eq 100_000 }
    end

    context '29,999.999999nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(29_999.999999) ] }
      it { is_expected.to eq 100_000 }
    end

    context '30,000.000000nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(30_000.000000) ] }
      it { is_expected.to eq 150_000 }
    end

    context '39,999.999999nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(39_999.999999) ] }
      it { is_expected.to eq 150_000 }
    end

    context '40,000.000000nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(40_000.000000) ] }
      it { is_expected.to eq 200_000 }
    end

    context '249,999.999999nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(249_999.999999) ] }
      it { is_expected.to eq 1_200_000 }
    end

    context '250,000.000000nem:xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(250_000.000000) ] }
      it { is_expected.to eq 1_250_000 }
    end

    context '500,000.000000xem, no message' do
      let(:mosaics) { [ Nem::Mosaic::Xem.new(500_000.000000) ] }
      it { is_expected.to eq 1_250_000 }
    end
  end

  context 'ns:mos transfer' do
    let(:mosaic_klass) do
      Class.new do
        include Nem::Mixin::MosaicAttachable
        namespace_id 'ns'
        name 'mos'
        divisibility 3
        initial_supply 9_000_000
      end
    end

    context '150.000ns:mos, no message' do
      let(:mosaics) { [ mosaic_klass.new(150) ] }
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

    # context '1ns:mos and 1nem:xem, no message' do
    #   let(:mosaics) {
    #     [ Nem::Mosaic::Xem.new(1_000_000), mosaic_klass.new(1_000) ]
    #   }
    #   it { is_expected.to eq 100_000 }
    # end
    #
    # context '1,222.212ns:mos and 19,999.000001nem:xem, no message' do
    #   let(:mosaics) {
    #     [ Nem::Mosaic::Xem.new(19_999_000_001), mosaic_klass.new(1_222_212) ]
    #   }
    #   it { is_expected.to eq 200_000 }
    # end
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context '1.000000xem, no message' do
      let(:amount) { 1.000000 }
      it { is_expected.to eq 50_000 }
    end

    context '1.000000xem, with message' do
      let(:amount) { 1.000000 }
      let(:message) { 'Good luck!' }
      it { is_expected.to eq 100_000 }
    end

    context '19,999.999999xem, no message' do
      let(:amount) { 19_999.999999 }
      it { is_expected.to eq 50_000 }
    end

    context '20,000.000000xem, no message' do
      let(:amount) { 20_000.000000 }
      it { is_expected.to eq 100_000 }
    end

    context '29,999.999999xem, no message' do
      let(:amount)  { 29_999.999999 }
      it { is_expected.to eq 100_000 }
    end

    context '30,000.000000xem, no message' do
      let(:amount)  { 30_000.000000 }
      it { is_expected.to eq 150_000 }
    end
  end
end
