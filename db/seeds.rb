# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

motorcycle_type = VehicleType.create!(name: "motorcycle")
sedan_type = VehicleType.create!(name: "sedan")
coupe_type = VehicleType.create!(name: "coupe")
minivan_type = VehicleType.create!(name: "mini-van")


minivan = MiniVan.create!(nickname: "sprinter")
4.times { Door.create!(vehicle: minivan)}
Engine.create!(vehicle: minivan)

coupe = Coupe.create!(nickname: "996 turbo")
2.times { Door.create!(vehicle: coupe) }
Engine.create!(vehicle: coupe)

sedan = Sedan.create!(nickname: "RS6")
4.times { Door.create!(vehicle: sedan) }
Engine.create(vehicle: sedan)

motorcycle = Motorcycle.create!(nickname: "Monster 1100")
Seat.create!(vehicle: motorcycle)
Engine.create!(vehicle: motorcycle)
