class FieldMappingsController < ApplicationController
  before_action :set_field_mapping, only: [:show, :edit, :update, :destroy]

  # GET /field_mappings
  # GET /field_mappings.json
  def index
    @field_mappings = FieldMapping.all
  end

  # GET /field_mappings/1
  # GET /field_mappings/1.json
  def show
  end

  # GET /field_mappings/new
  def new
    @field_mapping = FieldMapping.new
  end

  # GET /field_mappings/1/edit
  def edit
  end

  # POST /field_mappings
  # POST /field_mappings.json
  def create
    @field_mapping = FieldMapping.new(field_mapping_params)

    respond_to do |format|
      if @field_mapping.save
        format.html { redirect_to @field_mapping, notice: 'Field mapping was successfully created.' }
        format.json { render action: 'show', status: :created, location: @field_mapping }
      else
        format.html { render action: 'new' }
        format.json { render json: @field_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /field_mappings/1
  # PATCH/PUT /field_mappings/1.json
  def update
    respond_to do |format|
      if @field_mapping.update(field_mapping_params)
        format.html { redirect_to @field_mapping, notice: 'Field mapping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @field_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /field_mappings/1
  # DELETE /field_mappings/1.json
  def destroy
    @field_mapping.destroy
    respond_to do |format|
      format.html { redirect_to field_mappings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field_mapping
      @field_mapping = FieldMapping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def field_mapping_params
      params.require(:field_mapping).permit(:rule_set_id, :src_field_name, :out_field_name)
    end
end
