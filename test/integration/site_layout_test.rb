require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

	def setup
   	@user = users(:kenneth)
  end

	test "layout links" do
		get root_path
		assert_template 'static_pages/home'

		# Nav link for non-logged-in user
		assert_select "a[href=?]", root_path, count: 2
		assert_select "a[href=?]", help_path
		assert_select "a[href=?]", about_path
		assert_select "a[href=?]", contact_path
		assert_select "a[href=?]", signup_path
		assert_select "a[href=?]", login_path

		# Nav link for logged-in user
		log_in_as(@user)
		get root_path
		assert_template 'static_pages/home'
		assert_select "a[href=?]", root_path, count: 2
		assert_select "a[href=?]", help_path
		assert_select "a[href=?]", about_path
		assert_select "a[href=?]", contact_path
		assert_select "a[href=?]", users_path
		#assert_select "a[href=?]", users_path(@user)
		#assert_select "a[href=?]", user_edit_path
		#assert_select "a[href=?]", logout_path

		# Title names
		get contact_path
		assert_select "title", full_title("Contact")
		get signup_path
		assert_select "title", full_title("Sign up")
	end
end
