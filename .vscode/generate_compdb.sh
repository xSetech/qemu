#!/bin/bash
# note: run this from the repo root dir

pushd build/

# VSCode tries to guess the compiler based on the first term in the compile commands,
# which can be ccache and not e.g. clang. This fixes up the compile commands so that
# VSCode isn't confused and also injects the macOS SDK location ("SDKROOT").
SDKROOT="${SDKROOT:-$(xcrun --show-sdk-path)}"
ninja -t compdb | sed 's@"ccache @"@g' | sed "s@clang\s@clang --sysroot=${SDKROOT} @g" > ../.vscode/compile_commands.json

popd