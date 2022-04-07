# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST #login' do
    context 'when User authenticated' do
      let!(:user) { create(:user) }

      it 'returns token' do
        get :login, params: { username: user.username, password: user.password }

        expect(response).to be_ok
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['token']).not_to be_empty
      end
    end

    context 'when User non authenticated' do
      it 'returns 401' do
        get :login, params: { username: 'fake', password: 'fake' }

        expect(response).to be_unauthorized
        expect(json_response).to eq(error: 'unauthorized')
      end
    end
  end
end
