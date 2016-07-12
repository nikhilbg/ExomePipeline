rule multiqc:
    input: expand("QC/{s}.qualimapReport",s=samples)
    output: "multiqc_report.html"
    params: fastqc=config['bin'][pfamily]['FASTQC'],adapters=config['references'][pfamily]['fastqc.adapters'],rname="pl:multiqc"
    threads: 1
    shell:  "module load multiqc; multiqc -f -e featureCounts ."


