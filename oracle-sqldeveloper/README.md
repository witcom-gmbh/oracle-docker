# docker-sqldeveloper
Docker Container for running Oracle SQL Developer

### Installation

create a directory /src next to the Dockerfile with this file
```
sqldeveloper-23.1.1.345.2114-no-jre.zip
```
you can download the files from
- https://www.oracle.com/database/sqldeveloper/technologies/download/

build the container:
```
./build.sh
```

### Execution

to start SQL Developer using your local X-Server use the script
```
./run.sh
```
