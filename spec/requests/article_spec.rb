require 'rails_helper'

RSpec.describe "Articles", type: :request do
    describe "GET /articles" do
        it "works! (now write some real specs)" do
          get articles_path
          expect(response.status).to be(302)
        end
    end
end
