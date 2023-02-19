# frozen_string_literal: true

class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :investments, dependent: :destroy

  def current_value
    investments.inject(0) do |sum, investment|
      price_product(sum, investment)
    end
  end

  def daily_gain_loss
    investments.inject(0) do |sum, investment|
      price_product(sum, investment) - investment.purchase_price * investment.shares
    end
  end

  def overall_return
    primal_investments = investments.inject(0) do |sum, investment|
      price_product(sum, investment) - investment.purchase_price * investment.shares
    end

    return 0 if primal_investments == 0

    primal_investments / investments.inject(0) do |sum, investment|
            sum + investment.purchase_price * investment.shares
    end
  end

  private

  def price_product(sum, investment)
    sum + (investment.current_price || investment.purchase_price) * investment.shares
  end
end
