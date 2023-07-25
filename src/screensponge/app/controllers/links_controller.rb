class LinksController < ApplicationController

  before_filter :load_show

  # GET /links
  # GET /links.xml
  def index
    @links = params[:list]=="all" ? @show.group_links : @show.links.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = @show.links.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = @show.links.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = @show.links.find(params[:id])
  end

  # POST /links
  # POST /links.xml
  def create
    @link = @show.links.build(params[:link])

    respond_to do |format|
      if @link.save
        AnnotationActivity.new_link(@show, @user, @link)
        flash[:notice] = 'Link was successfully created.'
        format.html { redirect_to([@user, @show]) }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = @show.links.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:notice] = 'Link was successfully updated.'
        format.html { redirect_to([@user, @show]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = @show.links.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to([@user, @show]) }
      format.xml  { head :ok }
    end
  end
  
  
  private
  
  def load_show
    @show = Show.find(params[:show_id])
    @user = @show.user
  end
end
