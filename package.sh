#!/bin/bash

rm -rf target
mkdir -p target

cp ./*.tf ./target/

pushd src

npm run build
zip -r ../target/lambda.zip *

popd
