class UserMailer < ApplicationMailer
  default from: 'oddter.notifications@gmail.com'

  def invitation_email(user, event, new_user = false)
    @user = user
    @event = event
  	@host = @user.find_host(@event)
    @url  = 'https://oddter.herokuapp.com'
    @new_user = new_user
    mail(to: @user.email, subject: "You've been invited!")
  end

end
