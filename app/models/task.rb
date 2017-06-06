class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  scope :as_priority, -> { order(:priority) }

  before_create :set_priority

  def self.next_priority
    Task.as_priority.last.priority.to_i + 1
  end

  def complete!
    self.update_column(:completed, true)
  end

  def set_priority
    self.priority = Task.next_priority
  end
end
