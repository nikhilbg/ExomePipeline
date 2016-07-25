rule gatk_merge_somatic_vcfs:
    input: expand("mutect2_out/{p}"+".FINAL.vcf",p=pairs)
    output: vcf="mutect2_out/merged_somatic.vcf",
#            summary="mutect2_out/somatic_variants"
    params: regions=config['references'][pfamily]['REFFLAT'],gres="lscratch:100",gatk=config['bin'][pfamily]['GATK'],genome=config['references'][pfamily]['GENOME'],snpsites=config['references'][pfamily]['SNPSITES'],rname="CombineVariants"
    run:
        fl=os.popen("ls mutect2_out/*.FINAL.vcf").read().split()
        var=" --variant "+" --variant ".join(fl)
        cmd="{params.gatk} -T CombineVariants -R {params.genome} -L {paras.regions} --filteredrecordsmergetype KEEP_UNCONDITIONAL -o {output.vcf}"+var
        system(cmd)
#        cmd="module load picard/2.1.1; java -Xmx24g -jar $PICARDJARPATH/picard.jar CollectVariantCallingMetrics INPUT={output.vcf} OUTPUT={output.summary}"
#        system(cmd)