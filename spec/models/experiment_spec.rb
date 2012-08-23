# == Schema Information
#
# Table name: experiments
#
#  id          :integer          not null, primary key
#  description :string(255)
#  input       :string(255)
#  output      :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Experiment do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { :description => "First experiment" }
  end

  it "should create a new experiment" do
    @user.experiments.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @exp = @user.experiments.create(@attr)
    end

    it "should have a user attribute" do
      @exp.should respond_to(:user)
    end

    it "should have the right associated user" do
      @exp.user_id.should == @user.id
      @exp.user.should == @user
    end
  end

  describe "validations" do
    it "should require a user id" do
      Experiment.new(@attr).should_not be_valid
    end

    it "should require nonblank description" do
      @user.experiments.build(:description => " ").should_not be_valid
    end

    it "should reject description longer than 40" do
      @user.experiments.build(:description => "a" * 41).should_not be_valid
    end
  end
end
