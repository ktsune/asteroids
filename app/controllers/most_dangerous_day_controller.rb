class MostDangerousDayController < ApplicationController
  def index
    render locals: { facade: DangerousDay.new(params[:start_date], params[:end_date])}
  end
end
