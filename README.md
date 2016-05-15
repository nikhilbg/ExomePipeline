#Pipeliner

## Introduction

Pipeliner provides access to some of the NGS data analysis pipelines used by CCBR on the NIH Biowulf Linux Cluster. Pipeliner allows the user to select a set of data files, such as fastq sequence reads, and process them via a sequence of programs that constitute an analysis 'pipeline' to reach an endpoint, such as a list of mutations with accompanying annotations.  The program provides a graphical interface in which pipeline options are configured using pulldowns and text entry fields.  Once configured, the pipeline is executed on the Biowulf cluster.
  
## Quick Start

Pipeliner runs on the NIH Biowulf cluster and uses a graphical interface. To use the program one must log into Biowulf using ssh with X11 packet forwarding.  For instance:

```
ssh -Y username@biowulf.nih.gov

```

Once logged in, launch the Pipeliner program:
```
/path/to/pipeliner/install/runpipe.sh
```

If you are running your own installation of Pipeliner, you will need to edit the paths to the programs and files given in these configuration files:

```
hg19.json
mm10.json
standard-bin.json
```

Within the Pipeliner program, the following steps must be executed in order:

* Set the working directory--this is the directory in which all output files will appear and must already exist
* Set the data source--this is the directory containing the starting data which is generally a set of files containing paired end fastq reads
* Initialize the working directory--this step first clears the working directory, then makes a few subdirectories within it and populates these with a number of files needed to run the pipelines
* Link the data files to the working directory--this makes symbolic links from the data files into the working directory
* Perform a dry run to verify that the pipeline is configured properly--if the dry run produces errors, these must be corrected prior to launching
* Launch the pipeline--this submits the pipeline job to the Biowulf cluster

### Prerequisites

* An account on the NIH Biowulf Linux Cluster 


## Configuration and Details

Pipeliner uses a program called Snakemake to manage pipeline workflows.

>[https://bitbucket.org/snakemake/snakemake/wiki/Home] for details.

Snakemake, in turn, accepts a configuration file formatted in JSON (Javascript Object Notation). The principal configuration files used by Pipeliner are:

- hg19.json :references for human genome version 19/GRch37
- standard-bin.json :paths to programs used in the pipeline
- rules.json :lists of Snakemake rules assigned to named pipelines
- cluster.json :SLURM parameters for each rule (memory requested, time, # cpus)

Essential backend python programs include:

- pipeliner.py :main program including GUI components
- makeasnake.py :called by Pipeliner to build Snakefiles required by Snakemake
- stats2html.py :builds reports at end of pipeline run

Essential Directories
- Data :should contain files with adapter sequences to be trimmed in fasta format.  These should be referenced in the appropriate reference json file, e.g. hg19.json.
- Reports
- 


## Pipelines Implemented

- ExomeSeqPairs
- ExomeSeqGermline

## Pipelines Planned


- ChipSeq
- mirSeq
- RNASeq

## Adding your Own Pipelines

You can configure new pipelines by adding Snakemake rules to the Rules directory and referencing them within 'rules.json' as requirements for named pipelines by adding the name of the rule (key) to the json keys and adding the name of the pipeline requiring the rule to the list (the value) for the key.







