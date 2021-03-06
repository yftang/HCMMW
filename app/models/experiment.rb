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

class Experiment < ActiveRecord::Base
  attr_accessible :description, :input, :output, :user_id

  belongs_to :user

  validates :description, :presence => true,
                          :length => { :maximum => 40 }
  validates :user_id,     :presence => true

  mount_uploader :input, InputUploader

  default_scope :order => 'experiments.created_at DESC'
end
