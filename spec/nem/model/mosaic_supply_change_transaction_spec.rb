require 'spec_helper'

describe Nem::Model::MosaicSupplyChangeTransaction do

  describe '.new_from_transaction_meta_data_pair' do
    let(:hash) {
      {
        "meta": {
          "innerHash": {},
          "id": 147838,
          "hash": {
            "data": 'd857ce3cbb68a661a01885fbe74d0ec66ead901419f7dd41a41181ea35908165'
          },
          "height": 1222180
        },
        "transaction": {
          "timeStamp": 84097819,
          "signature": '955bfe368f4008006341448284041029a65eb6d5f30b70b61c4030d6cfbc3dd268e8cb8551fef7cd56b8fa5b5b3f8230d9692fb76a0afae2d348db6bb5e9c002',
          "fee": 150000,
          "supplyType": 1,
          "delta": 5000,
          "type": 16386,
          "deadline": 84101419,
          "mosaicId": {
            "namespaceId": 'sushi',
            "name": 'maguro'
          },
          "version": -1744830463,
          "signer": '0efc3228277de0f8c6107bac5d183bcb3497d58edd632273f1d03cae7d8f852d'
        }
      }
    }

    subject { described_class.new_from_transaction_meta_data_pair(hash) }

    it { expect(subject).to be_a described_class }
    it { expect(subject.type).to eq 0x4002 }
  end
end
