require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'ポストの新規投稿ページにアクセス' do
        it '新規投稿ページへのアクセスが失敗する' do
          visit new_post_path
          expect(page).to have_content('ログインが必要です')
          expect(current_path).to eq login_path
        end
      end

      context 'ポストの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          visit edit_post_path(post)
          expect(page).to have_content('ログインが必要です')
          expect(current_path).to eq login_path
        end
      end

      context 'ポストの詳細ページにアクセス' do
        it 'ポストの詳細情報が表示される' do
          visit post_path(post)
          expect(page).to have_content post.title
          expect(current_path).to eq post_path(post)
        end
      end

      context 'ポスト一覧ページにアクセス' do
        it 'すべてのユーザーの投稿が表示される' do
          post_list = create_list(:post, 3)
          visit posts_path
          expect(page).to have_content post_list[0].title
          expect(page).to have_content post_list[1].title
          expect(page).to have_content post_list[2].title
          expect(current_path).to eq posts_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe 'ポスト新規投稿' do
      context 'フォームの入力値が正常' do
        it 'タスクの新規作成が成功する' do
          visit new_post_path
          fill_in '説明', with: 'test_description'
          within 'select[name="post[business_attribute]"]' do
            select 'デザイナー'
          end
          within 'select[name="post[age_group]"]' do
            select '30代'
          end
          attach_file 'post[images]', "#{Rails.root}/spec/fixtures/test_default.png"
          click_button '登録する'
          expect(page).to have_content 'test_description'
          expect(page).to have_content 'デザイナー'
          expect(page).to have_content '30代'
          expect(page).to have_selector("img[src$='test_default.png']")
        end
      end

      context 'メイン画像を登録せずに投稿' do
        it '新規投稿が失敗' do
          visit new_post_path
          fill_in '説明', with: 'test_description'
          within 'select[name="post[business_attribute]"]' do
            select 'デザイナー'
          end
          within 'select[name="post[age_group]"]' do
            select '30代'
          end
          click_button '登録する'
          expect(page).to have_content '画像を入力してください'
          expect(current_path).to eq new_post_path
        end
      end
    end

    describe 'ポスト編集' do
      let!(:post) { create(:post, user:) }
      let(:other_post) { create(:post, user:) }
      before { visit edit_post_path(post) }

      context 'フォームの入力値が正常' do
        fit 'ポストの編集が成功する' do
          fill_in '説明', with: 'update_description'
          within 'select[name="post[business_attribute]"]' do
            select 'エンジニア'
          end
          within 'select[name="post[age_group]"]' do
            select '20代'
          end
          find("a[data-action*='click->modal#open']").click
          attach_file 'post[images]', "#{Rails.root}/spec/fixtures/test_default.png"
          click_button '更新する'
          expect(page).to have_content 'update_description'
          expect(page).to have_content 'エンジニア'
          expect(page).to have_content '20代'
          expect(page).to have_selector("img[src$='test_default.png']")
          expect(current_path).to eq post_path(post)
        end
      end

      context '他ユーザーのタスク編集ページにアクセス' do
        let!(:other_user) { create(:user, email: "other_user@example.com") }
        let!(:other_post) { create(:post, user: other_user) }

        it '編集ページへのアクセスが失敗する' do
          visit edit_post_path(other_post)
          expect(page).to have_content '権限がありません'
          expect(current_path).to eq post_path(other_post)
        end
      end
    end
  end
end