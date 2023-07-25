class PlotsController < ApplicationController

   before_filter :load_show
  
  # GET /plots
  # GET /plots.xml
  def index
    @plots = params[:list]=="all" ? @show.group_plots : @show.plots(:first)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plots }
    end
  end

  # GET /plots/1
  # GET /plots/1.xml
  def show
    @plot = @show.plots.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plot }
    end
  end

  # GET /plots/new
  # GET /plots/new.xml
  def new
    #hack
    @plot = @show.plots.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plot }
    end
  end

  # GET /plots/1/edit
  def edit
    @plot = @show.plots.find(params[:id])
  end

  # POST /plots
  # POST /plots.xml
  def create
    @plot = @show.plots.build(params[:plot])

    respond_to do |format|
      if @plot.save
        AnnotationActivity.new_plot(@show, current_user, @plot)
        flash[:notice] = 'Plot was successfully created.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { render :xml => @plot, :status => :created, :location => @plot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @plot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plots/1
  # PUT /plots/1.xml
  def update
    @plot = @show.plots.find(params[:id])

    respond_to do |format|
      if @plot.update_attributes(params[:plot])
        AnnotationActivity.update_plot(@show, current_user, @plot)
        flash[:notice] = 'Plot was successfully updated.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /plots/1
  # DELETE /plots/1.xml
  def destroy
    @plot = @show.plots.find(params[:id])
    @plot.destroy

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
