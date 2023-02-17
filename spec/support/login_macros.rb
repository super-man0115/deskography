module LoginMacros
  def login_as(user)
    visit root_path
    click_on 'Login'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'Login'
    sleep 2
  end
end