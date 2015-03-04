class Experience < ActiveRecord::Base
  has_many :jobs

  def destroy_and_reassign_jobs
  end
end
