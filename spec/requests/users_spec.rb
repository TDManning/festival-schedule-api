# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 3) }

  describe 'GET /api/v1/users' do
    it 'retrieves all users with their schedules' do
      get '/api/v1/users'

      expect(response).to have_http_status(:ok)
      expect(json['data'].size).to eq(3)
      expect(json['data'].first['attributes']['username']).to eq(users.first.username)
    end
  end
end
