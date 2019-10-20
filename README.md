# shell_benchmark
Super easy bash benchmarking tool

In a linux terminal type
$ ./bencher.sh N tests_file.sh


The bencher script looks for "test_*" functions defined in tests_file.sh and runs 
each of them N times.
Also it looks for a "reset" function inside tests_file.sh to reset states before new function cycles.

See "increments.sh" or "file_listing.sh" for an example of a tests_file.
Be conscientious with the N value, by starting at a small amount.