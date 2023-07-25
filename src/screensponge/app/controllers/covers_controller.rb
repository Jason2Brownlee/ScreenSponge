class CoversController < ApplicationController
  
  before_filter :load_show
  
  # GET /covers
  # GET /covers.xml
  def index
     @covers = params[:list]=="all" ? @show.group_covers : @show.covers.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @covers }
    end
  end

  # GET /covers/1
  # GET /covers/1.xml
  def show
    @cover = @show.covers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cover }
    end
  end

  # GET /covers/new
  # GET /covers/new.xml
  def new
    @cover = @show.covers.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cover }
    end
  end

  # GET /covers/1/edit
  def edit
    @cover = @show.covers.find(params[:id])
  end

  # POST /covers
  # POST /covers.xml
  def create
    @cover = @show.covers.build(params[:cover])

    respond_to do |format|
      if @cover.save
        AnnotationActivity.new_cover(@show, current_user, @cover)
        flash[:notice] = 'Cover was successfully created.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { render :xml => @cover, :status => :created, :location => @cover }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cover.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /covers/1
  # PUT /covers/1.xml
  def update
    @cover = @show.covers.find(params[:id])

    respond_to do |format|
      if @cover.update_attributes(params[:cover])
        flash[:notice] = 'Cover was successfully updated.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cover.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /covers/1
  # DELETE /covers/1.xml
  def destroy
    @cover = @show.covers.find(params[:id])
    @cover.destroy

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
