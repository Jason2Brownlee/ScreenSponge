class TypesController < ApplicationController
  
  before_filter :load_show
  
  # GET /types
  # GET /types.xml
  def index
    @types = @show.types.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @types }
    end
  end

  # GET /types/1
  # GET /types/1.xml
  def show
    @type = @show.types.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @type }
    end
  end

  # GET /types/new
  # GET /types/new.xml
  def new
    @type = @show.types.build
    # seed with movie
    @type.entry = "Movie"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @type }
    end
  end

  # GET /types/1/edit
  def edit
    @type = @show.types.find(params[:id])
  end

  # POST /types
  # POST /types.xml
  def create
    @type = @show.types.build(params[:type])

    respond_to do |format|
      if @type.save
        flash[:notice] = 'Type was successfully created.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { render :xml => @type, :status => :created, :location => @type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /types/1
  # PUT /types/1.xml
  def update
    @type = @show.types.find(params[:id])

    respond_to do |format|
      if @type.update_attributes(params[:type])
        flash[:notice] = 'Type was successfully updated.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /types/1
  # DELETE /types/1.xml
  def destroy
    @type = @show.types.find(params[:id])
    @type.destroy

    respond_to do |format|
      format.html {redirect_to [current_user, @show] }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def load_show
    @show = Show.find(params[:show_id])
    @user = @show.user
  end
  
end
