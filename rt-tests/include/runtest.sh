#!/bin/bash

# Source rhts environment
. /usr/bin/rhts_environment.sh

function rt_package_install()
{
    packages="rt-tests rt-setup rteval rteval-loads tuned-profiles-realtime tuna"
    echo "install needed package $packages " | tee -a $OUTPUTFILE
    for i in $packages; do
        if $(rpm -q --quiet $i); then
            continue
        else
            dnf install -y $i
        fi
    done
}

function rt_env_setup()
{
    kernel_name=$(uname -r)
    if [[ $kernel_name =~ "rt" ]]; then
        echo "running the $kernel_name" | tee -a $OUTPUTFILE
        rt_package_install
    else
        echo "non rt kernel, please use rt kernel" | tee -a $OUTPUTFILE
        rhts-report-result $TEST "SKIP" $OUTPUTFILE
        exit
    fi
}
