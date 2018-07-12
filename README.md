g-monster
====

g-monster is a shell script to get a reservation of a training to be a monster.

## Introduction

_"Wer mit Ungeheuern kämpft, mag zusehn, dass er nicht dabei zum Ungeheuer wird. Und wenn du lange in einen Abgrund blickst, blickt der Abgrund auch in dich hinein."_

Actually, it's not easy, needs trainings, and the training requires a reservation.
This script ease to get the reservation for the training.

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

A kind of Sand bag you don't like, such as aqua:

	NG_BAG=

Favorite Sand bags can be described, such as "15 16 17 18", these are searched at the first:

	FAVORITE_BAGS=

You can run this script with parameters. The first one is the studio, the second one is the lesson, and the other one is date time when this script stops running like this:

	$ sh g-monster.sh 1234 5678 "7/3 20:20"
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	sleeping 5 seconds
	...
	RESERVED!

In the lucky case, you can get a reservation.

## Attention
Do not abuse this script so that the site can normally operate.
And the specification of the site might change some day, that means it's not strange that one day this script gets not to work.

A little more, almost there, you can do it, GAMBATTE!

## Licence
[GPL](http://www.gnu.org/licenses/)

## Author
[Ryo](https://github.com/maedy)
