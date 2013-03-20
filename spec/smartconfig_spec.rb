require_relative 'spec_helper'

describe SmartConfig do
  let(:fake_settings_adapter) { double() }
  subject { described_class.new(fake_settings_adapter) }

  context 'constructor' do
    it 'yields if block given' do
      expect { |block|
        described_class.new({}, &block)
      }.to yield_control
    end
  end

  context 'load' do
    it 'iterates over provided adapters' do
      fake_settings_adapter.should_receive(:each)
      subject.load
    end

    it 'tries to store setting'
  end

  context 'keys during setup' do
    it 'cannot be added twice' do
      subject.add_key :test
      expect {
        subject.add_key :test
      }.to raise_error
    end

    it 'can be mandatory' do
      expect {
        subject.add_key :test, :mandatory => true
      }.not_to raise_error
    end
  end

  context '#add_key' do
    it 'creates Setting when called' do
      SmartConfig::Setting.should_receive(:new).and_call_original
      subject.add_key :any_name
    end
  end


  context 'setting with default' do
    it 'can be defined' do
      expect {
        subject.add_key :test, :default => true
      }.not_to raise_error
    end

    it 'is overriden when provided' do
      fake_settings_adapter.stub(:each) do |&block|
        block.call [:test, 'setting_value']
      end

      subject.add_key :test, :default => 'default_value'
      subject.load
      expect(subject.test).to eq('setting_value')
    end

    it 'is set to default when omitted' do
      fake_settings_adapter.stub(:each)

      subject.add_key :test, :default => 'default_value'
      subject.load
      expect(subject.test).to eq('default_value')
    end
  end
end
