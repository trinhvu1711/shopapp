
# ShopApp

## Overview

ShopApp is a Spring Boot application designed to manage an online shop. It leverages several modern technologies to provide a robust and scalable solution for e-commerce needs.

## Technologies Used

### Spring Boot

-   **Version**: 3.1.10
-   **Dependencies**:
    -   `spring-boot-starter-data-jpa`: Simplifies database access with JPA.
    -   `spring-boot-starter-validation`: Provides validation framework.
    -   `spring-boot-starter-web`: Builds web, including RESTful, applications using Spring MVC.
    -   `spring-boot-starter-security`: Adds security features to the application.
    -   `spring-boot-starter-test`: Supports testing Spring Boot applications.

### Java

-   **Version**: 17

### Database

-   **MySQL Connector/J**: JDBC driver for MySQL databases.

### Utility Libraries

-   **Lombok**: Reduces boilerplate code by generating getters, setters, and other common methods.
-   **ModelMapper**: Simplifies object mapping.
-   **JavaFaker**: Generates fake data for testing.

### Security

-   **JJWT (Java JWT)**: Library for creating and verifying JSON Web Tokens.

### Other

-   **javax.activation-api**: Java Activation Framework for handling data types.

## Build and Dependency Management

-   **Maven**: Project is managed and built using Apache Maven.
    -   **spring-boot-maven-plugin**: Used to package the application as an executable JAR and build Docker images using buildpacks.

## Getting Started

### Prerequisites

-   Java 17 or later
-   Maven 3.6.0 or later
-   MySQL database# ShopApp