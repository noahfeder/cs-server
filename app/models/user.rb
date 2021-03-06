# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  username        :string
#  active          :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_many :binaries
  has_secure_password
  validates :username, uniqueness: true, length: {minimum: 4, maximum: 20}
  validates :password, length: {minimum: 8}
end
