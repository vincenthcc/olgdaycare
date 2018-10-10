module CommonFunctions
  def current_date
    Date.current.in_time_zone.strftime( '%F' )
  end
end
