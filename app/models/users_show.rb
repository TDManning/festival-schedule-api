class UsersShow < ApplicationRecord
  belongs_to :user
  belongs_to :show

  validate :unique_user_show_combination

  private

  def unique_user_show_combination
    if UsersShow.exists?(user_id: user_id, show_id: show_id)
      errors.add(:base, 'Show already added to schedule')
    end
  end
end
