1. **Represent the “book_date” column in “yyyy-mmm-dd” format using Bookings table**
   
   **Expected output:** book_ref, book_date (in “yyyy-mmm-dd” format), total amount 

    ```sql
    select 
        book_ref,
        to_char(book_date,'YYYY-MMM-DD') as book_date,
        total_amount
    from bookings;
    ```

2. **Get the following columns in the exact same sequence.**
   
   **Expected columns in the output:** ticket_no, boarding_no, seat_number, passenger_id, passenger_name.

    ```sql
    select 
      BP.ticket_no,
      BP.boarding_no,
      BP.seat_no,
      T.passenger_id,
      T.passenger_name
    from boarding_passes as BP 
    join tickets as T 
    on BP.ticket_no=T.ticket_no;
    ```

3. **Write a query to find the seat number which is least allocated among all the seats?**

   **Expected output:** seat_no, allocation_count

    ```sql
    select 
    s.seat_no,
    count(bp.seat_no) as allocation_count
    from seats s 
    left join boarding_passes bp 
    on s.seat_no=bp.seat_no
    group by 1 
    order by 2 asc 
    limit 3;
    ```

4. **In the database, identify the month-wise highest paying passenger name and passenger id.**

   **Expected output:** Month_name (in “mmm-yy” format), passenger_id, passenger_name, total amount

    ```sql
    with monthly_payment as (
        select 
        to_char(b.book_date,'MMM-YY') as month_name,
        t.passenger_id,
        t.passenger_name,
        b.total_amount,
        dense_rank() over(partition by to_char(b.book_date,'MMM-YY') order by b.total_amount desc) as rank
        from bookings as b 
        join tickets as t 
        on b.book_ref=t.book_ref 
    )
    select 
    month_name,
    passenger_id,
    passenger_name,
    total_amount
    from monthly_payment
    where rank=1;
    ```

5. **In the database, identify the month-wise least paying passenger name and passenger id?**

   **Expected output:** Month_name (in “mmm-yy” format), passenger_id, passenger_name, total amount

    ```sql
    with monthly_payment as (
        select 
        to_char(b.book_date,'MMM-YY') as month_name,
        t.passenger_id,
        t.passenger_name,
        b.total_amount,
        dense_rank() over(partition by to_char(b.book_date,'MMM-YY') order by b.total_amount Asc) as rank
        from bookings as b 
        join tickets as t 
        on b.book_ref=t.book_ref 
    )
    select 
    month_name,
    passenger_id,
    passenger_name,
    total_amount
    from monthly_payment
    where rank=1;
    ```

6. **Identify the travel details of non-stop journeys or return journeys (having more than 1 flight).**

   **Expected output:** Passenger_id, passenger_name, ticket_number, flight count.

    ```sql
    select 
    t.passenger_id,
    t.passenger_name,
    t.ticket_no as ticket_number,
    count(f.flight_id) as Flight_count
    from tickets t 
    join ticket_flights tf 
    on t.ticket_no=tf.ticket_no
    join flights f 
    on f.flight_id=tf.flight_id
    group by 1,2,3
    having count(f.flight_id)>1;
    ```

7. **How many tickets are there without boarding passes?**

   **Expected output:** A single number representing the count of tickets without boarding passes.

    ```sql
    select 
    count(t.ticket_no) as tickets_without_boarding_passes
    from tickets as t 
    left join boarding_passes as b 
    on t.ticket_no=b.ticket_no
    where b.ticket_no is null;
    ```

8. **Identify details of the longest flight (using flights table).**

   **Expected output:** Flight number, departure airport, arrival airport, aircraft code, and durations.

    ```sql
    select 
        distinct flight_no,
        departure_airport,
        arrival_airport,
        aircraft_code,
        scheduled_arrival-scheduled_departure as duration
    from flights
    where (scheduled_arrival-scheduled_departure) =
    ( select MAX(scheduled_arrival-scheduled_departure)
        from flights)
    order by 1;
    ```

