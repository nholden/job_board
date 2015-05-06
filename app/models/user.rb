class User < ActiveRecord::Base
  has_secure_password
  has_attached_file :resume
  validates_attachment_content_type :resume, :content_type => 'application/pdf'
  validates_attachment_file_name :resume, :matches => /pdf\Z/
  validates_attachment_size :resume, :less_than => 5.megabytes
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :role, presence: true
  belongs_to :role
  has_many :jobs, dependent: :destroy
  has_many :applications
end
