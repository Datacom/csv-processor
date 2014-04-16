require 'spec_helper'

describe "rule_sets/show" do
  before(:each) do
    @rule_set = assign(:rule_set, stub_model(RuleSet,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
