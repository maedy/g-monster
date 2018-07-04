g-monster
====

g-monster is a shell script to get a reservation of a training to be a monster.

## Introduction

_"Wer mit Ungeheuern kämpft, mag zusehn, dass er nicht dabei zum Ungeheuer wird. Und wenn du lange in einen Abgrund blickst, blickt der Abgrund auch in dich hinein."_

Actually, it's not easy, needs trainings, and the training requires a resevation.
This script ease to get the resevation for the training.

## Requirement

This will work with the following tools in Linux, BSD, Mac OS X.

* [curl](https://curl.haxx.se/)
* [jq](https://stedolan.github.io/jq/)

## Usage

Set the following variables in the script as you want:

MAIL is for login to the site and @ needs to be URI encoded like %40:
	MAIL=
Password for the site:
	PASSWORD=
The URI of the site:
	BASE=
The number of the lesson, you can see at the URI of the lesson:
	LESSON=
The number of the studio, also you can see at the URI:
	STUDIO=
A kind of Sand bag you don't like, such as aqua:
	NG_BAG=
Favirote Sand bags can be described, such as "15 16 17 18", these are searched at the first:
	FAVORITE_BAGS=

After setting the above variables, you can run this script with the end of date time to run:

	$ sh g-monster.sh "7/3 20:20"
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	...
	RESERVED!

In the lucky case, you can get a resevation.

## Attention
Do not abuse this script so that the site can normally operate.
And the specification of the site might change some day, and there's no guarantiee.

A little more, almost there, you can do it, GANBATTE!

## Licence
[GPL](http://www.gnu.org/licenses/)

## Author
[Ryo](https://github.com/maedy)

