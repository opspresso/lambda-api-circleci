#!/bin/bash

rm -rf target
mkdir -p target

pushd src

npm run build
zip -r ../target/lambda.zip *

popd
