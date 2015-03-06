require 'test_helper'

class ServerTest < ActiveSupport::TestCase

  setup do
  	@down_server 	= Server.create(domain: 'test.com', status: 'down', server_type: 'web')
  	@up_server 		= Server.create(domain: 'foo.com', status: 'up', server_type: 'mail')
  end

  test "should set up server status successfully" do
  	@down_server.status = "up"
  	@down_server.save
  	@down_server.reload

  	assert_equal @down_server.up?, true 
  end

  test 'should set down server status successfully' do
  	@up_server.update_attribute(:status, :down)
  	@up_server.save
  	@up_server.reload

  	assert_equal @up_server.down?, true
  end

  test 'should not accept non-whitelisted statuses' do
  	assert_raise ArgumentError do
  		@down_server.status = "foobar"
  		@down_server.save
  	end
  end

  test 'should not create duplicate server creation' do
  	@dup = Server.create(domain: 'test.com', server_type: 'web')
  	assert_equal @dup.valid?, false
  end

  test 'should display default message if no messages currently exist' do
    StatusMessage.send(:remove_const, :DEFAULT_BODY)
    StatusMessage.const_set( :DEFAULT_BODY, 'This is a default.' )
    assert_equal "This is a default.", @up_server.current_message.body
  end
end
