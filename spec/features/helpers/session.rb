module SessionHelpers
  def sign_up(email = 'alice@example.com',
              password = 'oranges!',
              password_confirmation = 'oranges!')
    visit('/users/new')
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_on 'Sign up'
  end

  def sign_in(email, password)
    visit '/sessions/new'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_on 'Sign in'
  end

  def forgot_password(email = 'test@test.com')
    visit('/sessions/new')
    click_on 'Forgot password?'
    fill_in :email, with: email
    click_on 'send'
 end
end
