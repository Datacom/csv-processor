class BuildFilesController < ApplicationController
  before_filter :find_build_file, except: [:index, :new, :create]

  def move_up
    prev = @build_file.prev
    positions = [@build_file.position, prev.position]
    prev.position = 0
    prev.save
    prev.position, @build_file.position = positions
    [@build_file, prev].each &:save
    redirect_to @build_file.build
  end

  def move_down
    foll = @build_file.foll
    positions = [@build_file.position, foll.position]
    foll.position = 0
    foll.save
    foll.position, @build_file.position = positions
    [@build_file, foll].each &:save
    redirect_to @build_file.build
  end

  def destroy
    @build_file.destroy
    redirect_to @build_file.build
  end

  private

  def find_build_file
    @build_file = BuildFile.find(params[:id] || params[:build_file_id])
  end

  def build_file_params
    params.require(:build_file).permit()
  end
end
