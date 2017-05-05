class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true

  def complete!
    self.update_column(:completed, true)
  end
end
