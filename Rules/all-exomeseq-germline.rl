rule all_exomeseq_germline:
    input: "combined.vcf",
           "exome.recode.vcf",
           "full_annot.txt.zip",
           "variants.database",
           "sample_network.bmp",
           "snpeff.stats.html",
           "exome.snpeff.vcf"
    output: 
