require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

    let(:admin) { create :admin }

    let(:user) { create :user }
    let(:user_2) { create :user }

    let(:article) { create :article, user: user }
    let(:article_2) { create :article, user: user_2 }
    let(:article_attributes) { attributes_for(:article) }


    describe "GET /articles" do
        before do
            sign_in user
        end

        describe "index" do
            it 'assigns @article' do
                article

                get :index
                expect(assigns(:articles)).to eq([article])
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
                get :show, params: { id: article.id }
          
                expect(response.status).to eq(200)
            end

            it "renders the show template" do

                get :show, params: { id: article.id }
                expect(response).to render_template("show")
            end
        end
      
        describe "edit" do
            it 'get edit' do
                get :edit, params: { id: article.id }
            
                expect(response.status).to eq(200)
            end

            it "renders the edit template" do
                get :edit, params: { id: article.id }

                expect(response).to render_template("edit")   
            end
    
            it 'only the editor of the article can edit it' do
                get :edit, params: { id: article_2.id }

                expect(response.status).to eq 302
            end
        end

        describe "new" do
            it 'get new' do
                get :new
    
                expect(response.status).to eq(200)
            end

            it "renders the new template" do
                get :new
                expect(response).to render_template("new")   
            end
        end
    end

    describe "POST /article" do

        describe "create" do
            it 'redirects_to /articles/:id' do
                sign_in user
                post :create, params: { article: article_attributes }

                expect(response.status).to redirect_to(Article.last)
            end

            it 'articles iguais' do
                sign_in user
                post :create, params: { article: { "title" => "Invalid value" } }

                expect(response).to render_template("new")
                expect(response.status).to eq(422)
            end

            it 'responds to html by default' do
                post :create, params: { article: article }

                expect(response.content_type).to eq "text/html; charset=utf-8"
            end

            it "responds to custom formats when provided in the params" do
                post :create, :params => { :article => article, :format => :json }
                expect(response.content_type).to eq "application/json; charset=utf-8"
            end
        end
        
        it 'create article with correct attributes' do
          post :create, params: { article: article }
    
          expect(Article.count).to eq(1)
          expect(Article.first.title).to eq(article.title)
        end

    end

    describe "PUT /articles" do
        
        it 'update article with correct attributes' do
            sign_in user
            put :update, params: { :id => article.id, :article => { "title" => "New title" } }
            
            expect(Article.count).to eq(1)
            expect(Article.first.title).to eq("New title")
        end

        it 'articles iguais' do
            sign_in user
            put :update, params: { :id => article.id, article: { "title" => "" } }

            expect(response).to render_template("edit")
            expect(response.status).to eq(422)
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
