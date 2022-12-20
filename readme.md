# GPT Deathmatch 


## Home page

1. A box to write your prompt
2. A box where the GPT-3 response appears
3. Two voting candidates
4. Leaderboard
5. Login/CurrentUser/Logout


## Models

* Models
    * Result
        * attribs
            * gpt3_prompt
            * gpt3_result
            * gpt3_model
            * user_id
            * request_raw
            * (remaining credit balance?)
    * User
        * attribs
            * email
            * name
        * methods
            * vote_rate_limit_exceeded?
            * gpt_rate_limit_exceeded?
    * Vote
        * user_id
    * VoteResult
        * vote_id
        * result_id
        * vote (+1 or -1)
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


### JSON

GET /leaderboard

```json
[
  {
    "user_id": 123,
    "prompt": "yakity yak",
    "response": "blah blah blah",
    "score": 42
  }
]
```

POST /text

```json
{
  "session_token": "",
  "prompt": ""
}
```

```json
{
    "success": true
}
```

POST /vote

```json
{
  "session_token": "someguid",
  "submission_id_winner": 123,
  "submission_id_loser": 666
}
```

```json
{
    "success": true
}
```

GET /deathmatch

```json
[
  {
    "submission_id": 123,
    "prompt": "Tell me of your homeworld Usul",
    "response": "Beginnings are a delicate time blah blah blah"
  }
]

```

POST /session

```json
{
    "email": "somebody@somewhere.com"
}
```

```json
{
    "success":  false,
    "session_token": "someguid"
}
```

DELETE /session

```json
{
    "session_token": "someguid"
}
```