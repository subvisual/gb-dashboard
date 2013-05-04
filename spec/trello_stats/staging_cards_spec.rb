require 'spec_helper'

describe TrelloStats::StagingCardsCount do
  context "#get_current_cards_number" do
    it "fetches the cards from trello board" do
      Trello::Member.should_receive(:find).with("zamith").and_call_original

      staging_stat_instance.get_current_cards_number
    end

    it "knows how many cards are at a given moment" do
      staging_stat_instance.stub_chain(:staging_list, :cards).and_return([1,2,3])

      staging_stat_instance.get_current_cards_number.should eq 3
    end
  end

  def staging_stat_instance
    @staging_stat_instance ||= TrelloStats::StagingCardsCount.new
  end
end
