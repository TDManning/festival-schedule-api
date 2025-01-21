require 'rails_helper'

RSpec.describe UsersShow, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:show) }
end
