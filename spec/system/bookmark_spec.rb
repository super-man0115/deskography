require 'rails_helper'

RSpec.describe 'comments', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, user: other_user) }

  before { login_as(user) }

  describe 'ブックマーク機能の確認' do
    context '未ブックマークの投稿にいいねできる', js: true do
      it 'いいねができる' do
        visit post_path(post)

        expect(page).to have_css "i.fa-regular.fa-heart"
        find("i.fa-regular.fa-heart").click
        expect(page).to have_css "i.fa-solid.fa-heart"
        expect(page).to have_content "#{post.like_count + 1}"
      end
    end
  end
end
