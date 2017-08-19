#!/bin/bash
set -e

if [[ "$1" == "qtum-cli" || "$1" == "qtum-tx" || "$1" == "qtumd" || "$1" == "test_qtum" ]]; then
	mkdir -p "$QTUM_DATA"

	if [[ ! -s "$QTUM_DATA/qtum.conf" ]]; then
		cat <<-EOF > "$QTUM_DATA/qtum.conf"
		printtoconsole=1
		rpcallowip=::/0
		rpcpassword=${QTUM_RPC_PASSWORD:-password}
		rpcuser=${QTUM_RPC_USER:-qtum}
		EOF
		chown qtum:qtum "$QTUM_DATA/qtum.conf"
	fi

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R qtum "$QTUM_DATA"
	ln -sfn "$QTUM_DATA" /home/qtum/.qtum
	chown -h qtum:qtum /home/qtum/.qtum

	exec gosu qtum "$@"
fi

exec "$@"