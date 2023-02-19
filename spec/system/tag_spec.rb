require 'rails_helper'

RSpec.describe 'Tags', type: :system do
  let!(:user) { create(:user) }
  
  describe '新規作成' do
    before { login_as(user) }

    it 'タグが保存されること' do
      visit new_post_path
      fill_in 'タイトル', with: 'test_title'
      fill_in '説明', with: 'test_description'
      within 'select[name="post[business_attribute]"]' do
        select 'デザイナー'
      end
      within 'select[name="post[age_group]"]' do
        select '30代'
      end
      fill_in 'タグ', with: 'Ruby'
      attach_file 'post[main_image]', "#{Rails.root}/spec/fixtures/test_default.png"
      click_button '登録する'
      expect(page).to have_content 'Ruby'
    end

    it 'タグが複数保存されること' do
      visit new_post_path
      fill_in 'タイトル', with: 'test_title'
      fill_in '説明', with: 'test_description'
      within 'select[name="post[business_attribute]"]' do
        select 'デザイナー'
      end
      within 'select[name="post[age_group]"]' do
        select '30代'
      end
      fill_in 'タグ', with: 'Ruby, Rails, Javascript'
      attach_file 'post[main_image]', "#{Rails.root}/spec/fixtures/test_default.png"
      click_button '登録する'
      expect(page).to have_content 'Ruby'
      expect(page).to have_content 'Rails'
      expect(page).to have_content 'Javascript'
    end

    it '同じタグを入力しても重複してレコードが作成されないこと' do
      visit new_post_path
      fill_in 'タグ', with: 'Ruby, Rails, Javascript'
      attach_file 'post[main_image]', "#{Rails.root}/spec/fixtures/test_default.png"
      click_button '登録する'

      visit new_post_path
      fill_in 'タグ', with: 'Ruby, Rails, Javascript'
      attach_file 'post[main_image]', "#{Rails.root}/spec/fixtures/test_default.png"
      expect { click_button '登録する' }.not_to change { Tag.count }
    end  
  end
  
  describe '編集' do
    before { login_as(user) }

    fit 'タグの編集ができること' do
      visit new_post_path
      fill_in 'タイトル', with: 'タグ編集'
      fill_in 'タグ', with: 'Ruby, Rails, Javascript'
      attach_file 'post[main_image]', "#{Rails.root}/spec/fixtures/test_default.png"
      click_button '登録する'
      click_on 'タグ編集'
      click_link 'edit'
      expect(page).to have_selector("input[value='Ruby,Rails,Javascript']")
      fill_in 'タグ', with: 'Ruby, PHP, Python'
      click_button '更新する'
      expect(page).to have_content 'Ruby'
      expect(page).to have_content 'PHP'
      expect(page).to have_content 'Python'
    end
  end    
end