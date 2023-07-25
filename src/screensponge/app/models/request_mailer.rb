class RequestMailer < ActionMailer::Base
  
  def request_notification(request)
    requested_show = request.requested_show
    requested_user = requested_show.user
    requesting_user = request.wanted_show.user
    
    @recipients  = "#{requested_user.email}"
    @from        = "\"#{requesting_user.humanized_name}\"<#{SUPPORT_EMAIL}>"
    @reply_to    = "#{requesting_user.email}"
    @subject     = "#{requesting_user.humanized_name} has requested the show '#{requested_show.full_name}'"
    @sent_on     = Time.now
    @body[:requested_user] = requested_user
    @body[:requesting_user] = requesting_user
    @body[:requested_show] = requested_show
    @body[:request] = request
  end

end

