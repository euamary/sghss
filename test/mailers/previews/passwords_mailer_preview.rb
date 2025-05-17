# Preview all email_addresss at http://localhost:3000/rails/mailers/passwords_mailer
class PasswordsMailerPreview < ActionMailer::Preview
  # Preview this email_address at http://localhost:3000/rails/mailers/passwords_mailer/reset
  def reset
    PasswordsMailer.reset(User.take)
  end
end
