# GPT Deathmatch 


## Home page

1. A box to write your prompt
2. A box where the GPT-3 response appears
3. Two voting candidates
4. Leaderboard
5. Login/CurrentUser/Logout


## Models

* Models
    * Submission
        * attribs
            * gpt3_prompt
            * gpt3_result
            * gpt3_model
            * user_id
            * request_raw
            * (remaining credit balance?)
    * User
        * attribs
            * email_address
            * first_name
            * last_name
        * methods
            * vote_rate_limit_exceeded?
            * gpt_rate_limit_exceeded?
    * Deathmatch
        * user_id
    * DeathmatchVote
        * deathmatch_id
        * submission_id
        * vote (+1 or -1)
    * Session
        * user_id
        * token
        * ip_address
* routes
    * GET /
        * home_controller
            * Show current user or login link
            * show 2 voting choices
                * voting disabled if not logged in
                * don't show the user's own results
            * show generation prompt
                * show suggestions
    * POST /vote
        * check vote rate limit
        * record vote
        * redirect to GET /
    * POST /text
        * check generate limit
            * redirect to GET/ if it fails
        * make sure it's not a dupe
            * redirect to GET/ if it fails
        * make API call
        * redirect to GET /
    * GET /session
        * email prompt
    * POST /login
        * check if email exists in User model
        * redirect to GET /
    * DELETE
        * log out 
        * redirect to GET /


## JSON

### GET /leaderboard

<b>Request.</b>
```json5
{
  "limit": 10, // default is 10 if not supplied
  "skip": 0    // for paging, default is 0 if not supplied
}
```

<b>Response.</b> Could be empty array if no votes/submissions yet.

```json5
[
  {
    "score": 42,
    "submission": {
      "user": {
        "first_name": "bob",
        "last_name": "jones",
        "email_address": "sadkjnsadkcjn@asdcas.com",
        "user_id": 4567,
      }
      "gpt_prompt": "yakity yak",
      "gpt_response": "blah blah blah",
    }
  }
]
```

### POST /submission

<b>Request.</b>
```json5
{
  "session_token": "someguid",
  "gpt_prompt": "Write me a love story"
}
```

<b>Response.</b> Vote will be rejected if it's a dupe, they vote on their own submission, aren't logged in, etc.
```json5
{
    "success": true,
    "error_message": ""  // might've hit rate limit, etc
}
```

### POST /vote

<b>Request.</b>
```json5
{
  "session_token": "someguid",
  "deathmatch_id": 42,
  "submission_id_winner": 123,
  "submission_id_loser": 666
}
```

```json5
{
    "success": true,
    "error_message": ""   // might've hit rate limit, etc
}
```

### GET /deathmatch

<b>Request.</b>
```json5
{
  "session_token": "someguid" // can be blank
}
```

<b>Response.</b> Could be an empty array if no submissions yet, or if logged in user has already voted on everything.

```json5
[
  {
    "submission_id": 123,
    "gpt_prompt": "Tell me of your homeworld Usul",
    "gpt_response": "Beginnings are a delicate time blah blah blah"
  },
  {
    "submission_id": 124,
    "gpt_prompt": "How cool is Ruby?",
    "gpt_response": "Super cool"
  }
]

```

### POST /session

<b>Request.</b>
```json5
{
    "email": "somebody@somewhere.com"
}
```

<b>Response.</b>
```json5
{
    "success":  false,          // or true obviously
    "session_token": "someguid" // blank if login fails
}
```

### DELETE /session
<b>Response.</b>
```json5
{
    "session_token": "someguid"
}
```