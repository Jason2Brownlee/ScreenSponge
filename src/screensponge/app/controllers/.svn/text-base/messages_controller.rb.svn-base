class MessagesController < ApplicationController
  
  before_filter :load_show
  
  # GET /messages
  # GET /messages.xml
  def index
    
    @messages = params[:list]=="all" ? @show.group_messages : @show.messages.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = @show.messages.build
    
        respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @message }
        end
  end

  # GET /messages/1/edit
  def edit
    # @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = @show.messages.build(params[:message])

    respond_to do |format|
      if @message.save
        AnnotationActivity.new_message(@show, current_user, @message)
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { redirect_to [current_user, @show] }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    # @message = Message.find(params[:id])
    # 
    #     respond_to do |format|
    #       if @message.update_attributes(params[:message])
    #         flash[:notice] = 'Message was successfully updated.'
    #         format.html { redirect_to [current_user, @show] }
    #         format.xml  { head :ok }
    #       else
    #         format.html { render :action => "edit" }
    #         format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
    #       end
    #     end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to [current_user, @show] }
      format.xml  { head :ok }
    end
  end
  
  
  private
  
  def load_show
    @show = Show.find(params[:show_id])
    @user = @show.user
  end
  
end
