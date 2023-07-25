class EventsController < ApplicationController
  
   before_filter :load_show
   
  # GET /events
  # GET /events.xml
  def index
    @events = params[:list]=="all" ? @show.group_events : @show.events.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = @show.events.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = @show.events.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = @show.events.build(params[:event])

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = @show.events.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to [current_user,@show] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = @show.events.find(params[:id])
    @event.destroy
    
    respond_to do |format|
      format.html { redirect_to [current_user, @show] }
      format.xml  { head :ok }
      format.js { head :ok }
    end
  end
  
  private
  
  def load_show
    @show = Show.find(params[:show_id])
    @user = @show.user
  end
end
