#!/bin/sh

# LLVM toolchain (Homebrew)
if [ -d '/usr/local/opt/llvm' ]; then
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/llvm/lib"
    export CPPFLAGS="-I/usr/local/opt/llvm/include"
fi

# macOS SDK root (needed by Erlang/Elixir builds)
command -v xcrun >/dev/null 2>&1 && export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
