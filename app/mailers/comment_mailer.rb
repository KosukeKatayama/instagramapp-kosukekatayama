class CommentMailer < ApplicationMailer

  def mention(comment, user)
    @comment = comment.content


    useername = has_username?(user).username
    #contentからusernameを取得
    @user = user.find_by(username: params[:username])
    #usernameからユーザーを取得
    mail to: @user.email, subject: '【お知らせ】メンションされました'
  end
end
