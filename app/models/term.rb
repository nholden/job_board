class Term < ActiveRecord::Base
  has_many :jobs

  def destroy_and_reassign_jobs
    self.jobs.each do |job|
      job.term = Term.find_or_create_by(label: "Unspecified")
      job.save
    end
    self.destroy
  end
end
