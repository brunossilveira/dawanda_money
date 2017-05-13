class DawandaMoney
  include Arithmetic

  attr_reader :amount, :currency

  DEFAULT_CURRENCY = 'EUR'

  def self.conversion_rates(base_currency, rates)
    @rates ||= {}

    @rates[base_currency] = rates
  end

  def self.rates
    @rates
  end

  def initialize(amount, currency = DEFAULT_CURRENCY)
    @amount = amount.to_f
    @currency = currency
  end

  def inspect
    "#{amount} #{currency}"
  end

  def convert_to(currency)
    rate = self.class.rates.dig(currency, @currency)

    self.class.new(amount * rate, currency) if rate
  end
end
