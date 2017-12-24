require 'spec_helper'

describe Nem::Model::MosaicDefinitionCreationTransaction do

  describe '.new_from_transaction_meta_data_pair' do
    let(:hash) {
      {
        "meta": {
          "innerHash": {},
            "id": 147657,
            "hash": {
              "data": '68339d61b748e551d076faf6e0ce7a8c2a094c4494305eaf8810cff1f0c5f58c'
            },
            "height": 1220283
        },
        "transaction": {
          "timeStamp": 83982721,
          "creationFee": 10000000,
          "mosaicDefinition": {
            "creator": '43637c03a21c90f1a72c3b718e1a6985a815860412fa14c7fbed6c5e1a5f6206',
            "description": 'levy test',
            "id": {
              "namespaceId": 'tpico',
              "name": 'levy'
            },
            "properties": [
            {
              "name": 'divisibility',
              "value": '3'
            },
            {
              "name": 'initialSupply',
              "value": '530000'
            },
            {
              "name": 'supplyMutable',
              "value": 'true'
            },
            {
              "name": 'transferable',
              "value": 'true'
            }
            ],
            "levy": {
              "fee": 1,
              "recipient": 'TDPICOQ7GIEMIDJOOMIQSOYIJKG3C7V7OP2DUFIR',
              "type": 1,
              "mosaicId": {
                "namespaceId": 'nem',
                "name": 'xem'
              }
            }
          },
          "signature": 'd201b362b7d363828d4cd5146d632e4eb74fe68e660400a65bd415d14de0eea4ab2a46c782749738814b18352080458828095939a871740920c012dd260ca104',
          "fee": 150000,
          "creationFeeSink": 'TBMOSAICOD4F54EE5CDMR23CCBGOAM2XSJBR5OLC',
          "type": 16385,
          "deadline": 83986321,
          "version": -1744830463,
          "signer": '43637c03a21c90f1a72c3b718e1a6985a815860412fa14c7fbed6c5e1a5f6206'
        }
      }
    }

    subject { described_class.new_from_transaction_meta_data_pair(hash) }

    it { expect(subject).to be_a described_class }
    it { pp subject.inspect; expect(subject.type).to eq 0x4001 }
  end
end
