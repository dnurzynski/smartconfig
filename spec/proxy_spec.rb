require 'spec_helper'

describe SmartConfig::Proxy do
  let(:config) { double() }
  subject { described_class.new(config) }

  it 'sets key on config object' do
    config.should_receive(:add_key).with(:keyname)

    subject.key :keyname
  end
end
