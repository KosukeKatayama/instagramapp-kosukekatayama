require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  describe 'GET /api/comments' do
    let!(:comments) { create_list(:comment, 3, article: article, user: user) }

    it '200 Statos' do
      get api_comments_path(article_id: article.id)
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
  end

  describe 'POST /api/comments' do
    let!(:comment) { create(:comment, article: article, user: user) }

    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'コメントが正常に保存される' do
        comment_params = attributes_for(:comment)
        post api_comments_path({ article_id: article.id, comment: comment_params })
        expect(response).to have_http_status(200)
        expect(Comment.last.content).to eq(comment_params[:content])
      end
    end
  end
end
