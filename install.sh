#!/bin/sh

if [ ! -f "./stub-app/package.json" ]; then
    echo "You must run this script from the root of your console-plugin-preview directory."
    exit 1
fi

wd=$(pwd)

if [ ! -d "./tmp/console/frontend/packages/console-dynamic-plugin-sdk/dist" ]; then
  echo "\nCloning and building console frontend in tmp directory...\n"
  if [ -d "./tmp/console" ]; then
    echo "Cleaning up existing console directory first..."
    rm -rf ./tmp/console
  fi
  mkdir -p tmp
  cd tmp
  git clone https://github.com/openshift/console.git
  # cd console
  # ./build-frontend.sh
else
  echo "\nSkipping clone/build of console (build assets already found)"
fi

echo "\nInstalling dependencies for stub-app...\n"
cd "$wd/stub-app"
yarn install

echo "\nLinking internal console dependencies in stub-app...\n"
[ ! -d "$wd/stub-app/node_modules/console" ] && ln -sv ../../tmp/console "$wd/stub-app/node_modules/console"

# cd "$wd/tmp/console/frontend/node_modules"
# for d in */ ; do
#   dep="${d%/}"
#   [ ! -d "$wd/stub-app/node_modules/$dep" ] && ln -sv "../../tmp/console/frontend/node_modules/$dep" "$wd/stub-app/node_modules/$dep"
# done
# cd "$wd/tmp/console/frontend/packages/console-dynamic-plugin-sdk/node_modules"
# for d in */ ; do
#   dep="${d%/}"
#   [ ! -d "$wd/stub-app/node_modules/$dep" ] && ln -sv "../../tmp/console/frontend/packages/console-dynamic-plugin-sdk/node_modules/$dep" "$wd/stub-app/node_modules/$dep"
# done

cd "$wd"

# TODO: figure out why we are still getting import errors (install needed dependencies, but what's up with th eexport in common-types.ts?)

# TODO: see if we can successfully load a plugin?
# TODO: run a build and see if it can successfully load a plugin in prod?
# TODO: see if we can get it to run via npx somehow?
# TODO: see if we can get it to load the plugin via MSW? how to pass it in?

# TODO: document the stuff we tried and gave up on (direct git dependency in package.json, yarn workspaces, yalc, npm-link-shared)