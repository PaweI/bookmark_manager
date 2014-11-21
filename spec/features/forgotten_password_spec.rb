require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature 'Forgotten password' do

  before(:each) do
    User.create(:email => "test@test.com",
                :password => "test",
                :password_confirmation => "test")
  end

  scenario 'user trying to restore password' do

    visit('/')
    forgot_password()
    expect(page).to have_content("Instructions to reset password being sent to test@test.com")

  end

end