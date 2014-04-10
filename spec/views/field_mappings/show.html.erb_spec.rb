require 'spec_helper'

describe "field_mappings/show" do
  before(:each) do
    @field_mapping = assign(:field_mapping, stub_model(FieldMapping,
      :rule_set => nil,
      :src_field_name => "Src Field Name",
      :out_field_name => "Out Field Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Src Field Name/)
    rendered.should match(/Out Field Name/)
  end
end
