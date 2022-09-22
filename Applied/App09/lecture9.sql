--min avg max
select max(drone_flight_time) as "Max drone flight time",
avg(drone_flight_time) as "Average drone flight time",
min(drone_flight_time) as "Min drone flight time"
from drone.drone;


