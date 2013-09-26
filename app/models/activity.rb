class Activity < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :achievement_id, presence: true
	validates :value, presence: true
	validates :app_log_id, presence: true
	validates :time, presence: true
	validates :description, presence: true
end
