# frozen_string_literal: true

class CreateInvestments < ActiveRecord::Migration[5.2]
  def change
    create_table :investments do |t|
      t.string :symbol
      t.decimal :purchase_price
      t.integer :shares
      t.date :purchase_date
      t.references :portfolio, foreign_key: true

      t.timestamps
    end
  end
end
