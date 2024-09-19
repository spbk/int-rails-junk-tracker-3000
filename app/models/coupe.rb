class Coupe < Vehicle
  has_one :engine
  has_many :doors
end