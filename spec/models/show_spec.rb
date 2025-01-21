require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'associations' do
    it { should have_many(:users_shows).dependent(:destroy) }
    it { should have_many(:users).through(:users_shows) }
  end

  describe 'validations' do
    it { should validate_presence_of(:artist) }
    it { should validate_presence_of(:location) }
  end
end
