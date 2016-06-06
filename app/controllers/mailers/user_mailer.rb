class UserMailer < ActionMailer::Base
  default :from => "emily@blkbox.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Blkbox Registration Confirmation")
  end
end
