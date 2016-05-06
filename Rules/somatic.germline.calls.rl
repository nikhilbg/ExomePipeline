rule samtools_mpileup:
     input: expand("{s}"+".realign.bam",s=samples)
     output: "germline.vcf"
     params: genome=config['references']['GENOME'],regions=config['references']['REFFLAT'],rname="pl:mpileup"
     shell: "ls *realign.bam > samtoolsinbams; module load samtools; samtools mpileup -ug -b samtoolsinbams --fasta-ref {params.genome} --positions {params.regions} | bcftools call -mvO v - > {output}"