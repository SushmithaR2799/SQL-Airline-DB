# SQL Capstone Project

## Project Overview

This SQL Capstone Project was undertaken to enhance and showcase proficiency in SQL by working with a simulated airline database. The project involves writing and executing complex SQL queries to extract meaningful insights from the data. The queries were designed to cover a wide range of SQL functionalities, including data transformation, joining multiple tables, window functions, and subqueries.

## Key Features

- **Date Formatting**: Converted `book_date` to a specific format (`yyyy-mmm-dd`) to ensure consistent date representations across the dataset.
  
- **Data Extraction and Transformation**: 
  - Retrieved passenger details including ticket number, boarding number, and seat number.
  - Identified the least allocated seat numbers.
  - Determined the month-wise highest and lowest paying passengers.

- **Complex Joins and Aggregations**: 
  - Analyzed non-stop and return journeys by counting the number of flights per ticket.
  - Counted tickets without boarding passes.
  - Identified the longest flight based on duration.

- **Flight Schedules**:
  - Filtered flights scheduled in the morning (6 AM to 11 AM).
  - Extracted the earliest morning flight available from each airport.

- **Geographical Insights**:
  - Retrieved a list of airport codes in the Europe/Moscow timezone.
  - Identified the airport with the maximum and minimum number of departure flights.

- **Flight and Aircraft Analysis**:
  - Analyzed flight counts between specific airports.
  - Identified flights using aircrafts from specific companies (e.g., Airbus, Boeing) that were canceled or delayed.
  - Listed aircraft codes with at least one business class seat.

- **Cancellations and Refunds**:
  - Calculated refunds for customers due to flight cancellations.
  - Extracted a list of Airbus flights that were canceled.

## Learning Outcomes

- **Proficiency in SQL**: Gained a deep understanding of SQL syntax and functions by working with real-world-like data.
- **Problem-Solving Skills**: Developed the ability to write optimized and efficient SQL queries for complex data retrieval tasks.
- **Data Analysis**: Improved data analysis skills by generating insights from large datasets and drawing meaningful conclusions.

## Technologies Used

- **SQL**: Primary language used for writing queries.
- **PostgreSQL**: Database system used to store and manage the airline data.

## Future Enhancements

- **Optimization**: Further optimization of queries for performance improvements.
- **Visualization**: Integrate SQL with data visualization tools to graphically represent insights.

## Conclusion

This project provided hands-on experience with SQL and enabled the extraction of complex data insights from an airline database. The skills gained through this project will be applicable to real-world data analysis tasks in various domains.

## Repository Structure

- `queries.sql`: Contains all the SQL queries executed during the project.
- `README.md`: Project overview and documentation (this file).
- `data/`: Sample data used for testing the queries (if applicable).
