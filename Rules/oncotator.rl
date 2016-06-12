rule oncotator:
    input: vcf=lambda wildcards: config['project']['pairs'][wildcards.x][0]+"_"+lambda wildcards: config['project']['pairs'][wildcards.x][1]+".vcf",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam"
    output: maf="{x}.maf",
    params: tumor=lambda wildcards: config['project']['pairs'][wildcards.x][0],normal=tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1],rname="pl:oncotator"
    shell: "module load oncotator; oncotator -v -o TCGAMAF -i VCF -c $ONCOTATOR_DATASOURCE/tx_exact_uniprot_matches.txt -a Tumor_Sample_Barcode:{params.tumor} -a Matched_Norm_Sample_Barcode:{params.normal} --skip-no-alt --db-dir /fdb/oncotator/oncotator_v1_ds_Jan262015 {output.maf} hg19"