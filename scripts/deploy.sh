#!/usr/bin/env bash

source ~/.rvm/scripts/rvm
rvm use default
pod lib lint --verbose
pod trunk push
