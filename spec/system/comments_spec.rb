require 'rails_helper'

RSpec.describe 'Comment', type: :system do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comments) { create_list(:comment, 3, article: article, user: user) }

  it 'コメント一覧が表示される' do
    visit article_comments_path(article_id: article.id)

    comments.each do |comment|
      expect(page).to have_css('.comment-page_content', text: comment.content)
    end
  end
end
