class Api::V1::ServersController < ApplicationController
	respond_to :json, :xml

	before_filter :get_server, :only => [:update, :update_status]
	before_filter :protect_put_requests, :only => [:update, :update_status]

	def update
		new_msg = params[:server].delete(:message)

		begin
			@server.update_attributes(params[:server])
		rescue ArgumentError => e
			return render_error(400, e)
		end
		@server.update_message(new_msg) if new_msg && @server.valid?
		respond_with @server
	end

	def update_status
		params[:server] = {:status => params[:status]}
		update
	end

	protected 

	def get_server
		@server = Server.find_by_id(params[:id])
	end

	def protect_put_requests
		return render :nothing => true, :status => 405 unless request.put?
	end

	def render_error(code, body)
		render :status => code, :body => body
	end
end