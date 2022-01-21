# gallery-backend
Nhost setup for Gallery's backend.

## Development

Some requirements:
- Install nhost CLI with:
```
sudo curl -L https://raw.githubusercontent.com/nhost/cli/main/get.sh | bash
```
- Docker: https://docs.docker.com/get-docker
- Other things good to have: Node, Git, Hasura CLI

Clone and start the services
```
git clone git@github.com:sangdth/gallery-backend.git
cd gallery-backend
nhost
```

Yes, it's correct, just go to that folder and type `nhost`! If you see something like this:
```
✔ Your app is running at http://localhost:1337 (Ctrl+C to stop)
ℹ Emails will be sent to http://localhost:8814
```
:tada: Congratulation! :tada:

Extra: Get the frontend from here: https://github.com/sangdth/gallery-frontend

## Deployment

Read more on nhost's documentation: https://docs.nhost.io/get-started
