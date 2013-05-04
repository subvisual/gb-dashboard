current_no_cards_in_staging = 0

SCHEDULER.every '10m', :first_in => 0 do |job|
  last_no_cards_in_staging = current_no_cards_in_staging
  current_no_cards_in_staging = TrelloStats::StagingCardsCount.new.get_current_cards_number

  send_event('coachme-staging', { current: current_no_cards_in_staging, last: last_no_cards_in_staging })
end

