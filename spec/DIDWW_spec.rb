require 'spec_helper'

describe DIDWW do
  it 'has a version number' do
    expect(DIDWW::VERSION).not_to be nil
  end

  describe '.configure' do
    subject do
      described_class.configure do |config|
        config.api_username = 'test@test.ca'
        config.api_key = 'test_key'
        config.sandbox = false
      end
    end

    it "changes the configuration" do
      subject
      expect(described_class.configuration.api_username).to eq 'test@test.ca'
      expect(described_class.configuration.api_key).to eq 'test_key'
      expect(described_class.configuration.sandbox).to be false
    end
  end

  describe '.reset' do
    subject { described_class.reset }

    before(:each) do
      described_class.configuration.api_key = 'test_key'
    end

    it "resets the configuration" do
      subject
      expect(described_class.configuration.api_key).not_to eq 'test_key'
    end
  end

  describe '.mode' do
    subject { described_class.mode }

    context "when sandbox is set to true" do
      before(:each) do
        described_class.configuration.sandbox = true
      end

      it "returns :sandbox" do
        expect(subject).to eq :sandbox
      end
    end

    context "when sandbox is set to false" do
      before(:each) do
        described_class.configuration.sandbox = false
      end

      it "returns :live" do
        expect(subject).to eq :live
      end
    end
  end

  describe '.sandbox?' do
    subject { described_class.sandbox? }

    context "when in sandbox mode" do
      before(:each) do
        described_class.configuration.sandbox = true
      end

      it "returns true" do
        expect(subject).to be true
      end
    end

    context "when not in sandbox mode" do
      before(:each) do
        described_class.configuration.sandbox = false
      end

      it "returns false" do
        expect(subject).to be false
      end
    end
  end

  describe '.live?' do
    subject { described_class.live? }

    context "when in sandbox mode" do
      before(:each) do
        described_class.configuration.sandbox = true
      end

      it "returns false" do
        expect(subject).to be false
      end
    end

    context "when not in sandbox mode" do
      before(:each) do
        described_class.configuration.sandbox = false
      end

      it "returns true" do
        expect(subject).to be true
      end
    end
  end
end
