rule all_exomeseq_germline:
    input:  "combined.vcf",
            expand("all.{type}.dbnsfp.vcf", type=["snp","indel"]),
            "full_annot.txt.zip",
            "variants.database",
            "exome.vcf"
    output: 
