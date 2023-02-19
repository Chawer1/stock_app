# frozen_string_literal: true

require 'net/http'

class Investment < ApplicationRecord
  belongs_to :portfolio

  def current_price
    uri = URI.parse("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{ENV['ALPHA_VANTAGE_API_KEY']}")
    response = Net::HTTP.get_response(uri)
    if response.code == '200'
      data = JSON.parse(response.body)
      data.dig('Global Quote', '05. price').to_f
    else
      raise "Error fetching data from Alpha Vantage API: #{response.code} - #{response.body}"
    end
  rescue StandardError => e
    Rails.logger.error("Error fetching current price for #{symbol}: #{e.message}")
    nil
  end
end
