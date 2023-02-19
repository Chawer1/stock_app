require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }
  let(:portfolio) { user.portfolios.create(name: 'My Portfolio') }
  let(:investment1) { Investment.create(portfolio: portfolio, symbol: 'AAPL', shares: 10, purchase_price: 100) }
  let(:investment2) { Investment.create(portfolio: portfolio, symbol: 'GOOG', shares: 5, purchase_price: 200) }

  describe '#current_value' do
    it 'returns the current value of all investments in the portfolio' do
      expect(portfolio.current_value).to eq(0)

      allow(investment1).to receive(:current_price).and_return(150)
      allow(investment2).to receive(:current_price).and_return(300)

      expect(portfolio.current_value).to eq(4500)
    end
  end

  describe '#daily_gain_loss' do
    it 'returns the daily gain or loss of all investments in the portfolio' do
      expect(portfolio.daily_gain_loss).to eq(0)

      allow(investment1).to receive(:current_price).and_return(150)
      allow(investment2).to receive(:current_price).and_return(300)

      expect(portfolio.daily_gain_loss).to eq(2500)
    end
  end

  describe '#overall_return' do
    it 'returns the overall return of the portfolio' do
      expect(portfolio.overall_return).to eq(0)

      allow(investment1).to receive(:current_price).and_return(150)
      allow(investment2).to receive(:current_price).and_return(300)

      expect(portfolio.overall_return).to eq(0.25)
    end
  end
end
