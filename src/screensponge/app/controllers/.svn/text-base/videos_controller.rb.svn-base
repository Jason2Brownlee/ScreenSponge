class VideosController < ApplicationController
  
  before_filter :load_show
  
  # GET /videos
  # GET /videos.xml
  def index
    @videos = params[:list]=="all" ? @show.group_videos : @show.videos.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = @show.videos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = @show.videos.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = @show.videos.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = @show.videos.build(params[:video])

    respond_to do |format|
      if @video.save
        AnnotationActivity.new_video(@show, @user, @video)
        flash[:notice] = 'Video was successfully created.'
        format.html { redirect_to([@user, @show]) }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = @show.videos.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        flash[:notice] = 'Video was successfully updated.'
        format.html { redirect_to([@user, @show]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = @show.videos.find(params[:id])
    @video.destroy

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
