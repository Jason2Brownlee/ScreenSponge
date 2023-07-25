class RequestObserver < ActiveRecord::Observer
  def after_create(request)
    RequestMailer.deliver_request_notification(request)
  end
end