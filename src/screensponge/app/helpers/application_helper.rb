# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # the name of the website used in views
  def site_name
    "Screen Sponge"
  end
  
  def site_motto
    "Connecting you with shows you want"
  end

  # the url of the site when displayed in the views
  def site_url
    "#{SITE_URL}"
  end
  
  # the name of the company used in the views
  def company_name
    "Mayhem"
  end
  
  def company_fullname
    "Mayhem"
  end
  
  # for privacy and such
  def site_physical_location
    "Commonwealth of Australia"
  end
  
  def support_email
    return "dev@spicyelephant.com"
  end
  
  # title convention used in the sute
  def title(page_title=nil)
    if !page_title.nil?
	    content_for(:title) { "#{site_name} - #{page_title}" }
	  else
	    content_for(:title) { "#{site_name}" }
	  end
	end

	   # Friendly Timestamp based on:
  #   http://almosteffortless.com/2007/07/29/the-perfect-timestamp/
  #   http://railsforum.com/viewtopic.php?pid=33185#p33185
  #
  # TODO : Update this to support time zones when added to this app, see example links above for possible help with that.
  def time_distance_or_time_stamp(time = nil, options = {})

    # base time is the time we measure against.  It is now by default.
    base_time = options[:base_time] ||= Time.now

    return '&ndash;' if time.nil?

    direction = (time.to_i < base_time.to_i) ? "ago" : "from now"
    distance_in_minutes = (((base_time - time).abs)/60).round
    distance_in_seconds = ((base_time - time).abs).round

    case distance_in_minutes
      when 0..1        then time = (distance_in_seconds < 60) ? "#{pluralize(distance_in_seconds, 'second')} #{direction}" : "1 minute #{direction}"
      when 2..59       then time = "#{distance_in_minutes} minutes #{direction}"
      when 60..90      then time = "1 hour #{direction}"
      when 90..1440    then time = "#{(distance_in_minutes.to_f / 60.0).round} hours #{direction}"
      when 1440..2160  then time = "1 day #{direction}" # 1 day to 1.5 days
      when 2160..2880  then time = "#{(distance_in_minutes.to_f / 1440.0).round} days #{direction}" # 1.5 days to 2 days
      else time = time.strftime("%d %b %Y")
    end
    return time_stamp(time) if (options[:show_time] && distance_in_minutes > 2880)
    return time
  end

  def time_stamp(time)
    time.to_datetime.strftime("%a, %d %b %Y, %l:%M%P").squeeze(' ')
  end

  def snippet(thought, wordcount) 
    thought.split[0..(wordcount-1)].join(" ") +(thought.split.size > wordcount ? "..." : "") 
  end
	
end
