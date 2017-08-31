#!/bin/bash -e

# clone next theme and copy config file
git clone https://github.com/iissnan/hexo-theme-next themes/next
cp .theme_config.yml themes/next/_config.yml