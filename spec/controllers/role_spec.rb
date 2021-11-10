require 'rails_helper'

RSpec.describe RolesController, type: :controller do

  let(:admin) { create :admin }

  let(:role) { create :role }
  let(:role_2) { create :role }
  let(:role_attributes) { attributes_for(:role) }

  let(:user) { User.create!("email" => "example@example.com",
    "name" => "example",
    "password" => "aaaaaaaa",
    "password_confirmation" => "aaaaaaaa",
    "role" => role_2 ) }

  describe 'GET /role' do
    before { sign_in admin }

    describe 'index' do
      it 'get roles' do
        get :index
        expect(response.status).to eq(200)  
      end
    end

    describe 'show' do
      it 'show role' do
        get :show, params: { id: role.id }
        expect(response.status).to eq(200)  
      end

      it 'assosciated users with role' do
        user

        get :show, params: { id: role_2.id }
        expect(response.status).to eq(200)
      end
    end

    describe 'edit' do
      it 'edit role' do
        get :edit, params: { id: role.id, role: { "name" => "New name" } }
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /role' do
    before { sign_in admin }  

    describe 'create' do
      it 'redirects_to /roles/:id' do
        post :create, params: { role: role_attributes }
        
        expect(response.status).to redirect_to Role.last
      end

      it 'create role with invalid attributes' do
        post :create, params: { role: { "name" => "" } }
        expect(response).to render_template("new")  
      end
    end

    describe 'update' do
      it 'update role with valid attributes' do
        put :update, params: { id: role.id, role: { "name" => "new name" }}  
        expect(Role.last.name).to eq('new name')
      end

      it 'update role with invalid attributes' do
        put :update, params: { id: role.id, role: { "name" => "" } }
        expect(response).to render_template("edit")  
      end
    end
  end

  describe 'DELETE /role' do
    before { sign_in admin }

    it 'destroy the requested role' do
      role

      expect {
        delete :destroy, params: { id: role.id }
      }.to change(Role, :count).by(-1)
    end
  end
end
