class Sedan < Vehicle
  has_many :doors
  has_one :engine
end