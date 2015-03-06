class Server < ActiveRecord::Base
	enum status: %w(up down)
	attr_accessible :status, :domain, :server_type

	validates_uniqueness_of :server_type, :scope => :domain

	has_many :status_messages

	def update_message(msg)
		status_messages.create!(body: msg)
	end

	def current_message
		most_recent.first || StatusMessage.default_message
	end

	def most_recent(limit=10)
		status_messages.order('created_at DESC').limit(limit)
	end
end
