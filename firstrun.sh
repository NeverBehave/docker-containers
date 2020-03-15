#!/bin/bash
chown -R nobody:users /config
# Check if config exists. If not, copy in the sample config

set -e
CONFIG_PATH="/config/config.xml"
TEMPLATE_PATH="/root/config.xml"

if [ -f ${CONFIG_PATH} ]; then
  
  echo "[I] Using existing config file."
  cat ${CONFIG_PATH}
  
  else

  echo "[I] Creating config from template."
  
  TEMPLATE_CONFIG=$(cat ${TEMPLATE_PATH})

  APPLIED_TEMPLATE=$(printf "$TEMPLATE_CONFIG" \
              "$GPU_STATUS" "$ALLOW_SUBNET_HTTP" "$PASSWORD" \
              "$TEAM_ID" "$USER_ID" "$PASSKEY" \
              "$ALLOW_SUBNET_WEB" "$POWER" \
              "$EXTRA_CONFIG")

  echo "[I] Config Created"
  echo "$APPLIED_TEMPLATE"

  echo "[I] Writing Config"
  echo "$APPLIED_TEMPLATE" > ${CONFIG_PATH}
fi

echo "[I] Setting file permission"
chown nobody:users ${CONFIG_PATH}
chmod 777 ${CONFIG_PATH}

