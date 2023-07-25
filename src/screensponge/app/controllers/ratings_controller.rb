class RatingsController < ApplicationController
  
  before_filter :load_show
  
  # ratings doesn't support passing an authentication token, this seems a low risk to disable forgery protection for ratings
  skip_before_filter :verify_authenticity_token
  
  # GET /ratings
  # GET /ratings.xml
  def index
    @ratings = Rating.find(:all)
    @user = current_user

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ratings }
    end
  end

  # GET /ratings/1
  # GET /ratings/1.xml
  def show
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.xml
  def update
    if @show.user != current_user
      return
    end
    
    if @show.rating.nil?
      @show.create_rating(params[:rating])
    else
      @show.rating.update_attributes(params[:rating])
    end
    
    respond_to do |format|
      if @show.rating.save
        ShowActivity.rated_show(@show, current_user)
        flash[:notice] = 'Rating was successfully updated.'
        format.html { redirect_to(user_show_ratings_path(@user, @show)) }
        format.xml  { head :ok }
        format.js  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
        format.js  { head :bad }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.xml
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to(ratings_url) }
      format.xml  { head :ok }
    end
  end
end
