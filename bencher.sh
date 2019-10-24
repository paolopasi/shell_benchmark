#!/bin/bash
## Usage: ./bencher.sh N executable.sh
##
## See README.md for more details
## https://github.com/paolopasi/shell_benchmark
(
	function stamp {
		now=`date +%s%3N`
		diff=now-last
		last=now
	}
	function add_result {
		echo "$diff ms for $1"
		results+=("$diff $1")
	}
	function bench {
		$reset_func
		stamp
		for ((c=-max;c++<0;))
		do
			$1
		done
		stamp
	}
	function main {
		test_file=$2
		declare -i max=$1
		declare -i last=`date +%s%3N`
		declare -i now=0
		declare -i diff=0
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
			add_result $t
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
