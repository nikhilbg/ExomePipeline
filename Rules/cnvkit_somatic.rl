rule cnvkit_somatic:
    input: lambda wildcards: list(config['project']['pairs'].values())[wildcards.group]
    output: cnr="cnvkit_out/{group[1]}.cnr",
            cns="cnvkit_out/{group[1]}.cns",
#            heatmap="cnvkit_out/{tumor}.somatic_cnvkit.heatmap"
    params: targets=config['references'][pfamily]['CNVKIT_TARGETS'],genome=config['references'][pfamily]['GENOME'],rname="pl:cnvkit_somatic"
    shell: "module load cnvkit; cnvkit.py batch {group[1]}.realign.bam -n {group[0]}.realign.bam -c --split --fasta {params.genome} --targets {params.targets} --output-reference cnvkit/{group[0]}.reference.cnn --output-dir cnvkit/ --diagram; cnvkit.py heatmap cnvkit/*.cns -d -o somatic/cnvkit/{group[1]}.somatic.cnvkit.heatmap"
