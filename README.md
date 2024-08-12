# LUG Brasil - Search Advanced Features

## Setup the project

Create a symbolic link to `bundles/deploy` in `bundles/osgi/modules`. This way, builds will automatically deploy to the container:

```
mkdir -p bundles/osgi
ln -s ../../bundles/deploy bundles/osgi/modules
```

## Deploy

```
blade gw deploy
```

## Start

```
docker compose up --build -d
```

## Persistent Volumes

### Liferay Files

The `docker-compose/liferay-files` is mounted on `/mnt/liferay/files` of the container, so all customization regarding liferay home should be put there.

### Logs and Deploy folder

You can check the logs of your container in the folder `bundles/logs`, and if you need to deploy something, you can use the `bundles/deploy` folder.

### Keep the State

To keep the state of the portal even when the environment is deleted, we have the following persistent volumes:

* Document Library: `bundles/data/document_library/`
* Elasticsearch 01: `bundles/data/elasticsearch-data/`
* Elasticsearch 02: `bundles/data/elasticsearch-ext-data/`

Also, the database service will load the dump (`*.sql` format) in the folder `docker-compose/database-dump` at the startup. So, in order to keep the state of your instance, generate a dump before you shutdown:

```
mysqldump -uroot -proot lportal -c -B --column-statistics=0 --add-drop-database --host localhost > docker-compose/database-dump/lportal.sql
```

After that, is safe to execute `docker compose down`, then in the next time you up the environment the state will be kept.

# Stop

```
docker compose down
```