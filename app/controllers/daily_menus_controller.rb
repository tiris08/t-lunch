class DailyMenusController < ApplicationController
  def index
    @date = DateTime.now.strftime("%d %b %Y")
  end
end
