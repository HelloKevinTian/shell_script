#!/bin/bash
mongod -f conf/master.conf
mongod -f conf/slave.conf
mongod -f conf/arbiter.conf