require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:users_shows).dependent(:destroy) }
    it { should have_many(:shows).through(:users_shows) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe '.find_with_error_handling' do
    let!(:user) { create(:user) }

    context 'when the user exists' do
      it 'returns the user' do
        expect(User.find_with_error_handling(user.id)).to eq(user)
      end
    end

    context 'when the user does not exist' do
      it 'raises an ActiveRecord::RecordNotFound error with a custom message' do
        expect { User.find_with_error_handling(-1) }.to raise_error(ActiveRecord::RecordNotFound, 'User not found')
      end
    end
  end

  describe '#add_show_to_schedule' do
    let(:user) { create(:user) }
    let(:show) { create(:show) }

    context 'when the show does not exist' do
      it 'returns an error and status :not_found' do
        result = user.add_show_to_schedule(-1, true)
        expect(result[:error]).to eq('Show not found')
        expect(result[:status]).to eq(:not_found)
      end
    end

    context 'when the show is not already in the schedule' do
      it 'adds the show to the schedule and marks it as favorited' do
        result = user.add_show_to_schedule(show.id, true)
        expect(result[:success]).to be_present
        expect(result[:success].favorited).to eq(true)
        expect(user.shows).to include(show)
      end
    end

    context 'when the show is already in the schedule' do
      before do
        create(:users_show, user: user, show: show)
      end

      it 'returns an error and status :unprocessable_entity' do
        result = user.add_show_to_schedule(show.id, true)
        expect(result[:error]).to eq('Show already in schedule')
        expect(result[:status]).to eq(:unprocessable_entity)
      end
    end
  end
end
