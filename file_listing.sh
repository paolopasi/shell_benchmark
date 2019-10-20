#!/bin/bash
folder='/usr/lib'
function reset {
	lst=0
}
function test_ls_path {
	lst=$(ls -1 $folder|(while read name; do echo "$folder/$name"; done))
}
function test_find {
	lst=$(find $folder -maxdepth 1)
}
function test_ls_path_unsorted {
	lst=$(ls -1U $folder|(while read name; do echo "$folder/$name"; done))
}
function test_ls_nopath {
	lst=$(ls -1 $folder)
}
function test_ls_nopath_unsorted {
	lst=$(ls -1U $folder)
}
function test_find_nopath {
	lst=$(find $folder -maxdepth 1 -printf '%f\n')	
}