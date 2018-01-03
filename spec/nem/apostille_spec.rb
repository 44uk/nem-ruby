require 'spec_helper'

FIXTURES_PATH = File.expand_path('../fixtures', __FILE__)

describe Nem::Apostille do
  before { Timecop.freeze Time.utc(2015, 3, 29, 0, 6, 25, 0) }
  after  { Timecop.return }

  let(:private_key) { '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214' }
  let(:keypair) { Nem::Keypair.new(private_key) }
  let(:file) { File.open(File.join(FIXTURES_PATH, 'nemLogoV2.png')) }

  context 'public apostille' do
    before { subject.transaction }
    let(:transaction_hash) { 'c1a07469e63b54ae64f376e4f6266a5ea63213b41655030cd7113f42b9690cd4' }
    let(:message) do
      Nem::Model::Message.new('fe4e545903f1007272252a69dc54e09d5caf6dc2844ae77b27773f61905ae49865ceb89ded')
    end

    subject { described_class.new(keypair, file, :sha256) }

    it { expect(subject.signed?).to be false }

    describe '#transaction.message' do
      it { expect(subject.transaction.message).to eq message }
    end

    describe '#apostille_format' do
      it { expect(subject.apostille_format(transaction_hash)).to eq "nemLogoV2 -- Apostille TX #{transaction_hash} -- Date 2015-03-29.png" }
    end
  end

  context 'private apostille' do
    before { subject.transaction }
    let(:transaction_hash) { 'c1a07469e63b54ae64f376e4f6266a5ea63213b41655030cd7113f42b9690cd4' }
    let(:message) do
      Nem::Model::Message.new('fe4e545983508e60122bf6e8cb614e9a58209782a1f65ba3d00a153cf9395af64b5d234413417d981b6b21b7ca75ac374eb3b7ea37d9d53ed5af17825c5fb3142652cc0705')
    end

    subject { described_class.new(keypair, file, :sha256, signed: true) }

    it { expect(subject.signed?).to be true }

    describe '#transaction.message' do
      it { expect(subject.transaction.message).to eq message }
    end

    describe '#dedicated_keypair.private' do
      it { expect(subject.dedicated_keypair.private).to eq '6766ee9ceca5f255cd458dda56edad7fa6816cd8dd5a5a9b5e50f5fcb39e0204' }
    end
  end
end
