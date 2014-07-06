module ClockHelper

  def current_user
    unless params[:id].nil?
      return @active_users.find(params[:id]).name
    end
    'Who are you?'
  end

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
      'Clocked in ' + time_ago_in_words(record.clockIn) + ' ago'
    else
      'Clocked out ' + time_ago_in_words(record.clockOut) + ' ago'
    end
  end

  def current_action(record)
    if record.clockOut.nil?
      true
    else
      false
    end
  end

  def test(record)
    if record.clockOut.nil?
      link_to "Clock Out", update_clock_index_path(params[:id]), class: 'btn btn-primary btn-sm'
    else
      link_to "Clock In", create_clock_index_path(params[:id]), class: 'btn btn-primary btn-sm'
    end
  end

end
