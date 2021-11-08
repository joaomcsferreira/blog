require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

    let(:user) { create :user }
    let(:user_2) { create :user }
    let(:admin) { create :admin }
    let(:article) { create :article, user: user }


    describe "GET /articles" do
        it 'get index' do
            get :index
      
            expect(response.status).to eq(302)
        end

        it 'get show' do
            get :show, params: { id: article.id }
      
            expect(response.status).to eq(302)
        end
      
        it 'get edit' do
            get :edit, params: { id: article.id }
        
            expect(response.status).to eq(302)
        end

        it 'only the editor of the article can edit it' do
        end

        it 'get new' do
            get :new

            expect(response.status).to eq(302)
        end
    end

    describe "POST /article" do
        it 'create article with correct attributes' do
          post :create, params: { article: article }
    
          expect(Article.count).to eq(1)
          expect(Article.first.title).to eq(article.title)
        end
    
        it 'update article with correct attributes' do
          sign_in user
          put :update, params: { :id => article.id, :article => { "title" => "New title" } }

          expect(Article.count).to eq(1)
          expect(Article.first.title).to eq("New title")
        end
      end

    describe "DELETE /article" do
        it "destroys the requested article" do
          sign_in user
          article
          expect {
            delete :destroy, params: { id: article.id }
          }.to change(Article, :count).by(-1)
        end

        it 'redirects to the article list' do
            sign_in user
            article
            
            delete :destroy, params: {id: article.id}
            expect(response).to redirect_to(articles_path)
        end

        it 'author cannot delete article by another author' do
            sign_in user_2
            article

            delete :destroy, params: { id: article.id }
            expect(Article.count).to eq(1)
        end

        it 'admin can delete any article' do
            sign_in admin
            article

            puts response.body

            expect {
                delete :destroy, params: { id: article.id }
            }.to change(Article, :count).by(-1)
        end
    end
end
