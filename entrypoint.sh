#!/bin/bash

if [ ! -f "/nxfilter/conf/cfg.default" ]; then
  cp -a /nxfilter/conf-bak/. /nxfilter/conf/
fi
exec "$@"
