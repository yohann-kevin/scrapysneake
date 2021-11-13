require "rails_helper"

RSpec.describe SneakersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/sneakers").to route_to("sneakers#index")
    end

    it "routes to #show" do
      expect(get: "/sneakers/1").to route_to("sneakers#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/sneakers").to route_to("sneakers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/sneakers/1").to route_to("sneakers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/sneakers/1").to route_to("sneakers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/sneakers/1").to route_to("sneakers#destroy", id: "1")
    end
  end
end
