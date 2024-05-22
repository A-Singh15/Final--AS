#!/bin/csh -f

cd /home/921088438/final/Final--AS

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/packages/synopsys/vcs/R-2020.12-SP2-11/linux64/bin/vcselab $* \
    -o \
    simv \
    -nobanner \

cd -

