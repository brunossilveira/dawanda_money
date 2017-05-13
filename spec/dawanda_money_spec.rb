require "spec_helper"

RSpec.describe DawandaMoney do
  it "has a version number" do
    expect(DawandaMoney::VERSION).not_to be nil
  end

  describe '.conversion_rates' do
    let(:base_currency)  { 'EUR' }
    let(:rates) do
      {
        'USD' => 1.11,
        'Bitcoin' => 0.0047
      }
    end

    subject { described_class.conversion_rates(base_currency, rates) }

    it 'sets up values correcly' do
      subject

      expect(described_class.rates).to eq({ base_currency => rates})
    end
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

  describe '#convert_to' do
    let(:currency) { 'USD' }
    let(:amount) { 50 }

    subject { described_class.new(amount, currency).convert_to(conversion_currency) }

    context 'when currency exists' do
      let(:conversion_currency) { 'EUR' }
      let(:base_currency)  { 'EUR' }
      let(:rates) do
        {
          'USD' => 2
        }
      end

      before do
        described_class.conversion_rates(base_currency, rates)
      end

      it 'converts correctly' do
        expect(subject.class).to eq(described_class)
        expect(subject.amount).to eq(100.0)
      end
    end

    context 'when currency does not exist' do
      let(:conversion_currency) { 'wrong' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
