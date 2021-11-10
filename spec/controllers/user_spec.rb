require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    let(:user) { create :user }
    let(:user_2) { create :user }
    
    let(:admin) { create :admin }

    let(:leader_writer) { create :leader_writer }

    let(:user_attributes) { attributes_for(:user) }

    describe "GET /users" do 
        before do
            sign_in admin    
        end

        describe "index" do

            it 'assigns @user' do
                get :index
                expect(assigns(:users)).to eq([admin])
            end

            it 'get index' do
                get :index
                expect(response.status).to eq(200)
            end

            it "renders the index template" do

                get :index
                expect(response).to render_template("index")
            end
        end

        describe "show" do
            it 'get show' do
                get :show, params: { id: user.id }
          
                expect(response.status).to eq(200)
            end

            it 'render the show template' do

                get :show, params: { id: user.id} 
                expect(response).to render_template("show")    
            end

            it 'show current user' do
                get :show, params: { id: admin.id }

                expect(response.status).to eq(200)
            end

            it "Leader writer can show article" do
                sign_in leader_writer
                
                get :show, params: { id: leader_writer.id }
                expect(response.status).to eq(302)
            end
        end

        describe 'edit' do
            it 'get edit' do
                get :edit, params: { id: user.id }
            
                expect(response.status).to eq(200)
            end
        end
        
        describe 'new' do
            it 'get new' do
                get :new
    
                expect(response).to have_http_status(200)
            end 
        end 
    end

    describe "POST /users" do
        before do
            sign_in admin    
        end

        describe "create" do
            it 'redirect to /users/:id' do
                post :create, params: { user: user_attributes }
                
                expect(response.status).to redirect_to(User.last)
            end
            
            it 'create users com valid attributtes' do
                expect {
                    post :create, params: { user: user_attributes }
                }.to change(User, :count).by(1)
            end

            it 'create users with invalid params' do
                post :create, params: { user: { "name" => "" } }
                
                expect(response.status).to eq(422)
            end
        end

        describe 'update' do
            it 'update user' do
                expect {
                    put :update, params: { :id => user.id, user: { "name" => "Jon" } }
                }.to change(User, :count).by(1)
            end

            it 'update all params user' do
                expect {
                    put :update, params: { id: user.id, user: user_attributes }    
                }.to change(User, :count).by(1)
            end

            it 'update user with invalid params' do
                put :update, params: { id: user.id, user: { "name" => "" }}
                expect(response).to render_template("edit")    
            end
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

    describe 'registration#update' do
        before { sign_in user }

        it 'signing in a registred user ' do
            expect(subject.user_signed_in?).to be true
        end    
    end
end