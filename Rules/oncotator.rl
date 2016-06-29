rule oncotator:
    input: vcf="{p}"+".filtered.vcf", p=pairs,
           normal="{p}[0]"+".realign.bam",
           tumor="{p}[1]"+".realign.bam"
    output: maf="{p}"+".maf"
    params: rname="pl:oncotator"
    shell: "module load oncotator; oncotator -v -o TCGAMAF -i VCF -c $ONCOTATOR_DATASOURCE/tx_exact_uniprot_matches.txt -a Tumor_Sample_Barcode:{input.tumor} -a Matched_Norm_Sample_Barcode:{input.normal} --skip-no-alt --db-dir /fdb/oncotator/oncotator_v1_ds_Jan262015 mutect2/{input.vcf} mutect2/oncotator/{output.maf} hg19"