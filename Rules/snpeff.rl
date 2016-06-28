rule snpeff:
	input: "exome.recode.vcf"
        output: "all.snp.snpeff.vcf","all.indel.snpeff.vcf","stats_summary.snp.html","stats_summary.indel.html","all.snp.first.vcf","all.indel.first.vcf","all.snp.filter.vcf","all.indel.filter.vcf"
        params: snpeff=config['bin']['SNPEFF'],genome=config['references']['SNPEFF_GENOME'],snpsift=config['bin']['SNPSIFT'],effconfig=config['references']['SNPEFF_CONFIG'],firstanno=config['bin']['FIRSTANNO'],filtersift=config['references']['FILTERSIFT'],hapmap=config['references']['HAPMAP_DBNSFP'],rname="pl:snpeff"
        run: "module load snpEff; {params.snpeff} -v {params.genome} -c {params.effconfig} -stats snpeff.stats.html {input} > combined.snpeff.vcf"

