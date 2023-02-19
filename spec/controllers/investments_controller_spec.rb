# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvestmentsController, type: :controller do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  let(:portfolio) { Portfolio.create!(user: user, name: 'Test Portfolio', description: 'A test portfolio') }

  before do
    sign_in user
  end

  describe '#new' do
    it 'returns http success' do
      get :new, params: { portfolio_id: portfolio.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new investment as @investment' do
      get :new, params: { portfolio_id: portfolio.id }
      expect(assigns(:investment)).to be_a_new(Investment)
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:valid_params) { { portfolio_id: portfolio.id,
                             investment: { symbol: 'AAPL', purchase_price: 100, shares: 10,
                                           purchase_date: Date.today } } }

      it 'creates a new Investment' do
        expect { post :create, params: valid_params }.to change(Investment, :count).by(1)
      end

      it 'assigns a newly created investment as investment' do
        post :create, params: valid_params
        expect(assigns(:investment)).to be_a(Investment)
        expect(assigns(:investment)).to be_persisted
      end

      it 'redirects to the created investment' do
        post :create, params: valid_params
        expect(response).to redirect_to(portfolio_investment_path(portfolio, Investment.last))
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { portfolio_id: portfolio.id,
                               investment: { symbol: '', purchase_price: 0, shares: 0, purchase_date: nil } } }

      it 'assigns a newly created but unsaved investment as @investment' do
        post :create, params: invalid_params
        expect(assigns(:investment)).to be_a_new(Investment)
      end

      it 're-renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    let(:investment) { Investment.create!(portfolio: portfolio,
                                          symbol: 'AAPL', purchase_price: 100, shares: 10, purchase_date: Date.today) }

    before do
      get :show, params: { portfolio_id: portfolio.id, id: investment.id }
    end
    
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested investment as investment' do
      expect(assigns(:investment)).to eq(investment)
    end

    it 'assigns the current price of the investment as current_price' do
      expect(assigns(:current_price)).to be_a(Float)
    end
  end
end
