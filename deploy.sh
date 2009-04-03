#!/bin/sh

jruby -S warble
cd ../tmp/yarbl_web
rm -rf *
jar xf ../../yarbl/yarbl.war
~/Desktop/Secrets/appengine-java-sdk/bin/appcfg.sh update .

