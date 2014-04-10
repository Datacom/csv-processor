require 'spec_helper'

describe "rule_sets/edit" do
  before(:each) do
    @rule_set = assign(:rule_set, stub_model(RuleSet,
      :name => "MyString"
    ))
  end

  it "renders the edit rule_set form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rule_set_path(@rule_set), "post" do
      assert_select "input#rule_set_name[name=?]", "rule_set[name]"
    end
  end
end
