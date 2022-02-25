# Scrum Pointing Poker Online
[![Release](https://github.com/marcindawidziuk/scrumpoker/workflows/Release/badge.svg)](https://github.com/marcindawidziuk/scrumpoker/actions?query=workflow%3A%22Elixir+CI%22) [![Uptime](https://stats.uptimerobot.com/assets/img/uptime-logo.png)](https://stats.uptimerobot.com/wnzXlSL0Dr)  


Simple Scrum Pointing Poker online, built on top of Phoenix Framework. Available at
https://scrumpoker.uk/

 * Quick joining, just send a link to your teammates
 * Dark more (and light mode if that's your preference) 
 * Usable UI on mobile
 * Multiple decks of cards to choose from: Standard and Time estimate, but you can also set your own!

![screenshot](https://i.imgur.com/4TA5pby.png)
## Getting started

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running with Docker

For security replace SECRET_KEY_BASE value. The key given below is just an example.
You can generate new key by running: ```mix phx.gen.secret```

```
ADMIN_PASSWORD="mypassword" SECRET_KEY_BASE=PBd3wijcYcO+nHS7uIbtYFY7HWc1R/VTjPpuFzeZDUBH4CGjO/VjONjr2WdI7utG docker build --build-arg SECRET_KEY_BASE -t marcindawidziuk/scrumpoker .

docker stop ScrumPoker
docker rm ScrumPoker
docker run --env SECRET_KEY_BASE=PBd3wijcYcO+nHS7uIbtYFY7HWc1R/VTjPpuFzeZDUBH4CGjO/VjONjr2WdI7utG --publish 3401:4000 --restart=always --name ScrumPoker marcindawidziuk/scrumpoker:latest
```

Now you can visit [`localhost:3401`](http://localhost:3401) from your browser. 

You can also acess Phoenix Live Dashboard with ```admin``` as your username and ```mypassword``` as your password on [`localhost:3401/dashboard`](http://localhost:3401/dashboard).  

For SSL I recommend running it through Ngnix reverse proxy. 
