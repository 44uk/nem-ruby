require 'spec_helper'

FIXTURES_PATH = File.expand_path('../fixtures', __FILE__)

describe Nem::ApostilleAudit do
  let(:file) { File.open(File.join(FIXTURES_PATH, 'nemLogoV2 -- Apostille TX c035c2603356852687c4730fbc6f8d21da3af7c4c0eb8b3619bc9ecdc833255a -- Date 2017-12-18.png')) }
  let(:apostille_hash) { 'fe4e545902cde315617a435ebfd5fe8875d699e2f2363262f5' }

  subject { described_class.new(file, apostille_hash) }

  describe '#valid?' do
    it { expect(subject.valid?).to be true }
  end
end
