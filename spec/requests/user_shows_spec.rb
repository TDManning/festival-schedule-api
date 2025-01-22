require 'rails_helper'

RSpec.describe 'UserShows API', type: :request do
  let!(:user) { create(:user) }
  let!(:show) { create(:show) }
  let!(:another_show) { create(:show) }
  let!(:users_show) { create(:users_show, user: user, show: show, favorited: true) }

  describe 'GET /api/v1/users/:user_id/shows' do
    it 'retrieves all shows in a user’s schedule' do
      get "/api/v1/users/#{user.id}/shows"
  
      expect(response).to have_http_status(:ok)
      expect(json['data'].length).to eq(1) 
      expect(json['data'].first['attributes']['artist']).to eq(show.artist)
    end
  end

  describe 'POST /api/v1/users/:user_id/shows' do
    context 'when the show is not already in the schedule' do
      it 'adds the show to the user’s schedule' do
        post "/api/v1/users/#{user.id}/shows", params: { show_id: another_show.id, favorited: false }

        expect(response).to have_http_status(:created)
        expect(json['data']['attributes']['artist']).to eq(another_show.artist)
      end
    end

    context 'when the show is already in the schedule' do
      it 'returns an error' do
        post "/api/v1/users/#{user.id}/shows", params: { show_id: show.id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors'].first['detail']).to eq('Show already in schedule')
      end
    end
  end

  describe 'DELETE /api/v1/users/:user_id/shows/:id' do
    context 'when the show exists in the schedule' do
      it 'removes the show from the user’s schedule' do
        delete "/api/v1/users/#{user.id}/shows/#{show.id}"

        expect(response).to have_http_status(:no_content)
        expect(UsersShow.find_by(user: user, show: show)).to be_nil
      end
    end

    context 'when the show does not exist in the schedule' do
      it 'returns an error' do
        delete "/api/v1/users/#{user.id}/shows/999"

        expect(response).to have_http_status(:not_found)
        expect(json['errors'].first['detail']).to eq('Show not found in schedule')
      end
    end
  end
end
