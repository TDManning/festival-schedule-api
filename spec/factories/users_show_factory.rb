FactoryBot.define do
  factory :users_show do
    user
    show
    favorited { false }
  end
end
