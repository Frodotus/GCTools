require "spec_helper"

describe GeocachesController do
  describe "routing" do

    it "routes to #index" do
      get("/geocaches").should route_to("geocaches#index")
    end

    it "routes to #new" do
      get("/geocaches/new").should route_to("geocaches#new")
    end

    it "routes to #show" do
      get("/geocaches/1").should route_to("geocaches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/geocaches/1/edit").should route_to("geocaches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/geocaches").should route_to("geocaches#create")
    end

    it "routes to #update" do
      put("/geocaches/1").should route_to("geocaches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/geocaches/1").should route_to("geocaches#destroy", :id => "1")
    end

  end
end
