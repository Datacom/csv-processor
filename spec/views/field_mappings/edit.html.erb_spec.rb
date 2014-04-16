require 'spec_helper'

describe "field_mappings/edit" do
  before(:each) do
    @field_mapping = assign(:field_mapping, stub_model(FieldMapping,
      :rule_set => nil,
      :src_field_name => "MyString",
      :out_field_name => "MyString"
    ))
  end

  it "renders the edit field_mapping form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", field_mapping_path(@field_mapping), "post" do
      assert_select "input#field_mapping_rule_set[name=?]", "field_mapping[rule_set]"
      assert_select "input#field_mapping_src_field_name[name=?]", "field_mapping[src_field_name]"
      assert_select "input#field_mapping_out_field_name[name=?]", "field_mapping[out_field_name]"
    end
  end
end
