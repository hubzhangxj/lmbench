#!/bin/bash

cd ../bin/lmbench

function lat_local_test_trash() {
	echo '********localdie 1core ***********'
	numactl --membind=0 --physcpubind=0 ./lat_mem_rd -P 1 -N 5 -t 256M 128 2>&1
	echo '********localdie 12core ***********'
	numactl --membind=0 --physcpubind=0-11 ./lat_mem_rd -P 12  -N 5 -t 256M  128 2>&1
	echo '********localdie 24core ************'
	numactl --membind=0 --cpunodebind=0 ./lat_mem_rd -P 24 -N 5 -t 256M 128 2>&1
	echo '********localdie 48core ************'
	numactl --membind=0 --cpunodebind=0,1 ./lat_mem_rd -P 48 -N 5 -t 256M 128 2>&1
}

function lat_local_test_stride() {
	echo '********2P 1core s***********'
	numactl --membind=0 --physcpubind=0 ./lat_mem_rd -P 1 -N 5 256M 128
	echo '********2P 12core  s***********'
	numactl --membind=0 --physcpubind=0-11 ./lat_mem_rd -P 12  -N 5 256M  128
	echo '********2P CPU0  s************'
	numactl  --cpunodebind=0 ./lat_mem_rd -P 32  -N 5 256M 128
	echo '********2P CPU12  s************'
	numactl  --physcpubind=0-63 ./lat_mem_rd -P 64  -N 5 256M 128
}

function lat_cross_socket_trash() {
	echo '********cross socket  1core t***********'
	numactl --membind=1 --physcpubind=0 ./lat_mem_rd -P 1 -N 5 -t 256M 128 2>&1
	echo '********cross socket  12core  ***********'
	numactl --membind=1 --physcpubind=0-11 ./lat_mem_rd -P 12 -N 5 -t 256M  128 2>&1
	echo '********cross socket  24core  ***********'
	numactl --membind=1 --cpunodebind=0 ./lat_mem_rd -P 24 -N 5 -t 256M  128 2>&1
}

function lat_cross_socket_stride() {
	echo '********2P  P0TA->P1TA  1core s***********'
	numactl --membind=2 --physcpubind=0 ./lat_mem_rd -P 1 -N 5 256M 128
	echo '********2P  P0TA->P1TA  4core s***********'
	numactl --membind=2 --physcpubind=0-3 ./lat_mem_rd -P 4 -N 5 256M 128
	echo '********2P  P0TA->P1TA  16core  s***********'
	numactl --membind=2 --physcpubind=0-15 ./lat_mem_rd -P 16 -N 5 256M  128
}

lat_local_test_trash
lat_cross_socket_trash
