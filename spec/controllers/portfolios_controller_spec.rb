# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
  let(:user) { create(:user) }
  let(:portfolio) { create(:portfolio, user: user) }

  before do
    sign_in user
  end
  
  describe "#index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns portfolios" do
      get :index
      expect(assigns(:portfolios)).to eq([portfolio])
    end
  end

  describe "#new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "assigns portfolio" do
      get :new
      expect(assigns(:portfolio)).to be_a_new(Portfolio)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      it "creates a new portfolio" do
        expect { post :create, params: { portfolio: attributes_for(:portfolio) } }.to change(Portfolio, :count).by(1)
      end

      it "redirects to the new portfolio" do
        post :create, params: { portfolio: attributes_for(:portfolio) }
        expect(response).to redirect_to(Portfolio.last)
      end
    end

    context "with invalid attributes" do
      it "does not create a new portfolio" do
        expect { post :create, params: { portfolio: attributes_for(:portfolio, name: nil) }
        }.not_to change(Portfolio, :count)
      end

      it "re-renders the new method" do
        post :create, params: { portfolio: attributes_for(:portfolio, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    it "returns http success" do
      get :show, params: { id: portfolio.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns portfolio" do
      get :show, params: { id: portfolio.id }
      expect(assigns(:portfolio)).to eq(portfolio)
    end

    it "assigns current_value" do
      get :show, params: { id: portfolio.id }
      expect(assigns(:current_value)).to eq(portfolio.current_value)
    end

    it "assigns daily_gain_loss" do
      get :show, params: { id: portfolio.id }
      expect(assigns(:daily_gain_loss)).to eq(portfolio.daily_gain_loss)
    end

    it "assigns overall_return" do
      get :show, params: { id: portfolio.id }
      expect(assigns(:overall_return)).to eq(portfolio.overall_return)
    end
  end
end
