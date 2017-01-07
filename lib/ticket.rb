class Ticket
  FEE = [150, 180, 220].freeze

  attr_reader :from, :fee

  def initialize(fee)
    @fee  = fee
    @from = nil
  end

  def enter(name)
    @from = name
  end
end
