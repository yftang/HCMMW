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
  pending "add some examples to (or delete) #{__FILE__}"
end
