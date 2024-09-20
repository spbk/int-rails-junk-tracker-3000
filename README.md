# Approach

I focused on the backend API and making flexible data models in anticipation of changing requirements.

I ended up ripping out most of the controller code pertaining to views and javascript and making this a simple json API as I was burning up a lot of time trying to make the existing templates work with how I modeled the data.

All tests are in the spec directory and I tried to cover everything fairly well, but I didn't test every edge case or validation for the sake of time.  The major code paths are exercised.  There are some simple validations and logic around things like status names and the number of doors, but I only got into that so far as time would allow.

There is seed data - running `rails db:seed` will give you one of each vehicle and their associations.  Running `curl http://localhost:3000/vehicles | jq` will display a json list of vehicles, their parts, their ads, etc.

The params for the API can be found in the tests.  I'd like to write some param validation if time would allow as well as document what is available.

Some simple commands to create/update/delete

- create
```
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"nickname":"R8", "mileage":"234324", "engine_status":"works", "vehicle_type":"coupe", "num_regular_doors": "2"}' \
    http://localhost:3000/vehicles
```

This will respond with: (The ids will obviously be different)
```
{
  "id": 16,
  "nickname": "R8",
  "registration_id": "cRoEWX7Gz3PE3v2DcF01fosfhAsskA",
  "mileage": 234324,
  "created_at": "2024-09-20T21:06:31.863Z",
  "updated_at": "2024-09-20T21:06:31.863Z",
  "engine": {
    "id": 8,
    "vehicle_id": 16,
    "status": "works",
    "created_at": "2024-09-20T21:06:31.894Z",
    "updated_at": "2024-09-20T21:06:31.894Z"
  },
  "doors": [
    {
      "id": 19,
      "vehicle_id": 16,
      "sliding": false,
      "created_at": "2024-09-20T21:06:31.907Z",
      "updated_at": "2024-09-20T21:06:31.907Z"
    },
    {
      "id": 20,
      "vehicle_id": 16,
      "sliding": false,
      "created_at": "2024-09-20T21:06:31.920Z",
      "updated_at": "2024-09-20T21:06:31.920Z"
    }
  ],
  "advertisements": [
    {
      "id": 8,
      "created_at": "2024-09-20T21:06:31.943Z",
      "updated_at": "2024-09-20T21:06:31.943Z",
      "vehicle_id": 16,
      "display": "R8\nRegistration number: cRoEWX7Gz3PE3v2DcF01fosfhAsskA\nMileage: High (234,324)\nEngine: Works\n"
    }
  ]
}
```

- update (updating the mileage and the nickname, the ad also gets updated)
```
curl --header "Content-Type: application/json" \
    --request PUT \
    --data '{"nickname":"R8 Avant", "mileage":"10"}' \
    http://localhost:3000/vehicles/16
```

- delete
```
curl -X DELETE http://localhost:3000/vehicles/16
```

- list all vehicles
```
curl http://localhost:3000/vehicles | jq
```





# Junk Tracker 3000

You have been hired to build an inventory management system for your local junkyard! While they accept may different items, old vehicles are their most popular, so in addition to just tracking what's in stock, they also want to run up-to-date ads for everything they have.

## Tasks

1. Allow for four different vehicle types (listed below) to be created, updated and destroyed with the attributes described below.
    - The starter code has a some UI components laid out, but you'll need to make them functional.
2. After each vehicle is created, register it using the [`VehicleRegistrationService`](app/services/vehicle_registration_service.rb) and permanently associate that registration ID with the vehicle.
3. Whenever a vehicle is created or updated, create or update a text advertisement for the vehicle using the [`VehiclePromotionService`](app/services/vehicle_promotion_service.rb) to promote the vehicle to the public.
    - When an advertiserment is first created an ID is returned to reference the created advertisemend. That ID should be used when updating an advertiserment for a partiuclar verhicle whenever its details are updated.
    - Use [`AdBuilder`](app/services/ad_builder.rb) to generate text advertiserments for vehicles. [`ad_builder_spec.rb`](spec/ad_builder_spec.rb) contains failing tests that describe what those text ads should look like. Implement `AdBuilder.create_ad` so that all of the existing tests pass
        - We use [RSpec](https://rspec.info/), but if you're more comfortable with other testing frameworks or tools feel free to use those instead.
4. List all vehicles on `http://localhost:3000/vehicles` with their 
    - type
    - nickname
    - registration ID

### Vehicle Types

- Sedan
    - Nickname: string
    - Mileage: integer
    - Doors: 0-4, default: 4
    - Engine status: works, fixable, junk, default: works
- Coupe
    - Nickname: string
    - Mileage: integer
    - Doors: 0-2, default: 2
    - Engine status: works, fixable, junk, default: works
- Mini-Van
    - Nickname: string
    - Mileage: integer
    - Doors: 0-4, default: 4
      - For each door: 
        - Sliding: boolean, default: false 
    - Engine status: works, fixable, junk, default: works
- Motorcycle
    - Nickname: string
    - Mileage: integer
    - Engine status: works, fixable, junk, default: works
    - Seat status: works, fixable, junk, default: works

