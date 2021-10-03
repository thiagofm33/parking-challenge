module App::NumericHelpers

  def to_human_duration
    hours    = (self / 3600).floor
    duration = (self % 3600).floor
    minutes  = (duration / 60).floor
    seconds  = (duration % 60).floor

    duration = [
      ("#{hours} #{'hour'.pluralize(hours)}" if hours   > 0),
      ("#{minutes} #{'minute'.pluralize(minutes)}" if minutes > 0),
      ("#{seconds} #{'second'.pluralize(seconds)}" if seconds > 0)
    ].compact

    duration.insert(1, ' ') if duration.length > 2
    duration.insert(-2, ' and ') if duration.length > 1
    duration.join('')
  end

end
