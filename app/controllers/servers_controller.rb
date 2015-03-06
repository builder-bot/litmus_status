class ServersController <  ApplicationController

	def index
		@servers = Server.all
	end
	
end