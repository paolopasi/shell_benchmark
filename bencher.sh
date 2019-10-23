#!/bin/bash
## Usage: ./bencher.sh N executable.sh
##
## See README.md for more details
## https://github.com/paolopasi/shell_benchmark
(
	function stamp {
		now=`date +%s%3N`
		diff=`echo "$((now-last))"`
		last=`echo $now`	
	}
	function result {
		#body=`declare -f $1`
		name="$1"
		echo "$diff ms for $name $body"
		#printf %.6f\\n "$((10**9 * diff/max))e-9"	
		results[((bench++))]="$diff $name"
	}
	function bench {
		$reset_func	
		stamp
		for c in $sequence
		do
			$1
		done
		stamp
		result "$1"
	}
	function main {
		max=$1
		test_file=$2
		sequence=`seq $max`
		last=`date +%s%3N`
		now=0
		diff=0
		tests=`grep  '^function test_' $test_file | cut -d ' ' -f 2`
		tests_count=`echo $tests | wc -w`
		reset_func=`grep  '^function reset' $test_file | cut -d ' ' -f 2`
		results=()
		echo " Loading tests file $test_file"
		. $test_file
		echo " Iterating $max times for $tests_count methods"
		for t in $tests
		do
			bench $t
		done
		echo
		echo "---Sorted---"
		sorted=`(IFS=$'\n'; echo "${results[*]}")|sort -n -k 1`
		echo "$sorted"
		echo
		echo "---Best---"
		best=`echo $sorted|head -1|cut -d ' ' -f 2`
		declare -f $best
	}
	main $*
)