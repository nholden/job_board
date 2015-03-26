module Manageable
  extend ActiveSupport::Concern

  included do
    has_many :jobs
    validates :label, presence: true
    default_scope { order('position') }
    after_initialize :defaults
  end

  def defaults
    if self.class.maximum("position").nil?
      self.position ||= 1 
    else
      self.position ||= self.class.maximum("position")+1
    end
  end

  def destroy_and_reassign_jobs
    self.jobs.each do |job|
      job.send(self.class.name.downcase + '=', self.class.find_or_create_by(label: 'Unspecified'))
      job.save
    end
    if self.label == "Unspecified" && self.jobs.count != 0
      self.errors.add(:base, "You must delete or reassign the jobs with unspecified experiences.")
      false
    else
      self.destroy
    end
  end
end
