require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      before do
        visit new_user_path
      end

      context 'フォームの入力値が正常' do
        it 'ユーザーの新規登録が成功' do
          fill_in 'ユーザー名', with: 'test_user'
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード(確認用)', with: 'password'
          click_on '登録する'
          sleep 2
          expect(current_path).to eq login_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規登録が失敗する' do
          fill_in 'ユーザー名', with: 'test_user'
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード(確認用)', with: 'password'
          click_button '登録する'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(current_path).to eq new_user_path
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザーの新規登録が失敗する' do
          existed_user = create(:user)
          fill_in 'ユーザー名', with: 'test_user'
          fill_in 'メールアドレス', with: existed_user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード(確認用)', with: 'password'
          click_button '登録する'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(current_path).to eq new_user_path
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
          visit user_path(user)
          expect(page).to have_content 'ログインが必要です'
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit edit_user_path(user)
          fill_in 'ユーザー名', with: 'update_user'
          fill_in 'メールアドレス', with: 'update@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード(確認用)', with: 'password'
          click_button '更新する'
          sleep 2
          expect(current_path).to eq user_path(user)
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          fill_in 'ユーザー名', with: 'update_user'
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード(確認用)', with: 'password'
          click_button '更新する'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(current_path).to eq edit_user_path(user)
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          other_user = create(:user)
          fill_in 'ユーザー名', with: 'update_user'
          fill_in 'メールアドレス', with: other_user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード(確認用)', with: 'password'
          click_button '更新する'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(current_path).to eq edit_user_path(user)
        end
      end

      context '他ユーザーの編集ページにアクセス' do
        let!(:other_user) { create(:user, email: "other_user@example.com") }

        it '編集ページへのアクセスが失敗する' do
          visit edit_user_path(other_user)
          expect(page).to have_content '権限がありません'
          expect(current_path).to eq user_path(other_user)
        end
      end
    end
  end
end