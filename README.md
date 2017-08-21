# scratch

A work in progress...

### FE:
Currently FE is a single html file served from nginx in a docker container

`docker run --name fe -p 80:80 -v /Users/devlonduthie/Src/scratch/fe/html://usr/share/nginx/html -d fe`

The volume is mounted only for development work - not needed for the 'delivery'

### BE:
BE is a sinatra ruby API that returns a static model in json

`docker run --name be -p 4567:4567 be`

### Next Steps:

- add persistance (redis?)
- add actual reads/writes to API and FE
- wrap in kubernetes
