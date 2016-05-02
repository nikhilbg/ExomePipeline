ext='all.snp.dbnsfp.vcf'
rule all_custom:
    input:  expand("{e}",e=ext)
    output: 
