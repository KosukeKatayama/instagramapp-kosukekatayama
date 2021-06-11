class Apps::PopularsController < Apps::ApplicationController
  
  def show
    @articles = Article.joins(:likes).where(created_at: 24.hours.ago..).group(:id).order(created_at: :desc).order('COUNT(likes.id)').limit(5)
    # likesテーブルを左外部結合、24時間以内の投稿を検索、グループを指定、新着順に並び替え、いねの多い5件を取得
  end
end