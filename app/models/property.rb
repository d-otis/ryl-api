class Property < ApplicationRecord
  validates_presence_of :address
  after_initialize :set_default_rating

  def set_default_rating
    self.rating = 0
  end
end
