#!/bin/bash

years="1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015"
months1="01 02 03 04 05 06 07 08 09 10 11 12"
months2="11 12"
n=1

for y in $years
do
	if [ $y = "1997" ]; then
		months=$months2
	else
		months=$months1
	fi

	for m in $months
	do
		d=1
		while [ $d -lt 31 ];
		do
			rd=""
			if [ $d -lt 10 ]; then
				rd="0$d"
			else
				rd="$d"
			fi

			echo -ne Searching number $n\\r
			sleep 10
			url="https://web.archive.org/web/http://ars.userfriendly.org/cartoons/?id=${y}${m}${rd}"
			wget $url -O tmp.html 
				image1=`cat tmp.html | grep -o "http://www.userfriendly.org/cartoons/archives/.\+\.gif"`
				image="https://web.archive.org/web/$image1"
				if [ "$image" != "" ]; then
					if [ ! -f "${n}.png" ]; then
						echo -ne Downloading number $n\\r
						wget $image -O "${n}.gif" 
#						convert -verbose -coalesce "${n}.gif" "${n}.png"

						if [ -f tmp.html ]; then
							rm tmp.html
						fi
#						rm *.gif
					fi

					let "n++"
				fi
			let "d++"
		done
	done
done
