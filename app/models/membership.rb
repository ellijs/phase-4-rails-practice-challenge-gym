class Membership < ApplicationRecord
  belongs_to :gym
  belongs_to :client

  validates_presence_of :gym_id, :client_id, :charge
  validates :client_id, presence: true, uniqueness: { scope: :gym_id }
end
