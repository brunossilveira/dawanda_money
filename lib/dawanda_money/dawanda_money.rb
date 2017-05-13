class DawandaMoney
  DEFAULT_CURRENCY = 'EUR'

  attr_reader :amount, :currency

  def initialize(amount, currency = DEFAULT_CURRENCY)
    @amount = amount
    @currency = currency
  end

  def inspect
    "#{amount.to_f} #{currency}"
  end
end
