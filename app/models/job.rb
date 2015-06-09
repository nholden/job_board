class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience
  belongs_to :term
  has_many :applications
  validates :title, :location, :majors, :description, :user, :experience, :term, presence: true
  default_scope { order(created_at: :desc) }
end
