class BuildsController < ApplicationController
  before_filter :find_build, except: [:index, :new, :create, :preview]

  def index
    @builds = Build.all
  end

  def new
    @build = Build.new
    render :show
  end

  def show
  end

  def preview
    tmp_build = Build.new(preview_params)
    render partial: 'preview', locals: {build: tmp_build}
  end

  def update
    if @build.update(build_params)
      redirect_to @build, notice: 'Build was successfully updated.'
    else
      flash.now[:alert] = @build.errors.full_messages.to_sentence
      render :show
    end
  end

  private

  def find_build
    @build = Build.find(params[:id] || params[:build][:id])
  end

  def build_params
    params.require(:build).permit(:name, build_files_attributes: [:file, :rule_set_id, :position, :_destroy])
  end

  def preview_params
    params.require(:build).permit(:id, build_files_attributes: [:id, :rule_set_id, :position, :_destroy, :filename, :raw])
  end
end
