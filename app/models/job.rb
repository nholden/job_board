class Job < ActiveRecord::Base
  belongs_to :user
  validates :title, :location, :majors, :description, :instructions, presence: true
  valid_types = ["Internship", "Full time permanent", "Part time permanent", "Full time temporary", "Part time temporary"]
  validates :type, presence: true, inclusion: { in: valid_types, message: "%{value} is not a valid job type" }
  valid_experience = ["Some college", "Undergraduate degree", "Graduate degree", "Some professional expereince", "5+ years of professional experience"]
  validates :experience, presence: true, inclusion: { in: valid_experience, message: "%{value} is not a valid amount of experience" } 
end
