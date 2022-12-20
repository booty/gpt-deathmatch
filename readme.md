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
		user_id:
		prompt:
		response:
		score:
	}	
]
```

POST /text

```json
	{
		session_token:
		prompt:
       }

	{
		success:
	}
```

```json
POST /vote
	{
		session_token:
		submission_id_winner:
		submission_id_loser:
	}
```

```
	{
		success:
	}
```

```json
GET /deathmatch
	{
		[
			submission_id:
			prompt:
			response:
		]

	}
```

```json
POST /session
	{
		email:
	}

	{
		success:  (bool)
		session_token: 
	}
```

```json
DELETE /session
	{
		session_token:
	}
```

