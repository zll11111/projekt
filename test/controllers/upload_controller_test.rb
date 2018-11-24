require 'test_helper'

class UploadControllerTest < ActionDispatch::IntegrationTest
  test "should get upload_image" do
    get upload_upload_image_url
    assert_response :success
  end

end
