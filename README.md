# Lunch and Learn

## Learning Goals
This project is designed to demonstrate the following learning goals:
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Implement Basic Authentication
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).


## Getting Started

### Clone and Setup
Clone the repository and navigate to it.
```bash
cd lunch_and_learn
```

```bash
bundle install
```
Set up the database:
```bash
rails db:{drop,create,migrate,seed}
```
Start the server:
```bash
rails server
```
Your application should now be running at http://localhost:3000.

Obtaining API Keys
To obtain API keys for external services used in this application:

### Recipe API (Edamam):

Visit the Edamam Recipe API website.
Sign up for an account.
Obtain your API key from the dashboard.

### REST Countries API:

Visit the REST Countries API website.
Sign up for an account (if required).
Obtain your API key from the documentation.

### Youtube API: 

Visit the Youtube API website.
Sign up for an account.
Obtain your API key from the dashboard.

### Postman Requests Examples
```bash
GET /api/v1/recipes?country=thailand
GET /api/v1/learning_resources?country=czech republic 
POST /api/v1/users
POST /api/v1/sessions
POST /api/v1/favorites
GET /api/v1/users
```
