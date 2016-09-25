# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  binary_id  :integer
#  value      :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ApplicationRecord
  belongs_to :binary
end
