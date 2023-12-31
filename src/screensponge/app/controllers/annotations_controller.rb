class AnnotationsController < ApplicationController
  
  before_filter :load_show
  
  # GET /annotations
  # GET /annotations.xml
  def index
    @annotations = Annotation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @annotations }
    end
  end

  # GET /annotations/1
  # GET /annotations/1.xml
  def show
    @annotation = Annotation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @annotation }
    end
  end

  # GET /annotations/new
  # GET /annotations/new.xml
  def new
    @annotation = Annotation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @annotation }
    end
  end

  # GET /annotations/1/edit
  def edit
    @annotation = Annotation.find(params[:id])
  end

  # POST /annotations
  # POST /annotations.xml
  def create
    @annotation = @show.annotations.build(params[:annotation])

    respond_to do |format|
      if @annotation.save
        flash[:notice] = 'Annotation was successfully created.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { render :xml => @annotation, :status => :created, :location => @annotation }
        format.js # renders create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @annotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /annotations/1
  # PUT /annotations/1.xml
  def update
    @annotation = Annotation.find(params[:id])

    respond_to do |format|
      if @annotation.update_attributes(params[:annotation])
        flash[:notice] = 'Annotation was successfully updated.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @annotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /annotations/1
  # DELETE /annotations/1.xml
  def destroy
    @annotation = Annotation.find(params[:id])
    @annotation.destroy

    respond_to do |format|
      format.html { redirect_to [current_user, @show] }
      format.xml  { head :ok }
      format.js # renders destroy.js.rjs
    end
  end
  
  private
  
  def load_show
    @show = Show.find(params[:show_id])
  end
  
end
