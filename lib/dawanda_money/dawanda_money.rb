class DawandaMoney
  include Comparable
  include Arithmetic

  attr_reader :amount, :currency

  DEFAULT_CURRENCY = 'EUR'

  def self.conversion_rates(base_currency, rates)
    @@base_currency = base_currency
    @@rates = rates
  end

  def initialize(amount, currency = DEFAULT_CURRENCY)
    @amount = amount.to_f
    @currency = currency
  end

  def inspect
    "#{amount} #{currency}"
  end

  def convert_to(currency)
    return self if currency == @currency

    if @@base_currency != currency
      rate = @@rates.dig(currency)

      new_amount = (amount * rate).round(2)

      self.class.new(new_amount, currency)
    else
      rate = @@rates.dig(@currency)

      new_amount = (amount / rate).round(2)

      self.class.new(new_amount, currency)
    end
  end
end

