rule mutsig:
        input: expand("mutect2/oncotator/{p}.maf",p=pairs)
        output: "somatic.sig_genes.txt"
        params: rname="pl:mutsig"
        shell: "cat mutect2/oncotator/*.maf > mutect2/oncotator/somatic_variants.maf; module load MutSig; MutSigCV mutect2/oncotator/somatic_variants.maf $MUTSIG_REF/exome_full192.coverage.txt $MUTSIG_REF/gene.covariates.txt mutect2/mutsigCV/somatic $MUTSIG_REF/mutation_type_dictionary_file.txt $MUTSIG_REF/chr_files_hg19"