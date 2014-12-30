class UserMailer < ActionMailer::Base
  default from: "kerzo@mail.ru"

  def notice_new_follower(sender, followed)
  	@sender = sender
  	@reciever = followed
  	mail(to: @reciever.email, subject: "New follower!")
  end
end
