# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) { { email: 'test@example.com', password: 'password' } }
  let(:invalid_attributes) { { email: nil, password: nil } }

  describe '#create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect { post :create, params: { user: valid_attributes } }.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: { user: valid_attributes }
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it 'does not create a new user' do
        expect { post :create, params: { user: invalid_attributes } }.to change(User, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
