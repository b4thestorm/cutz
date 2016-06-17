require 'rails_helper'

RSpec.describe BarberController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find" do
    it "returns http success" do
      get :find
      expect(response).to have_http_status(:success)
    end
  end

end
