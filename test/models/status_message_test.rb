require 'test_helper'

class StatusMessageTest < ActiveSupport::TestCase

  setup do
  	@server = Server.create(:domain => 'foo.com', :server_type => 'web')
  end

  test 'ensure message body is populated' do
  	msg = StatusMessage.create
  	assert !msg.valid?
  	assert !msg.errors[:body].nil?

  	msg = StatusMessage.create(:body => 'this is a message', :server_id => @server.id)
  	assert msg.valid?
  	msg.reload
  	assert_equal 'this is a message', msg.body
  end

  test 'ensure message belongs to server' do
  	msg = StatusMessage.create(:body => 'bla')
  	assert !msg.valid?
  	assert !msg.errors[:server_id].nil?

  	msg = StatusMessage.create(:body => 'bla', :server_id => @server.id)
  	assert msg.valid?
  	msg.reload
  	assert_equal @server, msg.server
  end
end
