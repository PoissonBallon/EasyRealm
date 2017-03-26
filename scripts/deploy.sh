#!/usr/bin/env bash

pod lib lint EasyRealm.podspec --verbose
pod trunk push EasyRealm.podspec --verbose
