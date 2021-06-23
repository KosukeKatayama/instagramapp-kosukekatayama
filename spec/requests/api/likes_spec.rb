require 'rails_helper'

RSpec.describe 'Api::Likes', type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  before do
    sign_in user
  end

  describe 'GET /api/likes' do
    let!(:like) { create(:like, article: article, user: user) }

    it '200 Statos' do
      get api_like_path(article_id: article.id)
      expect(response).to have_http_status(200)
    end
  end
end
