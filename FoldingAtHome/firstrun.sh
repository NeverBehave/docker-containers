#!/bin/bash
chown -R nobody:users /config
# Check if config exists. If not, copy in the sample config

set -e
CONFIG_PATH="/config/config.xml"
TEMPLATE_PATH="/root/config.xml"

if [ -f ${CONFIG_PATH} ]; then
  
  echo "[I] Using existing config file."
  
  else

  echo "[I] Creating config from template."
  
  template=$(< ${TEMPLATE_PATH})
  printf "$template" \ 
              "$GPU_STATUS" "$ALLOW_SUBNET_HTTP" "$PASSWORD" \
              "$TEAM_ID" "$USER_ID" "$PASSKEY" \
              "$ALLOW_SUBNET_WEB" "$POWER" > ${CONFIG_PATH}

  echo "[I] Config Created"
fi

echo "[I] Current Config"
cat ${CONFIG_PATH}

echo "[I] Setting file permission"
chown nobody:users ${CONFIG_PATH}
chmod 777 ${CONFIG_PATH}

