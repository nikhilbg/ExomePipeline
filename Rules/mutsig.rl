rule mutsig:
        input: maf=lambda wildcards: config['project']['pairs'][wildcards.x][0]+"_"+lambda wildcards: config['project']['pairs'][wildcards.x][1]".maf"
        output: "somatic.sig_genes.txt"
        params: rname="pl:mutsig"
        shell: "cat *.maf > somatic_variants.maf; module load MutSig; MutSigCV somatic_variants.maf $MUTSIG_REF/exome_full192.coverage.txt $MUTSIG_REF/gene.covariates.txt somatic $MUTSIG_REF/mutation_type_dictionary_file.txt $MUTSIG_REF/chr_files_hg19"