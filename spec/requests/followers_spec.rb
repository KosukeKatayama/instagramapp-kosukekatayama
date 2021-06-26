require 'rails_helper'

RSpec.describe 'Followers', type: :request do
  describe 'GET /followers' do
    let!(:user) { create(:user) }

    it 'フォロワーが表示されされる' do
      get account_followers_path(account_id: user.id)
      expect(response).to have_http_status(200)
    end
  end
end
