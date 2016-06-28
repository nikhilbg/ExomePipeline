rule gatk_merge_somatic_vcfs:
    input: expand("{s}"+".FINAL.vcf",s=pairs)
    output: vcf="merged_somatic.vcf",
            summary="somatic_variants"
    params: regions=config['references']['REFFLAT'],gres="lscratch:100",gatk=config['bin']['GATK'],genome=config['references']['GENOME'],snpsites=config['references']['SNPSITES'],rname="CombineVariants"
    run:
        fl=os.popen("ls mutect2/*.FINAL.vcf").read().split()      
        var=" --variant "+" --variant ".join(fl)
        cmd="cd mutect2; {params.gatk} -T CombineVariants -R {params.genome} -L {paras.regions} --filteredrecordsmergetype KEEP_UNCONDITIONAL -o {output.vcf}"+var; module load picard; java -Xmx48g -jar $PICARDJARPATH/picard.jar CollectVariantCallingMetrics INPUT={output.vcf} OUTPUT={output.summary}
        system(cmd)