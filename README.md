# GagSpeak-WebService
the webservice component for gagspeak. Includes discord bot integration (maybe). And is a reference to the files being run on the virtual machine.

## Running

First, rename the file `appsettings.template.json` to `appsettings.json` and update any of the fields marked "set me" as required.

Next, rename the file `template.env` to `.env` and update the various environment variables to match.

Please ensure that your database, database user and database password match between the two.

After those have been configured, you can start the stack locally using the provided docker compose file with the following command:

```
docker compose up -d
```
Note: This will require that [docker](https://docs.docker.com/engine/install) (or docker alternative such as podman) to be installed on your machine. 

Please ensure that before you connect with your GS client that you first rename your plugin configuration (located at `%appdata%/XIVLauncher/pluginConfig/ProjectGagSpeak`), then create a file with the path `%appdata%\XIVLauncher\pluginConfig\ProjectGagSpeak\server.json` with the following information.

```
{
  "Version": 0,
  "ServerStorage": {
    "Authentications": [],
    "FullPause": false,
    "ServerName": "GagSpeak Local",
    "ServiceUri": "ws://localhost"
  }
}
```

## Testing Discord bot

This section requires configuration within discord to complete.

TODO: Add when the configuration is confirmed
