# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  after_create :send_email, if: has_username?(comment, user)

  private
  def send_email
    CommentMailer.mention(comment, user).deliver_now
  end

  def has_username?(comment, user)
    comment.content.include?(user.username)
  end
end
