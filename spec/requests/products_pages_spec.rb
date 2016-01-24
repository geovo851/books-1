require 'rails_helper'

describe 'Books online pages' do

  subject { page }

  shared_examples_for 'all pages' do
    it { is_expected.to have_selector(selector, text: heading) }
    it { is_expected.to have_title("#{page_title} | Books online") }
  end

  describe 'Books page' do
    let(:heading)    { 'Books' }
    let(:page_title) { 'Books' }
    let(:selector)   { 'h2' }

    context "headers" do
      before { visit root_path }
      it_should_behave_like "all pages"
      it { is_expected.to_not have_title('Contact Us | Books online') }
    end

    describe 'pagination' do
      context 'when pagination is found' do
        before do
          15.times { FactoryGirl.create(:book) }
          visit root_path
        end
        it { expect(page).to have_css('.pagination') }
      end

      context 'when pagination is not found' do
        before do
          1.times { FactoryGirl.create(:book) }
          visit root_path
        end
        it { expect(page).to_not have_css('.pagination') }
      end
    end
  end

  describe 'Book page' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:book) { FactoryGirl.create(:book, user: user) }
    let(:heading)    { book.title }
    let(:page_title) { book.title }
    let(:selector)   { 'h1' }

    before do
      visit root_path
      click_link book.title
    end

    context "headers" do
      it_should_behave_like "all pages"
    end
  end

  describe 'Book new page' do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit root_path
      click_button "Add book"
    end

    context 'when valid create book' do
      before do
        fill_in 'Title',  with: 'Book'
        fill_in 'Content', with: 'Content'
        click_button "Create book"
      end
      it { expect(page).to have_css('.alert-success', text: 'Book was successfully created.') }
    end

    context 'when invalid create book' do
      before do
        click_button "Create book"
      end
      it { expect(page).to_not have_css('.alert-success', text: 'Book was successfully created.') }
    end
  end

  describe 'About page' do
    before { visit about_path }
    let(:heading)    { 'Welcome to "Books online"' }
    let(:page_title) { 'About' }
    let(:selector)   { 'h1' }

    context "headers" do
      it_should_behave_like "all pages"
      it { is_expected.to_not have_title('Books | Books online') }
    end
  end

  describe 'Contact us page' do
    before { visit contact_path }
    let(:heading)    { 'Contact us' }
    let(:page_title) { 'Contact Us' }
    let(:selector)   { 'h1' }

    context "headers" do
      it_should_behave_like "all pages"
      it { is_expected.to_not have_title('About | Books online') }
    end
  end
end