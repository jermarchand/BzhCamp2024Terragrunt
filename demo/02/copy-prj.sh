#!/bin/bash

cp -r app1-dev app1-int
cd app1-int
rm -rf .terraform .terraform.lock.hcl tfplan
cd ..

cp -r app1-dev app1-prd
cd app1-prd
rm -rf .terraform .terraform.lock.hcl tfplan
cd ..