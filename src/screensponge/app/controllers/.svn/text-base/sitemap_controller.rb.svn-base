class SitemapController < ActionController::Base
  def sitemap
      @shows = Show.find(:all, :group=>"global_id", :order=>"updated_at DESC")
      render :action => 'google_sitemap'
  end
end
