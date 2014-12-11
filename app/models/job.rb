class Job < ActiveRecord::Base
  belongs_to :user
  validates :title, :location, :majors, :description, :instructions, :user, presence: true
  valid_terms = ["Internship", "Full time permanent", "Part time permanent", "Full time temporary", "Part time temporary"]
  validates :term, presence: true, inclusion: { in: valid_terms, message: "%{value} is not a valid job term" }
  valid_experience = ["Some college", "Undergraduate degree", "Graduate degree", "Some professional expereince", "5+ years of professional experience"]
  validates :experience, presence: true, inclusion: { in: valid_experience, message: "%{value} is not a valid amount of experience" } 
end
