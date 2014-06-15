class ClockController < ApplicationController
  def index
    @active_users = Users.active
  end

  def show
    @active_users = Users.active
    @current_period = Clock::Totals.range(params[:id], (Time.now))
    @previous_period = Clock::Totals.range(params[:id], (Time.now - 2.weeks))
    @last_action = Clock::Totals.last_action(params[:id])
  end

  def create
    Clock.create(clock_params)
  end

  def update
    clock = Clock.find(params[:id])
    clock.clockOut = params[:end]
    clock.save
  end

  def destroy
    Clock.destroy(params[:id])
  end

  private
    def clock_params
      params.require(:clock).permit(:uid, :clockIn, :clockOut)
    end
end