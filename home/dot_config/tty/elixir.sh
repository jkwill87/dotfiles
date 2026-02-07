#!/bin/sh

exists xcrun && export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export KERL_BUILD_DOCS=yes
export ERL_AFLAGS="-kernel shell_history enabled"
