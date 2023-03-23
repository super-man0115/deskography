# require 'rails_helper'

# RSpec.describe 'Password_resets', type: :system do
#   let!(:user) { create(:user) }
#   let(:mail) { UserMailer.reset_password_email(user).deliver_now }

#   describe 'パスワード変更を行う' do
#     before do
#       visit login_path
#       click_link 'パスワードをお忘れの方はこちら'
#       fill_in 'Email', with: user.email
#       click_button 'Reset Password'
#       sleep 2
#     end

#     fit '正しく入力し、パスワード変更が成功する' do
#       visit edit_password_reset_path(user.reset_password_token)
#     end
#   end
# end
