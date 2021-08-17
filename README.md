# Rockelivery

[![codecov](https://codecov.io/gh/mrinardo/rockelivery/branch/main/graph/badge.svg?token=18IECSGHNO)](https://codecov.io/gh/mrinardo/rockelivery)

This sample Phoenix REST API application is food delivery API. Authentication is made with JWT tokens and the data is stored in a Postgres database.

This is [final challenge](https://www.notion.so/Desafio-Final-75f559ba068348fcb582f45e3e4e5455) of Rocketseat's Ignite Elixir.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from an API client like Postman or Insomnia.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Tests

You can also run the tests script in the terminal (outside `iex`):

```shell
$ mix test
$ mix test --cover
```

# Endpoints

## Create new user

```POST /users```

### Request
```json
{
	"address": "Rua Teste, 15",
	"age": 18,
	"cep": "01301100",
	"email": "mauricio@teste.com",
	"name": "Mauricio Rinardo",
	"cpf": "12345678911",
	"password": "123456"
}
```
### Response
```
Status: 200 OK
```
```json
{
  "message": "User created!",
  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJyb2NrZWxpdmVyeSIsImV4cCI6MTYzMTYxNzU4NCwiaWF0IjoxNjI5MTk4Mzg0LCJpc3MiOiJyb2NrZWxpdmVyeSIsImp0aSI6IjFmODNhZTVhLTUxNDgtNDUzNy05NzYyLTRhZDAyZDIxMWQzMyIsIm5iZiI6MTYyOTE5ODM4Mywic3ViIjoiOWEwZGY3NGItY2YxYS00YzkzLTllYjUtM2QwMjU3ZTNlYWIwIiwidHlwIjoiYWNjZXNzIn0.35ZzMfTVa2PSa9xhqZg2e9bvR5teRH8kvrrgaQhE6vGnAzhOv_Uk9tx12EQXOuf7iD36AY6fQJ3067dX8BIHZw",
  "user": {
    "id": "9a0df74b-cf1a-4c93-9eb5-3d0257e3eab0",
    "age": 18,
    "cep": "01301100",
    "cpf": "12345678911",
    "address": "Rua Teste, 15",
    "email": "mauricio@teste.com",
    "name": "Mauricio Rinardo"
  }
}
```
The authentication token is returned upon user creation. Call /users/signin to login with another user.

## Get an user

```GET /users/{id}```

### Request

Requires Bearer Token authentication.

### Response

```
Status: 200 OK
```
```json
{
  "user": {
    "id": "9a0df74b-cf1a-4c93-9eb5-3d0257e3eab0",
    "age": 18,
    "cep": "01301100",
    "cpf": "12345678911",
    "address": "Rua Teste, 15",
    "email": "mauricio@teste.com",
    "name": "Mauricio Rinardo"
  }
}
```

## Delete an user

```DELETE /users/{id}```

### Request

Requires Bearer Token authentication.

### Response

```
Status: 204 No Content
```

## Update an user

```PUT /users/{id}```

### Request

Requires Bearer Token authentication.
```json
{
	"email":  "mauricio123@teste.com"
}
```
### Response

```
Status: 200 OK
```
```json
{
  "user": {
    "id": "9a0df74b-cf1a-4c93-9eb5-3d0257e3eab0",
    "age": 18,
    "cep": "01301100",
    "cpf": "12345678911",
    "address": "Rua Teste, 15",
    "email": "mauricio123@teste.com",
    "name": "Mauricio Rinardo"
  }
}
```

## Signin

```POST /users/signin```

### Request

```json
{
	"id": "9a0df74b-cf1a-4c93-9eb5-3d0257e3eab0",
	"password": "123456"
}
```

### Response

```
Status: 200 OK
```
```json
{
  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJyb2NrZWxpdmVyeSIsImV4cCI6MTYzMTYxODM3MywiaWF0IjoxNjI5MTk5MTczLCJpc3MiOiJyb2NrZWxpdmVyeSIsImp0aSI6ImQ2ZTJjOWJhLWZkZTMtNDc5NC1hYzAzLTk0MTkxMDQ4ZTAxZCIsIm5iZiI6MTYyOTE5OTE3Miwic3ViIjoiOWEwZGY3NGItY2YxYS00YzkzLTllYjUtM2QwMjU3ZTNlYWIwIiwidHlwIjoiYWNjZXNzIn0.-Oty_rfXdknX99XhtkTan0Hp5yduhAVGxpKijN5hMTMiEPSFwFljna0NgqIBFrtLwChnjlRoxwjfrXYqv1HO7w"
}
```

## Create food item

```POST /items```

### Request

Requires Bearer Token authentication.

```json
{
	"category": "food",
	"description": "strogonoff de frango",
	"price": "18.00",
	"photo": "/priv/photos/strogonoff_frango.jpg"
}
```

### Response

```
Status: 200 OK
```
```json
{
  "item": {
    "category": "food",
    "description": "strogonoff de frango",
    "price": "18.00",
    "photo": "/priv/photos/strogonoff_frango.jpg",
    "id": "c4a3ad7d-c2bb-484e-b54a-989ce48b2e3c"
  },
  "message": "Item created!"
}
```

## Create an order

```POST /orders```

### Request

Requires Bearer Token authentication.

```json
{
  "address": "Rua Teste, 15",
  "comments": "suco sem açúcar",
  "items": [
		{"id": "334bab72-fa2d-49a7-ac0d-63f5eed9766d", "quantity": 2},
    {"id": "c4a3ad7d-c2bb-484e-b54a-989ce48b2e3c", "quantity": 1}
  ],
  "payment_method": "money",
  "user_id": "9a0df74b-cf1a-4c93-9eb5-3d0257e3eab0"
}
```

### Response

```
Status: 200 OK
```
```json
{
  "message": "Order created!",
  "order": {
    "address": "Rua Teste, 15",
    "comments": "suco sem açúcar",
    "payment_method": "money",
    "user_id": "9a0df74b-cf1a-4c93-9eb5-3d0257e3eab0",
    "id": "fa7e725c-04e9-459c-9dfa-2b97e8e9ac2c",
    "items": [
      {
        "category": "drink",
        "description": "suco de banana",
        "price": "15.00",
        "photo": "/priv/photos/suco_banana.jpg",
        "id": "334bab72-fa2d-49a7-ac0d-63f5eed9766d"
      },
      {
        "category": "drink",
        "description": "suco de banana",
        "price": "15.00",
        "photo": "/priv/photos/suco_banana.jpg",
        "id": "334bab72-fa2d-49a7-ac0d-63f5eed9766d"
      },
      {
        "category": "food",
        "description": "strogonoff de frango",
        "price": "18.00",
        "photo": "/priv/photos/strogonoff_frango.jpg",
        "id": "c4a3ad7d-c2bb-484e-b54a-989ce48b2e3c"
      }
    ]
  }
}
```

## Learn more about Phoenix

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
