class Experience < ActiveRecord::Base
  has_many :jobs
  validates :label, presence: true

  after_initialize :defaults

  def defaults
    if Experience.maximum("position").nil?
      self.position ||= 1
    else
      self.position ||= Experience.maximum("position")+1
    end
  end

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

  def self.reposition(hash)
    hash.each do |id, position|
      experience = Experience.find(id)
      experience.position = position
      experience.save
    end
  end
end
