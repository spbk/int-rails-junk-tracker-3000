# Note: Feel free to leave this class as-is unless modifications are required
# for the rest of your solution, in which case change whatever you'd like.

class VehiclePromotionService
  def self.create_ad(vehicle)
    Advertisement.create!(vehicle: vehicle, display: AdBuilder.create_ad(vehicle)).id
  end

  def self.update_ad(ad_id, vehicle)
    Advertisement.find(ad_id).update!(display: AdBuilder.create_ad(vehicle))
    ad_id
  end
end