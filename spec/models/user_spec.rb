# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context 'associations' do
    it { should have_many(:portfolios).dependent(:destroy) }
  end
end
