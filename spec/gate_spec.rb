require "spec_helper"
require "gate"
require "ticket"

describe Gate do
  let(:one_section_ticket) { Ticket.new(Ticket::FEE[0]) }
  let(:two_section_ticket) { Ticket.new(Ticket::FEE[1]) }
  let(:three_section_ticket) { Ticket.new(Ticket::FEE[2]) }

  let(:umeda) { Gate.new(Gate::NAME[0]) }
  let(:juusou) { Gate.new(Gate::NAME[1]) }
  let(:shounai) { Gate.new(Gate::NAME[2]) }
  let(:okamachi) { Gate.new(Gate::NAME[3]) }

  describe "#exit" do
    it "1区間・出場成功" do
      umeda.enter(one_section_ticket)
      expect(juusou.exit(one_section_ticket)).to be_truthy
    end

    it "2区間・運賃不足" do
      umeda.enter(one_section_ticket)
      expect(shounai.exit(one_section_ticket)).to be_falsey
    end

    it "2区間・運賃ちょうど" do
      umeda.enter(two_section_ticket)
      expect(shounai.exit(two_section_ticket)).to be_truthy
    end

    it "2区間・運賃過多" do
      umeda.enter(three_section_ticket)
      expect(shounai.exit(three_section_ticket)).to be_truthy
    end

    it "3区間・運賃不足" do
      umeda.enter(two_section_ticket)
      expect(okamachi.exit(two_section_ticket)).to be_falsey
    end

    it "3区間・運賃ちょうど" do
      umeda.enter(three_section_ticket)
      expect(okamachi.exit(three_section_ticket)).to be_truthy
    end

    it "梅田以外の駅から乗車・運賃不足" do
      juusou.enter(one_section_ticket)
      expect(okamachi.exit(one_section_ticket)).to be_falsey
    end

    it "梅田以外の駅から乗車・運賃ちょうど" do
      juusou.enter(two_section_ticket)
      expect(okamachi.exit(two_section_ticket)).to be_truthy
    end

    # it "上り"
    #
    it "同じ駅で降りる" do
      umeda.enter(one_section_ticket)
      expect { umeda.exit(one_section_ticket) }.to raise_error(ExitSameStationError)
    end

    # it "一度入場した切符でもう一度入場する" do
    #   umeda.enter(one_section_ticket)
    #   expect { umeda.enter(one_section_ticket) }.to raise_error(AlreadyEnteredError)
    # end
    #
    # it "使用済みの切符でもう一度出場する"
    #
    # it "改札を通っていない切符で出場する"
  end
end
