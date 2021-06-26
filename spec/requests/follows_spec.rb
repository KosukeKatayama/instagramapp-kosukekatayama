require 'rails_helper'

RSpec.describe 'Follows', type: :request do
  describe 'POST /follows' do
    let!(:user) { create(:user) }
    before do
      sign_in user
    end

    it 'フォローできる' do
      post account_follows_path(account_id: user.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(account_path(id: user.id))
    end
  end
end
