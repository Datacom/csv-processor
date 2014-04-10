require 'spec_helper'

describe "rule_sets/new" do
  before(:each) do
    assign(:rule_set, stub_model(RuleSet,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new rule_set form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rule_sets_path, "post" do
      assert_select "input#rule_set_name[name=?]", "rule_set[name]"
    end
  end
end
