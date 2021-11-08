require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    let(:user) { create :user }
    let(:user_2) { create :user }
    let(:admin) { create :admin }

    describe "GET /users" do
        it 'get index' do
            get :index
      
            expect(response.status).to eq(302)
        end

        it 'get show' do
            get :show, params: { id: user.id }
      
            expect(response.status).to eq(302)
        end
      
        it 'get edit' do
            get :edit, params: { id: user.id }
        
            expect(response.status).to eq(302)
        end

        it 'get new' do
            get :new

            expect(response.status).to eq(302)
        end    
    end

    describe "POST /users" do
        it 'create users com valid attributtes' do
            post :create, params: { user: user }

            expect(User.count).to eq(1) 
        end
    end

    describe "DELETE /users" do
        it 'destroy own user' do        
          sign_in user 

          expect { delete :destroy, params: { :id => user.id } }.to_not change(User, :count)
        end

        it 'admin can destroy any user' do
            sign_in admin

            delete :destroy, params: { id: user.id }

            expect(User.count).to eq(1)
        end

        it 'users cannot destroy other users' do
            sign_in user
            user_2

            delete :destroy, params: { id: user_2.id }

            expect(User.count).to eq(2)
        end

    end
end