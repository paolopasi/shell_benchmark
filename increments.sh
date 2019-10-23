#!/bin/bash
function reset {
	i=0
}
function test_1 {
	((i++))
}
function test_2 {
	i=$((i+1))
}
function test_3 {
	let i++
}
function test_6 {
	let i=i+1
}
function test_4 {
	((i=i+1))
}
function test_5 {
	((++i))
}
function test_with_name {
	((i+=1))
}