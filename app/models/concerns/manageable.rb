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
      self.errors.add(:base, "You must delete or reassign the jobs with unspecified #{self.class.name.downcase}s.")
      false
    else
      self.destroy
    end
  end

  module ClassMethods
    def reposition(hash)
      if hash.values.uniq.length != hash.values.length
        false
      else
        self.update_all position: nil
        new_order = hash.sort_by { |id, position| position }
        new_order.each do |id_position_pair|
          self.find(id_position_pair[0]).save if self.exists?(id_position_pair[0])
        end
      end
    end

    def refresh_positions
      id_position_pairs = {}
      self.all.each do |managed|
        id_position_pairs[managed.id] = managed.position
      end
      self.reposition(id_position_pairs)
    end
  end
end
