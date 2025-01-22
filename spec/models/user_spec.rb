# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:users_shows).dependent(:destroy) }
  it { should have_many(:shows).through(:users_shows) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  describe '#add_show_to_schedule' do
    let(:user) { create(:user) }
    let(:show) { create(:show) }
    let(:another_show) { create(:show) }

    context 'when the show is not already in the schedule' do
      it 'adds the show to the user’s schedule' do
        result = user.add_show_to_schedule(show.id)

        expect(result[:error]).to be_nil
        expect(result[:success]).to be_persisted
      end
    end

    context 'when the show is already in the schedule' do
      before { create(:users_show, user: user, show: show) }

      it 'returns an error' do
        result = user.add_show_to_schedule(show.id)

        expect(result[:error]).to eq('Show already in schedule')
        expect(result[:status]).to eq(:unprocessable_entity)
      end
    end

    context 'when the show does not exist' do
      it 'returns an error' do
        result = user.add_show_to_schedule(999) 

        expect(result[:error]).to eq('Show not found')
        expect(result[:status]).to eq(:not_found)
      end
    end
  end
end
