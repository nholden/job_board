class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience
  validates :title, :location, :majors, :description, :instructions, :user, :experience, presence: true
  valid_terms = ["Internship", "Full time permanent", "Part time permanent", "Full time temporary", "Part time temporary"]
  validates :term, presence: true, inclusion: { in: valid_terms, message: "%{value} is not a valid job term" }
end
