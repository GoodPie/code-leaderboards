require "application_system_test_case"

class LandingPageTest < ApplicationSystemTestCase
  test "visiting the landing page" do
    visit root_url

    assert_selector "h1", text: "Welcome to the Meetup Leaderboard"
    assert_link "Login", href: new_session_path
  end
end
