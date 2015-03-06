class StatusMessage < ActiveRecord::Base	
	attr_accessible :body, :server_id

	validates_presence_of :body, :server_id

	belongs_to :server

	DEFAULT_BODY = "A status message has not yet been created."


	def self.default_message
		new(:body => DEFAULT_BODY)
	end
end
