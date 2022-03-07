#!/usr/bin/env bash

#function: test_image
test_image () {
	case $1 in
	 1|01)
	   echo "Icon:" a
	 ;;
	 2|02)
	   echo "Icon:" b
	 ;;
	 3|03)
	   echo "Icon:" c
	 ;;
     4|04)
	   echo "Icon:" c
	 ;;
     5|05)
	   echo "Icon:" c
	 ;;
	 6|06)
	   echo "Icon:" d
	 ;;
	 7|07)
	   echo "Icon:" e
	 ;;
     8|08)
	   echo "Icon:" e
	 ;;
	 11)
	   echo "Icon:" 0
	 ;;
	 12)
	   echo "Icon:" h
	 ;;
	 13|14)
	   echo "Icon:" g
	 ;;
	 15)
	   echo "Icon:" l
	 ;;
	 16|17)
	   echo "Icon:" k
	 ;;
	 18|26)
	   echo "Icon:" i
	 ;;
	 19)
	   echo "Icon:" p
	 ;;
	 20|21|23)
	   echo "Icon:" o
	 ;;
	 22)
	   echo "Icon:" r
	 ;;
	 24|31)
	   echo "Icon:" E
	 ;;
	 25)
	   echo "Icon:" u
	 ;;
	 29)
	   echo "Icon:" v
	 ;;
     30)
	   echo "Icon:" 5
	 ;;
	 32)
	   echo "Icon:" 6
	 ;;
	 33)
	   echo "Icon:" A
	 ;;
	 34|36|37)
	   echo "Icon:" B
	 ;;
	 35|38)
	   echo "Icon:" C
	 ;;
	 39|40)
	   echo "Icon:" G
	 ;;
	 41|42)
	   echo "Icon:" K
	 ;;
	 43|44)
	   echo "Icon:" O
	 ;;
	esac
}

test_wind () {
	case $1 in
		CLM)
		echo "Wind Direction: -"
		;;
		S)
		echo "Wind Direction: ↓"
		;;
		SSW)
		echo "Wind Direction: ↙"
		;;
		SW)
		echo "Wind Direction: ↙"
		;;
		WSW)
		echo "Wind Direction: ↙"
		;;
		W)
		echo "Wind Direction: ←"
		;;
		WNW)
		echo "Wind Direction: ↖"
		;;
		NW)
		echo "Wind Direction: ↖"
		;;
		NNW)
		echo "Wind Direction: ↖"
		;;
		N)
		echo "Wind Direction: ↑"
		;;
		NNE)
		echo "Wind Direction: ↗"
		;;
		NE)
		echo "Wind Direction: ↗"
		;;
		ENE)
		echo "Wind Direction: ↗"
		;;
		E)
		echo "Wind Direction: →"
		;;
		ESE)
		echo "Wind Direction: ↘"
		;;
		SE)
		echo "Wind Direction: ↘"
		;;
		SSE)
		echo "Wind Direction: ↘"
		;;
	esac
}

#put your accuweather api address here
address="http://dataservice.accuweather.com/currentconditions/v1/45449?apikey=06rvF5Iu1eUnaQ6tx3EHl7NKiMb12d13&language=pt-br&details=true"
directory=$HOME/.conky/accuweather
curl -o $directory/weather_raw $address
cat $directory/weather_raw | sed 's/^.//;s/.$//' > $directory/weather.json

weatherText=$(jq -r '.WeatherText' $directory/weather.json)
weatherIcon=$(jq -r '.WeatherIcon' $directory/weather.json)
temperature=$(jq -r '.Temperature.Metric.Value' $directory/weather.json)
realFeel=$(jq -r '.RealFeelTemperature.Metric.Value' $directory/weather.json)
windDirection=$(jq -r '.Wind.Direction.English' $directory/weather.json)
windSpeed=$(jq -r '.Wind.Speed.Metric.Value' $directory/weather.json)
precipitation=$(jq -r '.PrecipitationSummary.Precipitation.Metric.Value' $directory/weather.json)

if [[ -s $directory/weather.json ]]; then
	test_image $weatherIcon > $directory/weather
	echo "Text:" $weatherText >> $directory/weather
	echo "Temperature:" $temperature >> $directory/weather
	echo "RealFeel:" $realFeel >> $directory/weather
	test_wind $windDirection >> $directory/weather
	echo "Wind Speed:" $windSpeed"km/h" >> $directory/weather
	echo "Precipitation:" $precipitation"mm" >> $directory/weather
fi
