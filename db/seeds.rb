
minivan = Minivan.create!(nickname: "sprinter")
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

VehiclePromotionService.create_ad(minivan)
VehiclePromotionService.create_ad(coupe)
VehiclePromotionService.create_ad(sedan)
VehiclePromotionService.create_ad(motorcycle)