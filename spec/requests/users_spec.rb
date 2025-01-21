require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 3) }
  let!(:shows) { create_list(:show, 2) }
  let!(:user_shows) do
    users.each do |user|
      shows.each do |show|
        create(:users_show, user: user, show: show)
      end
    end
  end

  describe 'GET /api/v1/users/shows' do
    it 'retrieves all users and their schedules, including shows' do
      get '/api/v1/users/shows'

      expect(response).to have_http_status(:ok)
      expect(json['data'].length).to eq(3) 
      expect(json['data'].first['attributes']['schedule'].length).to eq(2) 
    end
  end
end
