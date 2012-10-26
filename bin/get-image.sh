#!/bin/bash
wget http://www.geocaching.com/images/attributes/$1.gif
wget http://www.geocaching.com/images/attributes/$1-yes.gif
wget http://www.geocaching.com/images/attributes/$1-no.gif
mv $1.gif $2.gif
mv $1-yes.gif $2-1.gif
mv $1-no.gif $2-0.gif
