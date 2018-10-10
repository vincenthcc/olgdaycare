class OlgMailer < ApplicationMailer
  def stuff
    mail(
      to: 'marc@mahcsoft.com',
      from: 'errors@mahcsoft.com',
      subject: "error message"
    )
    @params = params
  end
end
