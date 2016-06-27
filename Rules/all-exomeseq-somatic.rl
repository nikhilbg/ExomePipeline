rule all_exomeseq_somatic:
    input:  expand("{s}"+".realign.bam",s=samples),
            "mutect2/"+expand("{x}"+".FINAL.vcf",x=pairs),
            "strelka/"+expand("{x}"+".vcf",x=pairs),            
            "mutect2/oncotator/"+expand("{x}"+".maf",x=pairs),
            "strelka/oncotator/"+expand("{x}"+".maf",x=pairs),
            "mutect2/merged_somatic.vcf",
            "merged_somatic_snpEff.vcf",
            "variants.bed",
            "full_annot.txt.zip",
            "sample_network.bmp",
            "variants.database",
            "mutect2/oncotator/somatic_variants.maf",
            "mutect2/mutsigCV/somatic.sig_genes.txt"
            "strelka/oncotator/somatic_variants.maf",
            "strelka/mutsigCV/somatic.sig_genes.txt"            
    output:
