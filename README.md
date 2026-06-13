# ABC News - Java Web Application

This is a Java-based web application for managing and reading news, developed as part of the Java 3 Assignment.

## Features

- **Reader Interface:**
  - View latest news and articles.
  - Subscribe to newsletters.
  - Browse news by categories.

- **Admin Interface:**
  - Manage users (add, edit, delete).
  - Manage categories and news articles.
  - Manage newsletter subscriptions.

## Tech Stack

- **Backend:** Java Servlets, JSP (JavaServer Pages)
- **Database:** SQL Server (JDBC)
- **Build Tool:** Maven

## Project Structure

- `src/main/java`: Contains all Java source code (Controllers, DAOs, Models, Utils).
- `src/main/webapp`: Contains all frontend files (JSP views, CSS, images).
- `Database`: Contains the SQL script (`database.sql`) to set up the database.

## Setup Instructions

1. Clone the repository to your local machine.
2. Execute the `Database/database.sql` script in your SQL Server to create the database and tables.
3. Update the database connection settings in `src/main/java/com/abcnews/util/XJdbc.java` if necessary.
4. Import the project into Eclipse/IntelliJ as a Maven project.
5. Deploy the project on a Tomcat server (v9.0+ recommended) and run.
