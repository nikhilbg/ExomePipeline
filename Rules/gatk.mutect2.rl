rule gatk_mutect2:
    input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".realign.bam",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam"
    output: vcf="mutect2_out/{x}.paired.vcf",
            vcfFilter="mutect2_out/{x}.PASS.vcf",
            vcfRename="mutect2_out/{x}.FINAL.vcf",
            names="mutect2_out/{x}"+".samples"
    params: normalsample=lambda wildcards: config['project']['pairs'][wildcards.x][0],tumorsample=lambda wildcards: config['project']['pairs'][wildcards.x][1],gatk=config['bin'][pfamily]['GATK'],genome=config['references'][pfamily]['GENOME'],cosmic=config['references'][pfamily]['MUTECTCOSMIC'],snpsites=config['references'][pfamily]['SNPSITES'],targets=config['references'][pfamily]['REFFLAT'],rname="pl:mutect2"
    threads: 4
    shell: "{params.gatk} -T MuTect2 -R {params.genome} -I:tumor {input.tumor} -I:normal {input.normal} --read_filter BadCigar --dbsnp {params.snpsites} --cosmic {params.cosmic} -L {params.targets} -nct {threads} -o {output.vcf}; {params.gatk} -T SelectVariants -R {params.genome} --variant {output.vcf} --excludeFiltered -o {output.vcfFilter}; gzip {output.vcfFilter}; echo $'{params.normalsample}\n{params.tumorsample}' > {output.names} ; module load samtools; bcftools reheader -o {output.vcfRename} -s {output.names}  {output.vcfFilter}.gz; gunzip {output.vcfFilter}.gz"