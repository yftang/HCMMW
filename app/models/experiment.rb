class Experiment < ActiveRecord::Base
  attr_accessible :description, :input, :output, :user_id
end
