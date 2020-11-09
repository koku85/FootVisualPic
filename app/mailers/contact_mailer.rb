class ContactMailer < ApplicationMailer
  def contact_mail(feed)
    @contact = feed
    mail to: "kokubuempire@gmail.com", subject: "投稿完了メール"
  end
end
