# atlassian-fisheye
Restartable, persistent docker image for atlassian fisheye (+ crucible as the same installer is used)

Any feedback let me know - its all welcome!

# Pre-req

Before running this docker image, please [clone / download the repo](https://github.com/blofse/atlassian-fisheye), inlcuding the script files.

# How to use this image
## Initialise

Run the following command, replacing *** with your desired db password:
```
./initial_start.sh '***'
```
This will setup two containers: 
* atlassian-fisheye-postgres - a container to store your fisheye db data
* atlassian-fisheye - the container containing the fisheye/crucible server

And also two following persitent volumes:
* FisheyePostgresData - used for fisheye db data
* FisheyeHomeVolume - used for fusheye home directory.

Once setup, please use the following for DB connectivity:
* DB host: pgfisheye
* DB user: fisheye
* DB database: fisheye
* DB password: ****

Please note, using the initial start command will install two persistent docker volumes which will remain once the docker images are removed.
This allows upgrading but also solves curruption issues which can happen with the atlassian tools. Please remove these yourself should you want to delete everything (and/or restart from the beginning).

## (optional) setting up as a service

Once initialised and perhaps migrated, the docker container can then be run as a service. 
Included in the repo is the service for centos 7 based os's and to install run:
```
./copy_install_and_start_as_service.sh
```


