class BuildsController < ApplicationController
  def new
    @build = Build.new
    @build.build_files.new
  end

  def create
    @build = Build.new(build_params)
  end

  private

  def build_params
    params.require(:build).permit(:build_files_attributes)
  end
end
