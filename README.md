# ticket-booth
Movie tickets app

# Steps to setup the app
```bash
> bundle install
> bundle exec rake db:migrate
> rackup
```

# Steps to run the specs
```bash
> bundle exec rake db:migrate\[test\]
> bundle exec rspec
```

# API DOCS
Import `ticket_booth_api.postman_collection.json` using postman app in order to interact with the API

## Create Movie example request
POST: http://localhost:9292/api/movies.json
BODY:
```json
{
	"movie": {
		"title": "The Arrival",
		"image_url": "test",
		"description": "wow!!",
		"tuesday": true,
		"thursday": true,
		"saturday": true
	}
}
```

*response*

```json
{
    "id": 2,
    "title": "the arrival",
    "description": "wow!!",
    "image_url": "test",
    "monday": false,
    "tuesday": true,
    "wednesday": false,
    "thursday": true,
    "friday": false,
    "saturday": true,
    "sunday": false
}
```

## Create Reservation example request
POST: http://localhost:9292/api/reservations.json
BODY:
```json
{
	"reservation": {
		"movie_id": 1,
		"date": "2020-04-06",
		"customer_name": "Carlos Contreras",
		"customer_phone": "555 555 5555"
	}
}
```

*response*

```json
{
    "id": 2,
    "movie_id": 1,
    "date": "2020-04-06",
    "customer_name": "Carlos Contreras",
    "customer_phone": "555 555 5555"
}
```

## List Reservations example request
GET: http://localhost:9292/api/movies.json?day=saturday

*response*

```json
[
    {
        "id": 2,
        "title": "the arrival",
        "description": "wow!!",
        "image_url": "test",
        "monday": false,
        "tuesday": true,
        "wednesday": false,
        "thursday": true,
        "friday": false,
        "saturday": true,
        "sunday": false
    }
]
```

## List Movies example request
GET: http://localhost:9292/api/reservations?start_date=2020-04-01&end_date=2020-04-20

*response*

```json
[
    {
        "id": 1,
        "movie_id": 1,
        "date": "2020-04-05",
        "customer_name": "Carlos Contreras",
        "customer_phone": "555 555 5555"
    },
    {
        "id": 2,
        "movie_id": 1,
        "date": "2020-04-06",
        "customer_name": "Carlos Contreras",
        "customer_phone": "555 555 5555"
    }
]