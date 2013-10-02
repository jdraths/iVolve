class Api < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :company, presence: true
	validates :access_token, presence: true
	validates :access_secret, presence: true
end
