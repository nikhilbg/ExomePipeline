rule all_exomeseq_somatic:
    input:  expand("{s}"+".realign.bam",s=samples),
            expand("{x}"+".paired.vcf",x=pairs),
            "merged_somatic.vcf",
            "merged_somatic_snpEff.vcf",
            "variants.bed",
            "full_annot.txt.zip",
            "sample_network.bmp"
    output:
