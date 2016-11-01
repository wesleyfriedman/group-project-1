class UserMailer < ApplicationMailer
  default from: 'oddter.notifications@gmail.com'

  def invitation_email(user, event, host)
  	@host = host
  	@event = event 
    @user = user 
    @url  = 'http://localhost:3000/login'
    mail(to: @user.email, subject: "You've been invited!")
  end

end
