class CommentMailer < ApplicationMailer

  def mention(comment, user)
    @comment = comment.content
    @user = user.find_by(username: params[:username])
    mail to: @user.email, subject: '【お知らせ】メンションされました'
  end
end
