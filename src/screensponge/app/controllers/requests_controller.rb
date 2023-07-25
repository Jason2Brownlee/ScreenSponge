class RequestsController < ApplicationController
  
  before_filter :login_required
  
  # GET /requests
  # GET /requests.xml
  def index
    @requests = Request.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.xml
  def show
    @request = Request.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @request }
    end
  end

  # POST /requests
  # POST /requests.xml
  def create
    show = Show.find(params[:show_id])
    friend = find_user(params[:user_id])
    @request = show.requests.build()

    @request.requested_show = friend.shows.find_by_global_id(show.global_id)
    @request.wanted_show = current_user.shows.find_by_global_id(show.global_id)
    @request.message = params[:request_message]

    respond_to do |format|
      if show.save 
        #ShowActivity.new_show(@show, current_user)
        flash[:notice] = "A request has been sent to #{friend.login} for the show " + view_show_flash_link(show)
        format.html { redirect_to(user_shows_url(current_user)) }
        format.xml  { render :xml => @request, :status => :created, :location => @request }
        format.js #{ intentions.js.rjs }
      else
        flash[:notice] = 'Problem occurred creating the request for show ' + view_show_flash_link(@request)
        format.html { redirect_to(user_shows_url(current_user)) }
        format.xml  { render :xml => @request.errors, :status => :unprocessable_entity }
        format.js { head :bad } #{ render :template => "layout/message" }
      end
    end
  end
  
  def close
    show = Show.find(params[:show_id])
    friend = find_user(params[:user_id])
    request = Request.find(params[:id])
    request.closed = true
    
    respond_to do |format|
      if request.save 
        #ShowActivity.new_show(@show, current_user)
        flash[:notice] = "The request for " + view_show_flash_link(show) + " has been closed."
        format.html { redirect_to(user_shows_url(current_user)) }
        format.xml  { render :xml => @request, :status => :created, :location => @request }
        format.js #{ intentions.js.rjs }
      else
        flash[:notice] = 'Problem occurred closing the request for show ' + view_show_flash_link(@request)
        format.html { redirect_to(user_shows_url(current_user)) }
        format.xml  { render :xml => @request.errors, :status => :unprocessable_entity }
        format.js { head :bad } #{ render :template => "layout/message" }
      end
    end
    
  end

  # DELETE /requests/1
  # DELETE /requests/1.xml
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to(requests_url) }
      format.xml  { head :ok }
    end
  end
end
