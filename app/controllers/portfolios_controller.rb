# frozen_string_literal: true

class PortfoliosController < ApplicationController
  def index
    @portfolios = current_user.portfolios.all
  end

  def new
    @portfolio = current_user.portfolios.build
  end

  def create
    @portfolio = current_user.portfolios.build(portfolio_params)
    if @portfolio.save
      redirect_to @portfolio
    else
      render 'new'
    end
  end

  def show
    @portfolio = current_user.portfolios.find(params[:id])
    @current_value = @portfolio.current_value
    @daily_gain_loss = @portfolio.daily_gain_loss
    @overall_return = @portfolio.overall_return
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name, :description)
  end
end
