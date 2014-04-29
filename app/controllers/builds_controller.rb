class BuildsController < ApplicationController
  before_filter :find_build, except: [:index, :new, :create]

  def index
    @builds = Build.all
  end

  def new
    @build = Build.new
    @build.build_files.new
    render :show
  end

  def show
  end

  def update
    if @build.update(build_params)
      redirect_to @build, notice: 'Build was successfully updated.'
    else
      render action: 'show' 
    end
  end

  def add_file
    @build.build_files.new
    render :show
  end

  private

  def find_build
    @build = Build.find(params[:id] || params[:build_id])
  end

  def build_params
    params.require(:build).permit(build_files_attributes: [:file, :rule_set_id])
  end
end
