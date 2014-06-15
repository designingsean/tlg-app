module ClockHelper

  def format(datetime, time)
    unless datetime.nil?
      if time
        return datetime.strftime("%l:%M %P")
      end
      datetime.strftime("%a, %b %-d")
    end
  end

  def period_total(period)
    total = 0
    period.each do |week|
      total += week.sum(:totalTime)
    end
    return total
  end

  def last_action(record)
    if record.clockOut.nil?
      ('Clocked in ' + time_ago_in_words(record.clockIn) + ' ago <a href="#" class="btn btn-primary btn-sm">Clock Out</a>').html_safe
    else
      ('Clocked out ' + time_ago_in_words(record.clockOut) + ' ago <a href="#" class="btn btn-primary btn-sm">Clock In</a>').html_safe
    end
  end

end
