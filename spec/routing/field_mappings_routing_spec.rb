require "spec_helper"

describe FieldMappingsController do
  describe "routing" do

    it "routes to #index" do
      get("/field_mappings").should route_to("field_mappings#index")
    end

    it "routes to #new" do
      get("/field_mappings/new").should route_to("field_mappings#new")
    end

    it "routes to #show" do
      get("/field_mappings/1").should route_to("field_mappings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/field_mappings/1/edit").should route_to("field_mappings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/field_mappings").should route_to("field_mappings#create")
    end

    it "routes to #update" do
      put("/field_mappings/1").should route_to("field_mappings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/field_mappings/1").should route_to("field_mappings#destroy", :id => "1")
    end

  end
end
