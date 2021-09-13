#!/usr/bin/env sh

git init
git add -A
git commit -m 'deploy'
git push -f git@github.com:ianaspivac/test-salt-edge.git master:gh-pages
cd -