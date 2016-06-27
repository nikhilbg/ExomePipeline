rule strelka:
    input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".realign.bam",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam"
    output: vcf=lambda wildcards: config['project']['pairs'][wildcards.x][1]+"_"+lambda wildcards: config['project']['pairs'][wildcards.x][0]"+.vcf",
            dir=lambda wildcards: config['project']['pairs'][wildcards.x][1]+"_"+lambda wildcards: config['project']['pairs'][wildcards.x][0]
    params: strelkaconfig=config['references']['STRELKA_CONFIG'],gatk=config['bin']['GATK'],genome=config['references']['GENOME'],rname="pl:strelka"
    threads: 4
    shell: "module load strelka; $STRELKA_INSTALL_DIR/bin/configureStrelkaWorkflow.pl --config={params.strelkaconfig} --ref={params.genome} --tumor={input.tumor} --normal={input.normal} --output-dir=strelka/{output.dir}; cd strelka/{output.dir}; make -j 4; {params.gatk} -T CombineVariants -R {params.genome} --variant results/passed.somatic.snvs.vcf --variant results/passed.somatic.indels.vcf --assumeIdenticalSamples --filteredrecordsmergetype KEEP_UNCONDITIONAL -o ../{output.vcf}"