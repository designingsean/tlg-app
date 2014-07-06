class ClockController < ApplicationController
  def index
    @active_users = Users.active
  end

  def show
    @active_users = Users.active
    @current_period = Clock::Totals.range(params[:id], (Time.now))
    @previous_period = Clock::Totals.range(params[:id], (Time.now - 2.weeks))
    @last_action = Clock.last_action(params[:id])
  end

  def create
    clock = Clock.create(uid: params[:id], clockIn: Time.now)
    if clock.save
      flash[:success] = "You are clocked in"
    else
      flash[:error] = "You are not clocked in"
    end
    redirect_to action: 'show', id: params[:id]
  end

  def update
    clock = Clock.last_action(params[:id])
    clock.update(clockOut: Time.now)
    if clock.save
      flash[:success] = "You are clocked out"
    else
      flash[:error] = "You are not clocked out"
    end
    redirect_to action: 'show', id: params[:id]
  end

  def destroy
    Clock.destroy(params[:id])
  end

  private
    def clock_params
      params.require(:clock).permit(:uid, :clockIn, :clockOut)
    end
end