require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }

  context 'contentが入力されている場合' do
    let!(:article) { build(:article, user: user) }

    it '投稿が保存できる' do
      expect(article).to be_valid
    end
  end

  context 'contentが2000文字以上' do
    let!(:article) { build(:article, content: Faker::Lorem.characters(number: 2500), user: user) }

    before do
      article.save
    end

    it '投稿の保存に失敗する' do
      expect(article.errors.messages[:content][0]).to eq('は2200文字以内で入力してください')
    end
  end
end
