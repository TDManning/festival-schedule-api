require 'rails_helper'

RSpec.describe 'Shows API', type: :request do
  let!(:shows) { create_list(:show, 5) }

  describe 'GET /api/v1/shows' do
    it 'retrieves all festival shows' do
      get '/api/v1/shows'

      expect(response).to have_http_status(:ok)
      expect(json['data'].length).to eq(5)
      expect(json['data'].first['attributes']['artist']).to eq(shows.first.artist)
    end
  end
end
