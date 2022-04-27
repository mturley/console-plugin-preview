#!/bin/sh

if [ ! -f "./stub-app/package.json" ]; then
    echo "You must run this script from the root of your console-plugin-preview directory."
    exit 1
fi

WD=$(pwd)

if [ ! -d "./tmp/console/frontend/packages/console-dynamic-plugin-sdk/dist" ]; then
  echo "\nCloning and building console frontend in tmp directory...\n"
  if [ -d "./tmp/console" ]; then
    echo "Cleaning up existing console directory first..."
    rm -rf ./tmp/console
  fi
  mkdir -p tmp
  cd tmp
  git clone https://github.com/openshift/console.git
  cd console
  ./build-frontend.sh
else
  echo "\nSkipping clone/build of console (build assets already found)"
fi

cd "$WD"
echo "\nInstalling dependencies for stub-app...\n"
cd stub-app
yarn install

cd "$WD"
echo "\nLinking internal console dependencies in stub-app...\n"
ln -sv ../tmp/console/ ./node_modules/console

cd "$WD"

# TODO: link the rest of the node_modules we need from inside console
# TODO: see if we can successfully load a plugin?
# TODO: run a build and see if it can successfully load a plugin in prod?
# TODO: see if we can get it to run via npx somehow?
# TODO: see if we can get it to load the plugin via MSW? how to pass it in?

# TODO: document the stuff we tried and gave up on (direct git dependency in package.json, yarn workspaces, yalc, npm-link-shared)