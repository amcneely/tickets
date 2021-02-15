# TICKETS

A Rails app providing an API endpoint (/tickets) to post a JSON payload with a ticket's user_id and title and optional tags: 

```json
{
  "user_id" : 1234,
  "title" : "My title",
  "tags" : ["tag1", "tag2"]
}
```

Install:

`bundle install`

`rails db:migrate`

Test:

`rails test`

Server:

`rails s`

Sample curl:

`curl -i -d '{"user_id" : 1234,"title" : "My title A","tags" : ["tag1", "tag2"]}' -X POST -H 'Content-Type: application/json' http://localhost:3000/tickets`
