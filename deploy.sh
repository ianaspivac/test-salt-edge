


cd dist

git add -A
git commit -m 'deploy'

 git push -f git@github.com:ianaspivac/test-salt-edge.git main:gh-pages

cd -