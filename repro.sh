#!/bin/sh
REPO_ROOT="$(dirname "$(readlink -f "$0")")"

# move to a nested dir
echo "*** Moving to sub-directory"
pushd "${REPO_ROOT}/a/b/c"
echo "*** Using run config with paths relative to repo_root/config"
# works no matter directory you're in; the paths in the yml are relative to the
# yml file location
pf run create -f "${REPO_ROOT}/config/local-run-relative_to_config.yml"
popd

echo "*** Moving to repo root"
pushd "${REPO_ROOT}"
# fails; the paths are relative to repo root and the data path cannot be resolved
# paths appear to be resolved relative yml's config location, not pf/script wd
echo "*** Using run config with paths relative to working-dir (repo_root)"
pf run create -f "${REPO_ROOT}/config/local-run-relative_to_root.yml"

# works, but unclear why - the data paths in the yml is relative to the yml file
# location; the flow path is relative to repo root - per test above, we expected
# this to fail.
#
# It seems the path resolution for 'data' and 'flow' field paths are not identical.
echo "*** Using run config with data path relative to repo_root/config, flow path relative to working-dir (repo_root)"
pf run create -f "${REPO_ROOT}/config/local-run-invalid.yml"
popd
