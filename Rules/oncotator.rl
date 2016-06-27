rule oncotator:
    input: vcf=lambda wildcards: config['project']['pairs'][wildcards.x][0]+"_"+lambda wildcards: config['project']['pairs'][wildcards.x][1]+".FINAL.vcf",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1],
           normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]
    output: maf=lambda wildcards: config['project']['pairs'][wildcards.x][1]+"_"+lambda wildcards: config['project']['pairs'][wildcards.x][0]+".maf",
    params: rname="pl:oncotator"
    shell: "cd mutect2; module load oncotator; oncotator -v -o TCGAMAF -i VCF -c $ONCOTATOR_DATASOURCE/tx_exact_uniprot_matches.txt -a Tumor_Sample_Barcode:{params.tumor} -a Matched_Norm_Sample_Barcode:{params.normal} --skip-no-alt --db-dir /fdb/oncotator/oncotator_v1_ds_Jan262015 {input.vcf} oncotator/{output.maf} hg19"