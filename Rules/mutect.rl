rule mutect:
       input:  normal=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam",
               tumor=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".realign.bam"
       output: vcf="mutect_out/{x}.vcf",
               stats="mutect_out/{x}.stats.out",
               wig="mutect_out/{x}.wig.txt",
               vcfFilter="mutect_out/{x}.PASS.vcf",
               vcfRename="mutect_out/{x}.FINAL.vcf",
               names="mutect_out/{x}.samples"               
       params: normalsample=lambda wildcards: config['project']['pairs'][wildcards.x][0],tumorsample=lambda wildcards: config['project']['pairs'][wildcards.x][1],mutect=config['bin'][pfamily]['MUTECT'],gatk=config['bin'][pfamily]['GATK'],genome=config['references'][pfamily]['MUTECTGENOME'],cosmic=config['references'][pfamily]['MUTECTCOSMIC'],snp=config['references'][pfamily]['MUTECTSNP'],rname="pl:mutect"
       shell:  "{params.mutect} --analysis_type MuTect --reference_sequence {params.genome} --vcf {output.vcf} --cosmic {params.cosmic} {params.snp} --input_file:normal {input.normal} --input_file:tumor {input.tumor} --out {output.stats} -rf BadCigar; {params.gatk} -T SelectVariants -R {params.genome} --variant {output.vcf} --excludeFiltered -o {output.vcfFilter}; gzip {output.vcfFilter}; echo $'{params.normalsample}\n{params.tumorsample}' > {output.names} ; module load samtools; bcftools reheader -o {output.vcfRename} -s {output.names}  {output.vcfFilter}.gz; gunzip {output.vcfFilter}.gz"