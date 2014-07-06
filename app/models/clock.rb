class Clock < ActiveRecord::Base
  self.table_name = "clock"
  belongs_to :users
  validates :clockIn, :presence => true
  validates :uid, :presence => true

  def self.last_action(user)
    where(uid: user).last
  end

  class Totals < ActiveRecord::Base
    self.table_name = "v_clock"
    self.primary_key = "id"
    belongs_to :clock, foreign_key: "id"

    def self.range(user, date)
      range = find_range(date)
      data = where(uid: user, clockIn: range[:start]..range[:end]).order(:clockIn).reverse_order
      return [data.where(clockIn: range[:middle]..range[:end]), data.where(clockIn: range[:start]..range[:middle])]
    end

    private
      def self.find_range(date)
        init_date_mod = Time.new(2013, 1, 7).strftime("%U") % 2
        provided_date_mod = date.strftime("%U") % 2

        if provided_date_mod == init_date_mod
          first_week_start = date.beginning_of_week
        else
          first_week_start = date.last_week.beginning_of_week
        end
        return { start: first_week_start,
                 middle: first_week_start.next_week,
                 end: first_week_start.advance(weeks: 2) }
      end
  end
end