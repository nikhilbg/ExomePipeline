rule mutsig_strelka:
        input: maf=expand("strelka/oncotator/{x}.maf",x=pairs)
        output: "somatic.sig_genes.txt"
        params: rname="pl:mutsig_strelka"
        shell: "cd strelka/oncotator; cat *.maf > somatic_variants.maf; module load MutSig; MutSigCV somatic_variants.maf $MUTSIG_REF/exome_full192.coverage.txt $MUTSIG_REF/gene.covariates.txt ../mutsigCV/somatic $MUTSIG_REF/mutation_type_dictionary_file.txt $MUTSIG_REF/chr_files_hg19"