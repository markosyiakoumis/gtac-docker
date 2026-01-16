#!/bin/sh
set -e

if [ ! -f /data/server.xml ]; then
    cp /opt/gtac/server.xml /data/server.xml
else
    ln -sf /data/server.xml /opt/gtac/server.xml
fi

if [ -d /data/logs ]; then
    ln -sfn /data/logs /opt/gtac/
elif [ -d /opt/gtac/logs ]; then
    cp -r /opt/gtac/logs /data/
fi

if [ ! -d /data/modules ]; then
    cp -r /opt/gtac/modules /data/
else
    rm -rf /opt/gtac/modules
    ln -sf /data/modules /opt/gtac/
fi

if [ ! -d /data/resources ]; then
    cp -r /opt/gtac/resources /data/
else
    rm -rf /opt/gtac/resources
    ln -sf /data/resources /opt/gtac/
fi

exec "$@"