require 'rails_helper'

RSpec.describe 'comments', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, user: other_user) }
  let(:comment_post) { create(:comment, body: 'テストです', post: post, user: user) }

  before { login_as(user) }

  describe '他人の投稿にコメントできる' do
    it 'コメントに成功する' do
      visit post_path(post)

      fill_in "comment[body]", with: 'コメントです'
      click_button 'コメントする'

      expect(page).to have_content 'コメントです'
      expect(current_path).to eq post_path(post)
    end
  end

  describe 'コメントを削除できる', js: true do
    before { comment_post }
    fit '削除に成功する' do
      visit post_path(post)

      expect(page).to have_content 'テストです'

      find(".js-delete-comment-button", wait: 2).click
      sleep 5

      expect(page).not_to have_content 'テストです'
      expect(page).to have_selector('turbo-stream[action="remove"]')
    end
  end  
end  