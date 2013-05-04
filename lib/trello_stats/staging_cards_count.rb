module TrelloStats
  class StagingCardsCount

    def get_current_cards_number
      staging_list.cards.size
    end

    private

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
