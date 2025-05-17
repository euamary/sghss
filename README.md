# Hospital and Health Services Management System (SGHSS)

The SGHSS API is a comprehensive backend system designed for VidaPlus, an institution that administers hospitals, neighborhood clinics, laboratories, and home care teams. This system centralizes all healthcare management operations into a single, secure platform.

## Overview

SGHSS provides solutions for the following core areas:

1. **Patient Registration and Care**
   - Patient records management
   - Appointment scheduling
   - Medical examination tracking
   - Electronic health records (EHR)
   - Telemedicine support

2. **Healthcare Professional Management**
   - Staff records and credentials
   - Scheduling and availability
   - Prescription management
   - Performance tracking

3. **Hospital Administration**
   - Bed management
   - Financial reporting
   - Inventory and supply chain
   - Resource allocation

4. **Telemedicine**
   - Virtual appointment platform
   - Online prescription services
   - Appointment scheduling
   - Exam requisitions

5. **Security and Compliance**
   - Role-based access control
   - LGPD compliance
   - Comprehensive audit logs
   - Data encryption and protection

## Technology Stack

- Ruby 3.2.4
- Rails 8.0.2 (API mode)
- PostgreSQL 16
- Docker for containerization
- RSpec for testing
- FactoryBot for test data generation
- Shoulda Matchers for test assertions
- Simplecov for test coverage
- Rubocop for code linting and style enforcement

## Development Environment Setup

### Prerequisites

- Docker and Docker Compose
- Git

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/gitDbits/sghhs_api
   cd sghss_api
   ```

2. Build the Docker containers:
   ```
   docker-compose build
   ```

3. Setup the database:
   ```
   docker-compose run --rm web rails db:create db:migrate
   ```

4. Start the application:
   ```
   docker-compose up
   ```

The API will be available at http://localhost:3000

## Testing

Run the test suite with:

```
docker-compose run --rm web rspec
```

Check code coverage with SimpleCov reports generated after running tests.

## Code Quality

Enforce code style with Rubocop:

```
docker-compose run --rm web rubocop
```

## API Documentation

API documentation is available at `/api/docs` when the server is running.


## Contact

For more information, please contact the development team.
