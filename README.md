# infrastructure-setup

## Setup environment

Please reference the [Setup](./docs/setup.md) to setup environment.

## Run in local

1. Set the following config into hosts file
```
127.0.0.1       www.demo.com
127.0.0.1       ci.demo.com
127.0.0.1       git.demo.com
127.0.0.1       registry.demo.com
127.0.0.1       monitor.demo.com
```

2. Launch all infrastructure services
```
$> docker-compose up -d
```

## Setup in remote

1. Change the following path in docker-cmopose.yml

```
./temp -> var/local/data
```

2. Execute the following command to deploy remote host
```
$> ./init/deploy.sh <my-server>
```

## License
Code is under the [MIT license](./LICENSE).
