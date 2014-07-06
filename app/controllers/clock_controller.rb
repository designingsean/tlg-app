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

  def edit
    @active_users = Users.active
    @current_period = Clock::Totals.range(params[:id], (Time.now))
  end

  def add_new
    timeIn = Time.zone.parse(params[:clock][:date] + ' ' + params[:clock][:in]).to_datetime
    timeOut = Time.zone.parse(params[:clock][:date] + ' ' + params[:clock][:out]).to_datetime
    clock = Clock.create(uid: params[:id], clockIn: timeIn, clockOut: timeOut)
    if clock.save
      flash[:success] = "Record added"
    else
      flash[:error] = "Record not added"
    end
    redirect_to action: 'edit', id: params[:id]
  end

  def destroy
    punch = Clock.find(params[:id])
    punch.destroy
    if punch.save
      flash[:success] = "Record deleted"
    else
      flash[:error] = "Record not deleted"
    end
    redirect_to action: 'edit', id: punch.uid
  end

  private
    def clock_params
      params.require(:clock).permit(:uid, :clockIn, :clockOut)
    end
end