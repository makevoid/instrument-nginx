# nginx-monitoring

sample based on ruby and docker compose where we add and test nginx instrumentation module(s) [HTTP, Websocket]

NOTE: the stable docker nginx comes already with `ngx_http_stub_status_module` enabled (configuration: https://github.com/makevoid/nginx-monitoring/blob/master/nginx/nginx.conf#L97-L99)

### Dirs

`nginx` - nginx container
`app` - sample application (ruby, redis)
`spec` - sample test

### Project status

WIP (this repo is a draft)

### Building

    docker-compose build


### Running

    docker-compose up


then visit http://localhost


### Specs

    cd spec
    bundle exec rake

note: you have to have the environment running on compose (`docker-compose up --build`) for the specs to pass

### Contribute

Open an issue or a pull request if you want to suggest or improve the project


### Links

`ngx_http_stub_status_module` - http://nginx.org/en/docs/http/ngx_http_stub_status_module.html


Thanks!
