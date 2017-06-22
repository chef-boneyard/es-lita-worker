#!/bin/bash
eval "$(chef shell-init bash)"

ruby --version
chef --version
hab --version

echo ""
exec "$@"
