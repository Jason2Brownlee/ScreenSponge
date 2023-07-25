class FeedsController < ApplicationController

  before_filter :login_required
  
  def mini_feed
    @requests = Request.get_requests(current_user)

    respond_to do |format|
      format.html { render_partial 'mini_feed'}
      format.xml  { render :xml => @requests }
    end
  end
  
end
  