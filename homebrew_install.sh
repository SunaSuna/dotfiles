#!/bin/bash

echo "installing Command Line Tools..."
xcode-select --install

echo "installing homebrew..."
which brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update --verbose

echo "run brew bundle..."
brew bundle --verbose

cat << END

**************************************************
HOMEBREW INSTALLED! bye.
**************************************************

END
