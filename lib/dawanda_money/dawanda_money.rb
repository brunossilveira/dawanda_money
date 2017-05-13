class DawandaMoney
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
    @amount = amount
    @currency = currency
  end

  def inspect
    "#{amount.to_f} #{currency}"
  end
end
