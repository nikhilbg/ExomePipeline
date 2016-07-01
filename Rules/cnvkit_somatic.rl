rule cnvkit_somatic:
    input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".realign.bam",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam"
    output: cnr="cnvkit/{input.tumor}.cnr",
            cns="cnvkit/{input.tumor}.cns",
#            heatmap="cnvkit/somatic_cnvkit.heatmap"
    params: targets=config['references']['CNVKIT_TARGETS'],genome=config['references']['GENOME'],rname="pl:cnvkit_somatic"
    shell: "module load cnvkit; cnvkit.py batch {input.tumor} -n {input.normal} -c --split --fasta {params.genome} --targets {params.targets} --output-reference cnvkit/{input.normal}.reference.cnn --output-dir cnvkit/ --diagram; cnvkit.py heatmap cnvkit/*.cns -d -o cnvkit/somatic_cnvkit.heatmap"