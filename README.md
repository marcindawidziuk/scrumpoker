# Scrum Pointing Poker Online


Simple Scrum Pointing Poker online, built on top of Phoenix Framework. Available at
https://scrumpoker.uk/

 * Quick joining, just send a link to your teammates
 * Dark more (and light mode if that's your preference) 
 * Usable UI on mobile
 * Multiple decks of cards to choose from: Standard and Time estimate, but you can also set your own!

![screenshot](https://i.imgur.com/vQdBcNC.png)
## Getting started

Project requires Exlixir and NPM installed. To run locally:

  * Go into api folder
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

The backend should now be running on [`localhost:4000`](http://localhost:4000)

  * Go into ui folder
  * Install dependencies with `npm install`
  * Install Node.js dependencies with `npm run dev`

You can acceess UI on [`localhost:3000`](http://localhost:3000)

## Running with Docker
Example script to build and deploy both images (needs to be converted into Docker Compose)
```
ADMIN_PASSWORD="iTQ5Ktuzk9M6RH" SECRET_KEY_BASE=mOXF+3jhvNUidpFCzhj72hEmVTB5dl8gNAqJGb8vtVO4h62ak8T/cHvVOKqUPPUF docker build --build-arg SECRET_KEY_BASE --build-arg ADMIN_PASSWORD -t marcindawidziuk/scrumpoker-staging .

docker stop ScrumPoker-staging
docker rm ScrumPoker-staging
cd api
docker run --env SECRET_KEY_BASE=nOXF+3jhvNUidpFCzhj72hEmVTB5dl8gNAqJGb8vtVO4h62ak8T/cHvVOKqUPPUF --publish 3402:4000 --detach --restart=always --name ScrumPoker-staging marcindawidziuk/scrumpoker-staging:latest

cd ../ui

# Nuxt embedds configuration at build-time

docker build --build-arg WEBSOCKET_URL=ws://staging.scrumpoker.uk/socket -t marcindawidziuk/scrumpoker-ui-staging .

docker stop ScrumPoker-ui-staging
docker rm ScrumPoker-ui-staging
docker run --publish 8081:3000 --detach --restart=always --name ScrumPoker-ui-staging marcindawidziuk/scrumpoker-ui-staging:latest
```

For SSL I recommend running it through Ngnix reverse proxy. 
