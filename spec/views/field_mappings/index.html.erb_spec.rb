require 'spec_helper'

describe "field_mappings/index" do
  before(:each) do
    assign(:field_mappings, [
      stub_model(FieldMapping,
        :rule_set => nil,
        :src_field_name => "Src Field Name",
        :out_field_name => "Out Field Name"
      ),
      stub_model(FieldMapping,
        :rule_set => nil,
        :src_field_name => "Src Field Name",
        :out_field_name => "Out Field Name"
      )
    ])
  end

  it "renders a list of field_mappings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Src Field Name".to_s, :count => 2
    assert_select "tr>td", :text => "Out Field Name".to_s, :count => 2
  end
end