9. **Identify details of all the morning flights (morning means between 6 AM to 11 AM, using flights table).**

   **Expected output:** flight_id, flight_number, scheduled_departure, scheduled_arrival, and timings.

    ```sql
    select 
        flight_id,
        flight_no as flight_number,
        scheduled_departure,
        scheduled_arrival,
        cast(scheduled_departure as time) as timings 
    from flights 
    where cast(scheduled_departure as time) between '06:00:00' and '11:00:00';
    ```

10. **Identify the earliest morning flight available from every airport.**

    **Expected output:** flight_id, flight_number, scheduled_departure, scheduled_arrival, departure airport, and timings.

    ```sql
    WITH RankedFlights AS (
        SELECT Flight_ID,
               flight_no,
               Scheduled_Departure,
               Scheduled_Arrival,
               Departure_Airport,
               dense_rank() OVER (PARTITION BY Departure_Airport ORDER BY Scheduled_Departure) AS Flight_Rank
        FROM Flights
        WHERE extract(hour from scheduled_departure) > 2 and extract(hour from scheduled_departure) < 6)
    SELECT Flight_ID,
           Flight_No,
           Scheduled_Departure,
           Scheduled_Arrival,
           Departure_Airport,
           cast(scheduled_departure as time) as timings 
    FROM RankedFlights
    WHERE Flight_Rank=1;
    ```

11. **Find the list of airport codes in the Europe/Moscow timezone.**

    **Expected output:** Airport_code.

    ```sql
    select 
        airport_code
    from airports
    where timezone='Europe/Moscow';
    ```

12. **Write a query to get the count of seats in various fare conditions for every aircraft code.**

    **Expected output:** Aircraft_code, fare_conditions, seat count.

    ```sql
    select 
        aircraft_code,
        fare_conditions,
        count(seat_no) as seat_count
    from seats
    group by 1,2;
    ```

13. **How many aircraft codes have at least one Business class seat?**

    **Expected output:** Count of aircraft codes.

    ```sql
    select 
       count(distinct aircraft_code) as count_of_aircraft_codes
    from seats
    where fare_conditions='Business';
    ```

14. **Find out the name of the airport having the maximum number of departure flights.**

    **Expected output:** Airport_name.

    ```sql
    select 
    a.airport_name
    from flights f 
    join airports a 
    on f.departure_airport=a.airport_code
    group by 1
    order by count(*) desc
    limit 1;
    ```

15. **Find out the name of the airport having the least number of scheduled departure flights.**

    **Expected output:** Airport_name.

    ```sql
    select 
    a.airport_name
    from flights f 
    join airports a 
    on f.departure_airport=a.airport_code
    group by 1
    order by count(*) asc
    limit 1;
    ```

16. **How many flights from ‘DME’ airport don’t have actual departure?**

    **Expected output:** Flight Count.

    ```sql
    select 
       count(flight_id) as flight_count 
    from flights
    where actual_departure is null 
    AND departure_airport='DME';
    ```

17. **Identify flight IDs having a range between 3000 to 6000.**

    **Expected output:** Flight_Number, aircraft_code, ranges.

    ```sql
    select 
     distinct f.flight_no as flight_number,
     a.aircraft_code,
     a.range 
    from flights as f 
    join aircrafts as a 
    on f.aircraft_code=a.aircraft_code
    where a.range between 3000 and 6000;
    ```

18. **Write a query to get the count of flights flying between URS and KUF.**

    **Expected output:** Flight_count.

    ```sql
    SELECT 
        COUNT(*) AS flight_count
    FROM 
        flights
    WHERE 
        departure_airport IN ('URS', 'KUF') 
        AND arrival_airport IN ('URS', 'KUF') 
        AND departure_airport != arrival_airport;
    ```

19. **Write a query to get the count of flights flying from either NOZ or KRR.**

    **Expected output:** Flight count.

    ```sql
    select 
       count(*) as flight_count
    from flights
    where departure_airport in ('NOZ', 'KRR');
    ```

20. **Write a query to get the count of flights flying from KZN, DME, NBC, NJC, GDX, SGC, VKO, ROV.**

    **Expected output:** Departure airport, count of flights flying from these airports.

    ```sql
    select 
        departure_airport,
       count(*) as flight_count
    from
