class Task < ActiveRecord::Base
  belongs_to :user

  def complete!
    self.update_column(:completed, true)
  end
end
