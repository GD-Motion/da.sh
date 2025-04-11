# da.sh - GDPS in a (bash) shell

## Setup
Clone the repository and make sure all files are executable. Then run the server.
```
git clone ...
cd da.sh
chmod -R +x endpoints; chmod +x .*sh
bash server.sh
```

## Configuration
Script configuration is done in `config.sh`. Server configuration does not exist yet.  
Changes in server.sh and handler.sh are not considered during runtime.

## Notes
This is not meant to be used for an actual server.
- HTTPS is not supported (proxy it to something like nginx)
- Browser requests are not supported
- Target is 2.2, older versions are not supported
- Many many things are bent broken to keep things minimal
- Currently not scalable, any additions/removals to the "schema" will usually require a full reset