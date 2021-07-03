require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  context 'contentが2000文字以上の場合' do
    let!(:comment) { build(:comment, content: Faker::Lorem.characters(number: 2500), user: user, article: article) }

    before do
      comment.save
    end

    it 'コメントの送信に失敗する' do
      expect(comment.errors.messages[:content][0]).to eq('は2000文字以内で入力してください')
    end
  end
end
