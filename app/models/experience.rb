class Experience < ActiveRecord::Base
  has_many :jobs
  validates :label, presence: true
  default_scope { order('position') }
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
    if hash.values.uniq.length != hash.values.length
      false
    else
      Experience.update_all position: nil
      new_order = hash.sort_by { |id, position| position }
      new_order.each do |id_position_pair|
        Experience.find(id_position_pair[0]).save if Experience.exists?(id_position_pair[0])
      end
    end
  end

  def self.refresh_positions
    id_position_pairs = {}
    Experience.all.each do |experience|
      id_position_pairs[experience.id] = experience.position
    end
    Experience.reposition(id_position_pairs)
  end
end
