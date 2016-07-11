rule fastq_screen:
    input:  read_one="{x}.R1."+config['project']['filetype'],
            read_two="{x}.R2."+config['project']['filetype']
    output: "{x}.R1_screen.txt",
            "{x}.R1_screen.png",
            "{x}.R2_screen.txt",
            "{x}.R2_screen.png"
    params: fastq_screen=config['bin']['FASTQ_SCREEN'],
            config=config['references']['FASTQ_SCREEN_CONFIG'],rname="pl:fastq_screen"
    threads: 8
    shell:  """
            module load bowtie; {params.fastq_screen} --conf {params.config} --aligner bowtie2 --force --outdir QC/ {input.read_one} {input.read_two}
           """