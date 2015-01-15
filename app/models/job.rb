class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience
  belongs_to :term
  validates :title, :location, :majors, :description, :instructions, :user, :experience, :term, presence: true
end
