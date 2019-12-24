#!/bin/bash
mongod -f ./master.conf
mongod -f ./slave.conf
mongod -f ./arbiter.conf