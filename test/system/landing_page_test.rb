require "application_system_test_case"

class LandingPageTest < ApplicationSystemTestCase
  test "visiting the landing page" do
    visit root_url

    assert_selector "h1", text: "Meetup Leaderboard"
    assert_link "Get Started", href: new_session_path
  end
end
