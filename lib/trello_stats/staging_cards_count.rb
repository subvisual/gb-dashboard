require './lib/monkey_patches.rb'

module TrelloStats
  class StagingCardsCount
    def gone_out
      filtered_actions(:list_after_name, "Launchpad").size
    end

    def came_in
      filtered_actions(:list_before_name, "Code Review").size
    end

    private

    def filtered_actions(filter_name, filter_value)
      actions.select do |action|
        send(filter_name, action) == filter_value
      end
    end

    ["listAfter", "listBefore"].each do |attr_name|
      define_method "#{attr_name.underscore}_name" do |action|
        if action.attributes[:data][attr_name]
          action.attributes[:data][attr_name]["name"]
        end
      end
    end

    def actions
      @actions ||= staging_list.actions
    end

    def staging_list
      @staging_list ||= current_dev_board.lists.select{|list| list.name == "Test on Staging"}.first
    end

    def current_dev_board
      @current_dev_board ||= coachme_organization.boards.select{|board| board.name == "CoachMe Current Development"}.first
    end

    def coachme_organization
      @coachme_organization ||= Trello::Member.find("zamith").organizations.select{|org| org.name == "coachmeapps"}.first
    end
  end
end
