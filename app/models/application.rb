class Application < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  before_save :default_values
  def default_values
    self.status ||= "Submitted"
  end
end
