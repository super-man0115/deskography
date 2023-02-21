require 'rails_helper'

RSpec.describe 'Mailer', type: :system do
  let!(:user) { create(:user) }
  let(:mail) { UserMailer.reset_password_email(user).deliver_now }
  let(:check_sent_mail) {
    expect(mail.present?).to be_truthy
    expect(mail.to).to eq [user.email]
    expect(mail.subject).to eq 'パスワードの再設定 | Deskography'
    expect(mail.from).to eq ['info@deskography.com']
  }

  describe 'メールの送信' do
    context 'メールを送信した場合' do
      it 'タイトル、メールアドレスが正しく送信される' do
        visit login_path
        click_link 'パスワードをお忘れの方はこちら'
        fill_in 'Email', with: user.email
        click_button 'Reset Password'
        sleep 2
        check_sent_mail
      end

      it 'パスワード再設定ページからメールを送る' do
        visit new_password_reset_path
        fill_in 'Email', with: user.email
        click_button 'Reset Password'
        sleep 2
        expect(current_path).to eq root_path
        expect(page).to have_content 'パスワード再設定用のリンクを送信しました'
      end

      it '正しくないメールアドレスを送信' do
        visit new_password_reset_path
        fill_in 'Email', with: 'does_not_exist@example.com'
        click_button 'Reset Password'
        sleep 2
        expect(current_path).to eq root_path
        expect(page).to have_content 'パスワード再設定用のリンクを送信しました'
      end  
    end
  end
end        