require "spec_helper"

RSpec.describe DawandaMoney do
  it "has a version number" do
    expect(DawandaMoney::VERSION).not_to be nil
  end

  describe '#initialize' do
    let(:amount) { 10 }

    context 'when currency is passed' do
      let(:currency) { 'USD' }

      subject { described_class.new(amount, currency) }

      it 'initializes object correctly' do
        expect(subject.amount).to eq(amount)
        expect(subject.currency).to eq(currency)
      end
    end

    context 'when currency is not passed' do
      subject { described_class.new(amount) }

      it 'initializes object correctly' do
        expect(subject.amount).to eq(amount)
        expect(subject.currency).to eq(described_class::DEFAULT_CURRENCY)
      end
    end
  end

  describe '#inspect' do
    let(:amount) { 10 }
    let(:currency) { 'EUR' }

    subject { described_class.new(amount, currency).inspect }

    it 'prints information correctly' do
      expect(subject).to eq("#{amount.to_f} #{currency}")
    end
  end
end
