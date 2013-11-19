require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "Signup Page" do
    before { visit signup_path }

    it { should have_content('Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end

  describe 'profile page' do
    let( :user ) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
  
    it { should have_content( user.name ) }
    it { should have_title( user.name ) }
  end

  describe 'signup' do
    before { visit signup_path }
    
    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button "Create my account" }.not_to change(User, :count)
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'Name',         with: "Mark"
        fill_in 'Email',        with: "user@example.com"
        fill_in 'Password',     with: "foobar"
        fill_in 'Confirmation', with: "foobar"
      end

      it "should create a user" do
        expect { click_button "Create my account" }.to change(User, :count).by(1)
      end
    end
  end

end