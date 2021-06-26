require 'rails_helper'

RSpec.describe 'Unfollows', type: :request do
  describe 'POST /unfollows' do
    let!(:user1) { create(:user)}
    let!(:user2) { create(:user, username: 'test2')}

    before do
      sign_in user1
      user1.follow!(user2)
    end

    it 'アンフォローできる' do
      post account_unfollows_path(account_id: user2.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(account_path(id: user2.id))
    end
  end
end