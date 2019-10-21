# shell_benchmark
Super easy bash benchmarking tool

In a linux terminal type
$ ./bencher.sh N tests_file.sh


The bencher script looks for "test_*" functions defined in tests_file.sh and runs 
each of them N times.
Also it looks for a "reset" function inside tests_file.sh to reset states before new function cycles.

See "increments.sh" or "file_listing.sh" for an example of a tests_file.
Be conscientious with the N value, by starting at a small amount.


Example of a result:

$ ./bencher.sh 100 increments.sh\
  Loading tests file increments.sh\
  Iterating 100 times for 6 methods\
 12 ms for test_1\
 13 ms for test_2\
 13 ms for test_3\
 12 ms for test_6\
 12 ms for test_4\
 11 ms for test_5

 ---Sorted---\
 11 test_5\
 12 test_1\
 12 test_4\
 12 test_6\
 13 test_2\
 13 test_3

 ---Best---\
 test_5 ()\
 {\
     ((++i))\
 }
