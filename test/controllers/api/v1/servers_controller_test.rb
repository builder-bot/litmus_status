require 'test_helper'

class Api::V1::ServersControllerTest < ActionController::TestCase

	setup do 
		@server = Server.create(:domain => 'awesome.com', :status => 'up')
	end

	test 'UPDATE should not be accessible via get post or delete' do
		get :update, :id => @server.id, :status => 'down', :format => :json
		assert_response 405

		post :update, :id => @server.id, :status => 'down', :format => :json
		assert_response 405

		delete :update, :id => @server.id, :status => 'down', :format => :json
		assert_response 405
	end

	test 'UPDATE should update status of server' do
		put :update, :id => @server.id, :server => {:status => 'down'}, :format => :json
		assert_response :success

		@server.reload
		assert_equal 'down', @server.status
	end

	test 'UPDATE_STATUS shorthand should update server properly' do
		@server.update_attribute(:status, 'up')
		@server.reload

		put :update_status, :id => @server.id, :status => 'down', :format => :json
		assert_response :success

		@server.reload
		assert_equal 'down', @server.status
	end

	test 'UPDATE should not allow un-whitelisted statuses' do
		put :update_status, :id => @server.id, :status => 'foo', :format => :json
		assert_response 400
	end

	test 'UPDATE should handle failure gracefully' do
		@server.stubs(:update_attributes).returns(false)
		put :update_status, :id => @server.id, :status => 'foo', :format => :json
		assert_response 400
	end

	test 'UPDATE should create a new timestamped message if a message param is passed' do
		assert_difference("StatusMessage.count", +1) do
  			put :update, :id => @server.id, :server => {:status => 'down', :message => 'RUN FOR THE HILLS!!!'}, :format => :json
		end
		assert_response :success
		assert_equal 'RUN FOR THE HILLS!!!', @server.current_message.body
	end

end