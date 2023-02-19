# frozen_string_literal: true

class InvestmentsController < ApplicationController
  before_action :set_portfolio

  def new
    @investment = @portfolio.investments.build
  end

  def create
    @investment = @portfolio.investments.build(investment_params)
    if @investment.save
      redirect_to @portfolio
    else
      render 'new'
    end
  end

  def show
    @investment = @portfolio.investments.find(params[:id])
    @current_price = @investment.current_price
  end

  private
  def build_investments
    @portfolio.investments.build
  end

  def set_portfolio
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end

  def investment_params
    params.require(:investment).permit(:symbol, :purchase_price, :shares, :purchase_date)
  end
end
