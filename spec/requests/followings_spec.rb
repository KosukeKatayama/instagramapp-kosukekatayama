require 'rails_helper'

RSpec.describe 'Followings', type: :request do
  describe 'GET /followings' do
    let!(:user) { create(:user) }

    it 'フォロー一覧が表示されされる' do
      get account_followings_path(account_id: user.id)
      expect(response).to have_http_status(200)
    end
  end
end
