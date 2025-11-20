# Nutrifce Backend

## Overview
Nutrifce is a Spring Boot application that serves as the backend for the Nutrifce project, which includes a Flutter frontend. This application provides RESTful APIs for user management, including registration, login, and user data retrieval.

## Project Structure
```
nutrifce-backend
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── nutrifce
│   │   │           ├── NutrifceApplication.java
│   │   │           ├── controller
│   │   │           │   └── UserController.java
│   │   │           ├── service
│   │   │           │   └── UserService.java
│   │   │           ├── model
│   │   │           │   └── User.java
│   │   │           ├── repository
│   │   │           │   └── UserRepository.java
│   │   │           └── config
│   │   │               └── CorsConfig.java
│   │   └── resources
│   │       └── application.properties
│   └── test
│       └── java
│           └── com
│               └── nutrifce
│                   └── NutrifceApplicationTests.java
├── flutter_app
│   └── lib
│       ├── screens
│       └── services
│           └── api_service.dart
├── pom.xml
└── README.md
```

## Setup Instructions

1. **Clone the Repository**
   Clone the repository to your local machine using:
   ```
   git clone <repository-url>
   ```

2. **Navigate to the Project Directory**
   ```
   cd nutrifce-backend
   ```

3. **Build the Project**
   Use Maven to build the project:
   ```
   mvn clean install
   ```

4. **Run the Application**
   Start the Spring Boot application:
   ```
   mvn spring-boot:run
   ```

5. **Access the API**
   The backend will be available at `http://localhost:8080`. You can use tools like Postman or cURL to interact with the API endpoints.

## API Endpoints
- **POST /users**: Create a new user
- **GET /users/{id}**: Retrieve user details by ID
- **PUT /users/{id}**: Update user information
- **DELETE /users/{id}**: Delete a user

## Flutter Integration
The Flutter application communicates with this backend using the `api_service.dart` file located in the `flutter_app/lib/services` directory. Ensure that the Flutter app is configured to point to the correct backend URL.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.