#!/bin/bash

module load pepatac

singularity exec --bind ${GENOMES} \
                 --bind /labs/syang5 \
                 --bind ${ANNOTATIONS} \
                 --bind ${PEPATAC} $PEPATAC/pepatac \
                 ${PEPATAC}/pipelines/pepatac.py \
                   --config /path_to_config_file/pepatac_7ligands_0.01.yaml \
                   -P 16 \
                   --single-or-paired paired \
                   --prealignments rCRSd human_repeats \
                   --genome hg19 \
                   --sample-name CL_Merged \
                   --input /path_to_read_file/CL_R1.fastq.gz \
                   --input2 /path_to_read_file/CL__R2.fastq.gz \
                   --genome-size hs \
                   -O /path_to_outoput/CL

