require "echorb/base"

module Echorb
  class Ticket < Echorb::Base
    attr_reader :ticket_status, :total_items, :items_updated,
                :percent_complete, :update_info
  end
end