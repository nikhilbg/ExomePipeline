rule database_germline:
    input: vcf="mutect2/merged_somatic.vcf",
           annotation="full_annot.txt.zip"
    output: dbase="variants.database",
            vcf="exome_genotypes.vcf"
    params: regions=config['references']['REFFLAT'],tumor=lambda wildcards: config['project']['pairs'][wildcards.x][0],normal=tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1],rname="pl:database"
    shell: "unzip -p full_annot.txt.zip > full_annot.txt; gzip exome.recode.vcf; module load samtools; bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%GT]\n' exome.recode.vcf.gz > exome_genotypes.vcf; perl Scripts/make_database.pl"