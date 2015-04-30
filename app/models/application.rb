class ApplicationValidator < ActiveModel::Validator
  def validate(record)
    if User.find(record.user_id).role.label != "applicant"
      record.errors[:base] << "You must be logged in as an applicant to apply."
    end
  end
end

class Application < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  validates_with ApplicationValidator

  before_save :default_values
  def default_values
    self.status ||= "Submitted"
  end
end
