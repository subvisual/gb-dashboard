require 'spec_helper'
Action = Struct.new :attributes

describe TrelloStats::StagingCardsCount do
  context "#gone_out" do
    it "fetches the cards from trello board", slow: true do
      Trello::Member.should_receive(:find).with("zamith").and_call_original

      staging_stat_instance.gone_out
    end

    it "knows how many cards have gone out into Launchpad" do
      actions = [
        Action.new({data:{"listAfter"=>{"name"=>"Launchpad"}}}),
        Action.new({data:{"listAfter"=>{"name"=>"Launchpad"}}})
      ]
      staging_stat_instance.should_receive(:actions).and_return(actions)

      staging_stat_instance.gone_out.should eq 2
    end

    it "only count the ones going to the Launchpad" do
      actions = [
        Action.new({data:{"listAfter"=>{"name"=>"Launchpad"}}}),
        Action.new({data:{"listAfter"=>{"name"=>"Launchpad"}}}),
        Action.new({data:{"listAfter"=>{"name"=>"Another List"}}}),
        Action.new({data:{"listBefore"=>{"name"=>"Other List"}}})
      ]
      staging_stat_instance.should_receive(:actions).and_return(actions)

      staging_stat_instance.gone_out.should eq 2
    end
  end

  def staging_stat_instance
    @staging_stat_instance ||= TrelloStats::StagingCardsCount.new
  end
end
