require 'spec_helper'
require 'faker'

describe ExperimentsController do
  render_views

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
    end

    describe "failure" do
      before(:each) do
        @attr = { :description => "" }
      end

      it "should not create an experiment" do
        lambda do
          post :create, :experiment => @attr
        end.should_not change(Experiment, :count)
      end

      it "should redirect to create page of experiment" do
        post :create, :experiment => @attr
        response.should render_template('experiments/new')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :description => "Lorem ipsum" }
      end

      it "should create an experiment" do
        lambda do
          post :create, :experiment => @attr
        end.should change(Experiment, :count).by(1)
      end

      it "should have a flush message" do
        post :create, :experiment => @attr
        flash[:success].should =~ /experiment created/i
      end
    end
  end

  describe "DELETE 'destroy'" do
    describe "for an unauthorized user" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        wrong_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
        test_sign_in(wrong_user)
        @experiment = FactoryGirl.create(:experiment, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @experiment
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do
      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        @exp = FactoryGirl.create(:experiment, :user => @user)
      end

      it "should destroy the experiment" do
        lambda do
          delete :destroy, :id => @exp
        end.should change(Experiment, :count).by(-1)
      end
    end
  end
end
