class UserMailer < ActionMailer::Base
  default :from => "emily@blkbox.io"

  def registration_confirmation(user, org)
    @user = user
    @organization = org
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Blkbox Registration Confirmation")
  end
end
