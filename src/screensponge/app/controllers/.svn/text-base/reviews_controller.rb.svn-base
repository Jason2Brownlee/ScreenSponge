class ReviewsController < ApplicationController
  
  before_filter :load_show
  
  # GET /reviews
  # GET /reviews.xml
  def index
   @reviews = params[:list]=="all" ? @show.group_reviews : @show.reviews.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = @show.reviews.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    @review = @show.reviews.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = @show.reviews.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = @show.reviews.build(params[:review])

    respond_to do |format|
      if @review.save
        AnnotationActivity.new_review(@show, current_user, @review)
        flash[:notice] = 'Review was successfully created.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = @show.reviews.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        flash[:notice] = 'Review was successfully updated.'
        format.html { redirect_to [current_user, @show] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = @show.reviews.find(params[:id])
    @review.destroy

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
