rule oncotator_strelka:
    input: vcf="strelka/{x}.vcf", x=pairs,
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1],
           normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]    
    output: maf="strelka/oncotator/{x}.maf"
    params: rname="pl:oncotator_strelka"
    shell: "module load oncotator; oncotator -v -o TCGAMAF -i VCF -c $ONCOTATOR_DATASOURCE/tx_exact_uniprot_matches.txt -a Tumor_Sample_Barcode:{params.tumor} -a Matched_Norm_Sample_Barcode:{params.normal} --skip-no-alt --db-dir /fdb/oncotator/oncotator_v1_ds_Jan262015 {input.vcf} {output.maf} hg19"