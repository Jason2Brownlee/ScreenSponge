class PicturesController < ApplicationController
  before_filter :load_show
  
  # GET /pictures
  # GET /pictures.xml
  def index
    @pictures = params[:list]=="all" ? @show.group_pictures : @show.pictures.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = @show.pictures.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @picture = @show.pictures.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    @picture = @show.pictures.build(params[:picture])

    respond_to do |format|
      if @picture.save
        AnnotationActivity.new_picture(@show, current_user, @picture)
        flash[:notice] = 'Picture was successfully created.'
        format.html { redirect_to([@user, @show]) }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        flash[:notice] = 'Picture was successfully updated.'
        format.html { redirect_to(@picture) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = @show.pictures.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to([@user, @show]) }
      format.xml  { head :ok }
    end
  end
  
  def load_show
    @show = Show.find(params[:show_id])
    @user = @show.user
  end
  
end
