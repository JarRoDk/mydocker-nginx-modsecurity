#! /bin/sh
#
# build.sh
# Copyright (C) 2017 root <root@jarrod>
#
# Distributed under terms of the MIT license.
#


docker build -t ubuntu-custom-wget-git-modsecurity . $* 
