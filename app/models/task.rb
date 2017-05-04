class Task < ActiveRecord::Base

  def complete!
    self.update_column(:completed, true)
  end
end
