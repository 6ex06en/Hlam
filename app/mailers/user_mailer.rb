class UserMailer < ActionMailer::Base
  default from: "kerzo@mail.ru"

  def notice_new_follower(sender, followed)
  	@sender = sender
  	@reciever = followed
  	mail(to: @reciever.email, subject: "New follower!")
  end

  def reset_password(reciever, token)
  	@token = token
  	@reciever = reciever
  	mail(to: reciever.email, subject: "Password recovery")
  end
end
