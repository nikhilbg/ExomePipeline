rule multiqc:
    input:  "QC/{x}.qualimapReport"
    output: "multiqc_report.html"
    params: fastqc=config['bin']['FASTQC'],adapters=config['references']['fastqc.adapters'],rname="pl:multiqc"
    threads: 1
    shell:  "multiqc ."


