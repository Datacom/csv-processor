class BuildsController < ApplicationController
  before_filter :find_build, except: [:index, :new, :create]

  def index
    @builds = Build.all
  end

  def show
  end

  def update
    if @build.update(build_params)
      redirect_to @build, notice: 'Build was successfully updated.'
    else
      render action: 'edit' 
    end
  end

  private

  def find_build
    @build = Build.find(params[:id])
  end

  def build_params
    params.require(:build).permit(build_files_attributes: [:file, :rule_set_id])
  end
end
