class Engine < ApplicationRecord
  belongs_to :vehicle
  validates :status, inclusion: ["works","fixable","junk"]
end