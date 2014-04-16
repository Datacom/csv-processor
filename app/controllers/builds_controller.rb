class BuildsController < ApplicationController
  def new
    @build = Build.new
  end

  def create
    @build = Build.new(params[:build])
  end
end
