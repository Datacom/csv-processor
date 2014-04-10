require 'spec_helper'

describe "rule_sets/index" do
  before(:each) do
    assign(:rule_sets, [
      stub_model(RuleSet,
        :name => "Name"
      ),
      stub_model(RuleSet,
        :name => "Name"
      )
    ])
  end

  it "renders a list of rule_sets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
