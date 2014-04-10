require 'spec_helper'

describe "field_mappings/new" do
  before(:each) do
    assign(:field_mapping, stub_model(FieldMapping,
      :rule_set => nil,
      :src_field_name => "MyString",
      :out_field_name => "MyString"
    ).as_new_record)
  end

  it "renders new field_mapping form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", field_mappings_path, "post" do
      assert_select "input#field_mapping_rule_set[name=?]", "field_mapping[rule_set]"
      assert_select "input#field_mapping_src_field_name[name=?]", "field_mapping[src_field_name]"
      assert_select "input#field_mapping_out_field_name[name=?]", "field_mapping[out_field_name]"
    end
  end
end
