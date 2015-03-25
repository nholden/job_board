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
end
