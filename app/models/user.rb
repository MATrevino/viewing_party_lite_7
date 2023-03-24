class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email

   def hosted_parties(user_id)
    Party.where(':host_id = ?', user_id)
  end
  
  # def invited_parties
  #   require 'pry'; binding.pry
  #   Party.all.users.where("")
      
  # end
end