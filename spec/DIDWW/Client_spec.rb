require 'spec_helper'
require 'DIDWW/client'

describe DIDWW::Client do
  let(:client) { described_class.new }

  before(:each) do
    allow(Savon::Client).to receive(:new).and_return(dummy_client)
    allow(dummy_client).to receive(:call)
  end

  let(:dummy_client) { instance_double Savon::Client }

  describe '#method_missing' do
    context "when the method is not a valid api endpoint" do
      subject { client.foo }

      it "raises an exception" do
        expect { subject }.to raise_error(NoMethodError)
      end
    end

    context "when the method is a valid api endpoint" do
      subject { client.auto_renew_status(customer_id: 0, did: 1111111111) }

      it "calls the api" do
        expect(dummy_client).to receive(:call)
        subject
      end
    end
  end
end
