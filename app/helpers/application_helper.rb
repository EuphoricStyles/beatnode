module ApplicationHelper
  def pretty_timestamp(time)
    if time.today?
      "at #{time.strftime("%I:%M %p")}"
    elsif time.to_date == Date.yesterday
      "yesterday at #{time.strftime("%I:%M %p")}"
    elsif time > 1.week.ago
      "#{time_ago_in_words(time)} ago"
    elsif time.year == Time.now.year
      "on #{time.strftime('%B %e').gsub(/\s+/, ' ')}"
    else
      "on #{time.strftime('%B %e, %Y').gsub(/\s+/, ' ')}"
    end
  end
end
