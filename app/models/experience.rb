class Experience < ActiveRecord::Base
  has_many :jobs

  def destroy_and_reassign_jobs
    self.jobs.each do |job|
      job.experience = Experience.find_or_create_by(label: 'Unspecified')
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
