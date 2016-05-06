rule all_exomeseq_somatic:
    input:  expand("{s}"+".realign.bam",s=samples),
            expand("{s}"+".vcf",s=pairs),
            expand("{s}.stats.out",s=pairs),
            "sample_network.bmp"
    output:
