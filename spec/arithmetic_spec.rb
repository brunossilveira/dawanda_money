require 'spec_helper'

RSpec.describe DawandaMoney::Arithmetic do
  let(:base_currency)  { 'EUR' }
  let(:rates) do
    {
      'USD' => 1.11,
      'Bitcoin' => 0.0047
    }
  end
  let(:zero_eur) { DawandaMoney.new(0, 'EUR') }
  let(:one_eur) { DawandaMoney.new(1, 'EUR') }
  let(:fifty_eur) { DawandaMoney.new(50, 'EUR') }
  let(:sixty_eur) { DawandaMoney.new(60, 'EUR') }
  let(:one_hundred_eur) { DawandaMoney.new(100, 'EUR') }
  let(:twenty_dollars) { DawandaMoney.new(20, 'USD') }

  before do
    DawandaMoney.conversion_rates(base_currency, rates)
  end

  describe '#==' do
    it 'compares correctly' do
      expect(fifty_eur).to eq(fifty_eur.convert_to('USD'))
      expect(fifty_eur).to eq(fifty_eur.convert_to('EUR'))
      expect(fifty_eur).not_to eq(sixty_eur)
      expect(fifty_eur).not_to eq(twenty_dollars)
      expect(fifty_eur).not_to eq(twenty_dollars.convert_to('EUR'))
    end
  end

  describe '#<=>' do
    it 'compares correctly' do
      expect(fifty_eur <=> fifty_eur).to eq(0)
      expect(fifty_eur <=> twenty_dollars).to eq(1)
      expect(fifty_eur <=> sixty_eur).to eq(-1)
    end
  end

  describe '#+' do
    it 'sums values correctly' do
      expect((fifty_eur + fifty_eur).class).to eq(DawandaMoney)
      expect(fifty_eur + fifty_eur).to eq(one_hundred_eur)
      expect(fifty_eur + fifty_eur.convert_to('USD')).to eq(one_hundred_eur)
    end
  end

  describe '#-' do
    it 'subtracts values correctly' do
      expect((fifty_eur - fifty_eur).class).to eq(DawandaMoney)
      expect(fifty_eur - fifty_eur).to eq(zero_eur)
      expect(fifty_eur - fifty_eur.convert_to('USD')).to eq(zero_eur)
    end
  end

  describe '#*' do
    it 'multiplies values correctly' do
      expect((fifty_eur * 2).class).to eq(DawandaMoney)
      expect(fifty_eur * 2).to eq(one_hundred_eur)
    end
  end

  describe '#/' do
    it 'divides values correctly' do
      expect((fifty_eur / 50).class).to eq(DawandaMoney)
      expect(fifty_eur / 50).to eq(one_eur)
    end
  end
end
