rule gatk_mutect2:
    input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".realign.bam",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam",
           normalsample=lambda wildcards: config['project']['pairs'][wildcards.x][0],
           tumorsample=lambda wildcards: config['project']['pairs'][wildcards.x][1]
    output: vcf="{x}.paired.vcf",
            vcfFilter="{x}.PASS.vcf",
            vcfRename="{x}.FINAL.vcf",
            names="{x}.samples"
    params: gatk=config['bin']['GATK'],genome=config['references']['GENOME'],cosmic=config['references']['MUTECTCOSMIC'],snpsites=config['references']['SNPSITES'],rname="pl:mutect2"
    threads: 4
    shell: "{params.gatk} -T MuTect2 -R {params.genome} -I:tumor {input.tumor} -I:normal {input.normal} --read_filter BadCigar --dbsnp {params.snpsites} -nct {threads} -o mutect2/{output.vcf}; {params.gatk} -T SelectVariants -R {params.genome} --variant mutect2/{output.vcf} --excludeFiltered -o mutect2/{output.vcfFilter}; gzip mutect2/{output.vcfFilter}; echo $'{input.normalsample}\n{input.tumorsample}' > mutect2/{output.names} ; module load samtools; bcftools reheader -o mutect2/{output.vcfRename} -s mutect2/{output.names}  mutect2/{output.vcfFilter}.gz"