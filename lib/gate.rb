class Gate
  NAME = [:umeda, :juusou, :shounai, :okamachi].freeze

  def initialize(name)
    @name = name
  end

  def enter(ticket)
    ticket.enter(@name)
  end

  def exit(ticket)
    station_number_from = Gate::NAME.index(ticket.from) + 1
    station_number_to   = Gate::NAME.index(@name) + 1
    section             = (station_number_to - station_number_from).abs
    if ticket.fee >= Ticket::FEE[section - 1]
      true
    else
      false
    end
  end
end
