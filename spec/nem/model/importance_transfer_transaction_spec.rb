require 'spec_helper'

describe Nem::Model::ImportanceTransferTransaction do

  describe '.new_from_transaction_meta_data_pair' do
    let(:hash) {
      {
        "meta": {
          "innerHash": {},
          "id": 147837,
          "hash": {
            "data": '4b5cec14d28a16edd3b0a3b2db2ce27134b4ac34a23ce335b7419ce3f30da893'
          },
          "height": 1222155
        },
        "transaction": {
          "timeStamp": 84096738,
          "mode": 2,
          "signature": '0fc3aa104e17fd9a34dcb45ac6941f66367565b41d75b3dc0650982b319786c0941f4df94290a096970f9b3f63af57413b3480a4f158b58597c1ed73d394df02',
          "fee": 150000,
          "remoteAccount": '183ee031f40f7cc7736e1d7193b46ec32b2a58666788cfa76d9f16781a26c5ed',
          "type": 2049,
          "deadline": 84100338,
          "version": -1744830463,
          "signer": '0efc3228277de0f8c6107bac5d183bcb3497d58edd632273f1d03cae7d8f852d'
        }
      }
    }

    subject { described_class.new_from_transaction_meta_data_pair(hash) }

    it { expect(subject).to be_a Nem::Model::ImportanceTransferTransaction }
    it { expect(subject.type).to eq 0x0801 }
  end
end
