require 'spec_helper'

describe Nem::Model::ProvisionNamespaceTransaction do

  describe '.new_from_transaction_meta_data_pair' do
    let(:hash) {
      {
        "meta": {
          "innerHash": {},
          "id": 147839,
          "hash": {
            "data": 'bc0192a74576b670f4b5a4bdab36e859155708e54eada5be00f652df68999cff'
          },
          "height": 1222191
        },
        "transaction": {
          "timeStamp": 84098535,
          "parent": nil,
          "signature": '5b3cadd3b6b9e67af1b76d3c4d99f0b65a695be8770cfedd4a9f2a8a9f791b55c397a91f9f918485ada4bb2758a5881fc3e1a0c73c5b15cac4ae7b3071aea704',
          "fee": 150000,
          "rentalFeeSink": 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35',
          "rentalFee": 100000000,
          "newPart": 'xesqua',
          "type": 8193,
          "deadline": 84102135,
          "version": -1744830463,
          "signer": '0efc3228277de0f8c6107bac5d183bcb3497d58edd632273f1d03cae7d8f852d'
        }
      }
    }

    subject { described_class.new_from_transaction_meta_data_pair(hash) }

    it { expect(subject).to be_a described_class }
    it { expect(subject.type).to eq 0x2001 }
  end
end
