rule all_exomeseq_germline:
    input:  "combined.gvcf",
            expand("all.{type}.dbnsfp.vcf", type=["snp","indel"]),
            "full_annot.txt.zip"
    output: 
