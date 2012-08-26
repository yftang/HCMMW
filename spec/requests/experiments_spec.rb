require 'spec_helper'

describe "Experiments" do
  before(:each) do
    user = FactoryGirl.create(:user)
    visit signin_path
    fill_in :email,     :with => user.email
    fill_in :password,  :with => user.password
    click_button
  end

  describe "creation" do
    describe "failure" do
      it "should not make a new experiment with no description" do
        lambda do
          visit 'experiments/new'
          fill_in :experiment_description,  :with => ""
          click_button
          response.should render_template('experiments/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Experiment, :count)
      end
    end

    describe "success" do
      it "should make a new experiment" do
        des = "New experiment"
        lambda do
          visit 'experiments/new'
          fill_in :experiment_description,  :with => des
          click_button
          response.should have_selector("span.description", :content => des)
        end.should change(Experiment, :count).by(1)
      end
    end
  end
end
