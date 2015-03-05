class Experience < ActiveRecord::Base
  has_many :jobs

  def destroy_and_reassign_jobs
    self.jobs.each do |job|
      job.experience = Experience.find_or_create_by(label: 'Unspecified')
      job.save
    end
    self.destroy
  end
end
