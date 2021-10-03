# Parking Challenge

## Dev Environment

  - [Installation](INSTALL.md)

## Entities

### Vehicle

Field        | Type           | Required | Unique
-------------|----------------|----------|--------
plate        | string         | ✔        | ✔
vehicle_type | integer (enum) |          |
make         | string         |          |
model        | string         |          |
color        | string         |          |

### ParkingReservation

Field         | Type     | Required
--------------|----------|----------
vehicle_id    | fk       | ✔
check_in_at   | datetime | ✔
check_out_at  | datetime |
paid_at       | datetime |

## Quick Access

  - **Models**
    + [Vehicle](app/models/vehicle.rb)
    + [ParkingReservation](app/models/parking_reservation.rb)
  - **Migrations**
    + [CreateVehicles](db/migrate/20211002163730_create_vehicles.rb)
    + [CreateParkingReservations](db/migrate/20211002181104_create_parking_reservations.rb)
  - **Controllers**
    + [ParkingController](app/controllers/parking_controller.rb)
  - **Views**
    + [parking/_parking_reservation.json.jbuilder](app/views/parking/_parking_reservation.json.jbuilder)
    + [parking/check_in.json.jbuilder](app/views/parking/check_in.json.jbuilder)
    + [parking/show.json.jbuilder](app/views/parking/show.json.jbuilder)
    + [parking/vehicle_history.json.jbuilder](app/views/parking/vehicle_history.json.jbuilder)
  - **Lib Folder**
    + [numeric_helpers.rb](lib/numeric_helpers.rb)
  - **Initializers**
    + [load_app_helpers.rb](config/initializers/load_app_helpers.rb)
  - **Tests**
    + Factories
      * [parking_reservations.rb](spec/factories/parking_reservations.rb)
      * [vehicles.rb](spec/factories/vehicles.rb)
    + Models
      * [parking_reservation_spec.rb](spec/models/parking_reservation_spec.rb)
      * [spec/models/vehicle_spec.rb](spec/models/vehicle_spec.rb)
    + Requests
      * [parking_spec.rb](spec/requests/parking_spec.rb)
    + Routing
      * [parking_spec.rb](spec/routing/parking_spec.rb)
  - **Docker**
    + [Dockerfile](Dockerfile)
    + [docker-compose.yml](docker-compose.yml)
  - **CircleCI**
    + [.circleci/config.yml](.circleci/config.yml)
