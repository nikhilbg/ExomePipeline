rule avia_make_bed_germ:
    input: "combined.vcf"
    output: bed="variants.bed",
            vcf="exome.recode.vcf",
            summary="exonic_variants"
    params: regions=config['references']['REFFLAT'],batch ="-l nodes=1:gpfs -q ccr",rname="make_bed"
    shell: """
         module load vcftools; vcftools --vcf combined.vcf --bed {params.regions} --recode --recode-INFO-all --out exome; perl Scripts/avia_make_bed.pl exome.recode.vcf; java -Xmx48g -jar $PICARDJARPATH/picard.jar CollectVariantCallingMetrics INPUT={output.vcf} OUTPUT={output.summary}

           """

