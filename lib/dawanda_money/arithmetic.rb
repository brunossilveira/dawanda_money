class DawandaMoney
  module Arithmetic
    def <=>(object)
      raise 'Can only compare two instances from DewandaMoney' unless object.is_a?(DawandaMoney)

      converted = object.convert_to(currency)

      amount <=> converted.amount
    end

    [:+, :-].each do |method|
      define_method(method) do |object|
        raise TypeError unless object.is_a?(DawandaMoney)

        converted = object.convert_to(currency)

        self.class.new(amount.public_send(method, converted.amount), currency)
      end
    end

    [:*, :/].each do |method|
      define_method(method) do |val|
        raise TypeError unless val.is_a?(Numeric)

        self.class.new(amount.public_send(method, val), currency)
      end
    end
  end
end
