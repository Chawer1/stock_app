require 'rails_helper'
# rubocop:disable Metrics/LineLength
RSpec.describe Investment, type: :model do
  describe '#current_price' do
    let(:investment) { create(:investment, symbol: 'AAPL') }

    context 'when the API request succeeds' do
      before do
        stub_request(:get, "https://www.alphavantage.co/query?apikey=#{ENV['ALPHA_VANTAGE_API_KEY']}&function=GLOBAL_QUOTE&symbol=AAPL")
          .to_return(status: 200, body: {
            "Global Quote": {
              "05. price": "135.73"
            }
          }.to_json)
      end

      it 'returns the current price of the investment' do
        expect(investment.current_price).to eq(135.73)
      end
    end

    context 'when the API request fails' do
      before do
        stub_request(:get, "https://www.alphavantage.co/query?apikey=#{ENV['ALPHA_VANTAGE_API_KEY']}&function=GLOBAL_QUOTE&symbol=AAPL")
          .to_return(status: 500, body: 'Internal Server Error')
      end

      it 'returns nil' do
        expect(investment.current_price).to be_nil
      end

      it 'logs the error' do
        expect(Rails.logger).to receive(:error).with("Error fetching current price for AAPL: Error fetching data from Alpha Vantage API: 500 - Internal Server Error")
        investment.current_price
      end
    end
    # rubocop:enable Metrics/LineLength
  end
end
