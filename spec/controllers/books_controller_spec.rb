require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  context "when user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:book, user: user) }

    before do
      sign_in user
    end

    describe "GET #show" do
      it "assigns the requested book to subject" do
        get :show, id: subject
        expect(assigns(:book)).to eq(subject)
      end

      it "renders the :show view" do
        get :show, id: subject
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "assigns the requested book to new project" do
        get :new
        expect(assigns(:book)).to be_new_record 
      end

      it "renders the :new view" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          expect{
            post :create, book: FactoryGirl.attributes_for(:book)
          }.to change(Book, :count).by(1)
        end

        it "rendirects to index path" do
          post :create, book: FactoryGirl.attributes_for(:book)
          expect(response).to redirect_to books_online_index_path
        end
      end

      context "with not valid attributes" do
        it "not save object to db" do
          expect{
            post :create, book: FactoryGirl.attributes_for(:invalid_book)
          }.to_not change(Book, :count)
        end

        it "render new view" do
          post :create, book: FactoryGirl.attributes_for(:invalid_book)
          expect(response).to render_template :new
        end
      end
    end

   describe "PATCH #update" do
      context "with valid attributes" do
        it "updates object" do
          expect{
            patch :update, id: subject, book: { title: 'new_book' }
          }.to change{ subject.reload.title }.to('new_book')
        end

        it "rendirects to index path" do
          patch :update, id: subject, book: { title: 'new_book' }
          expect(response).to redirect_to books_online_index_path
        end
      end

      context "with not valid attributes" do
        it "not save object to db" do
          expect{
            patch :update, id: subject, book: FactoryGirl.attributes_for(:invalid_book)
          }.to_not change{ subject.title }
        end

        it "render edit view" do
          post :update, id: subject, book: FactoryGirl.attributes_for(:invalid_book)
          expect(response).to render_template :edit
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested book to subject" do
        get :edit, id: subject
        expect(assigns(:book)).to eq(subject)
      end

      it "renders the :edit view" do
        get :edit, id: subject
        expect(response).to render_template :edit
      end
    end

    describe 'DELETE #destroy' do
      before(:each) { @book = FactoryGirl.create :book, user: user }

      it "deletes the book" do
        expect {
          delete :destroy, id: @book
        }.to change(Book, :count).by(-1)
      end

      it "redirects to books#index" do
        delete :destroy, id: @book
        expect(response).to redirect_to books_online_index_path
      end
    end
  end
end