module ApplicationHelper
  def pretty_timestamp(time)
    now = Time.now
    short = time.strftime("%I:%M %p")

    if time.today?
      "at #{short}"
    elsif time.to_date == Date.yesterday
      "yesterday at #{short}"
    elsif time > 1.week.ago
      "#{time_ago_in_words(time)} ago"
    elsif time > 1.year.ago
      "on #{time.strftime('%b %d')}"
    else
      "on #{time.strftime('%b %d, %Y')}"
    end
  end
end
