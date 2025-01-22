require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:show) { create(:show) }
  let!(:users_show) { create(:users_show, user: user, show: show) }

  subject { described_class.new(user) }

  it 'includes the expected attributes' do
    expected_attributes = [:id, :username, :first_name, :last_name]
    serialized_data = subject.serializable_hash[:data][:attributes]
    expect(serialized_data.keys.map(&:to_sym)).to include(*expected_attributes)
  end

  it 'includes the schedule attribute' do
    serialized_data = subject.serializable_hash[:data][:attributes]
    schedule = serialized_data[:schedule]
    expect(schedule).to be_an(Array)
    expect(schedule.first).to include(
      :id,
      :artist,
      :location,
      :time_slot,
      :image_url
    )
  end
end
