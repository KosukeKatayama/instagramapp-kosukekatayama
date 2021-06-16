require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }

  context 'contentが入力されている場合' do
    let!(:article) { build(:article, user: user) }

    it '投稿が保存できる' do
      expect(article).to be_valid
    end
  end
end
