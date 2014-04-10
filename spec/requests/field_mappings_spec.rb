require 'spec_helper'

describe "FieldMappings" do
  describe "GET /field_mappings" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get field_mappings_path
      response.status.should be(200)
    end
  end
end
