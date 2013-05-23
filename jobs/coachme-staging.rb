class CardsDelta < Struct.new :out, :in
  def go
    self.out = TrelloStats::StagingCardsCount.new.gone_out
    self.in = TrelloStats::StagingCardsCount.new.came_in
    self.out - self.in
  end
end

cards_delta = CardsDelta.new
no_cards_in_staging_delta = cards_delta.go

SCHEDULER.every '30m', :first_in => 0 do |job|
  last_no_cards_in_staging_delta = no_cards_in_staging_delta
  no_cards_in_staging_delta = cards_delta.go

  send_event('coachme-staging', { current: no_cards_in_staging_delta, last: last_no_cards_in_staging_delta })
end

