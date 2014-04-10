require "spec_helper"

describe RuleSetsController do
  describe "routing" do

    it "routes to #index" do
      get("/rule_sets").should route_to("rule_sets#index")
    end

    it "routes to #new" do
      get("/rule_sets/new").should route_to("rule_sets#new")
    end

    it "routes to #show" do
      get("/rule_sets/1").should route_to("rule_sets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rule_sets/1/edit").should route_to("rule_sets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rule_sets").should route_to("rule_sets#create")
    end

    it "routes to #update" do
      put("/rule_sets/1").should route_to("rule_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rule_sets/1").should route_to("rule_sets#destroy", :id => "1")
    end

  end
end
