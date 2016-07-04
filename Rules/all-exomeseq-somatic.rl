rule all_exomeseq_somatic:
    input:  expand("{s}"+".realign.bam",s=samples),
            expand("mutect2/{p}"+".FINAL.vcf",p=pairs),
            expand("strelka/{p}"+".vcf",p=pairs),
            expand("mutect2/oncotator/{p}"+".maf",p=pairs),
            expand("strelka/oncotator/{p}"+".maf",p=pairs),
            "strelka",
            "mutect2",
            "cnvkit",
            "germline_snps.vcf",
#            "cnvkit/somatic_cnvkit.heatmap",
#            expand("cnvkit/{p}"[1]+".cnr",
#            expand("cnvkit/{p}"[1]+".cns",
            "mutect2/merged_somatic.vcf",
            "mutect2/merged_somatic_snpEff.vcf",
#            "mutect2/somatic_variants",
            "variants.bed",
            "full_annot.txt.zip",
            "sample_network.bmp"
#            "variants.database",
#            "mutect2/oncotator/somatic_variants.maf",
#            "mutect2/mutsigCV/somatic.sig_genes.txt"
#            "strelka/oncotator/somatic_variants.maf",
#            "strelka/mutsigCV/somatic.sig_genes.txt"            
    output:
