rule cnvkit_somatic:
    input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".realign.bam",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam"
    output: dir=lambda wildcards: config['project']['pairs'][wildcards.x][1]+"_"+lambda wildcards: config['project']['pairs'][wildcards.x][0],
            ref=lambda wildcards: config['project']['pairs'][wildcards.x][1]+"_"+lambda wildcards: config['project']['pairs'][wildcards.x][0]+".cnn"
    params: targets=config['references']['CNVKIT_TARGETS'],genome=config['references']['GENOME'],rname="pl:cnvkit_somatic"
    shell: "mkdir cnvkit/{output.dir}; module load cnvkit; cnvkit.py batch {input.tumor} -n {input.normal} -c --split --fasta {params.genome} --targets {params.targets} --output-reference cnvkit/{output.dir}/ --output-dir cnvkit/{output.dir}/ --diagram; cnvkit.py scatter cnvkit/{output.dir}/{input.tumor}.cnr -s cnvkit/{output.dir}/{input.tumor}.cns -o cnvkit/{output.dir}/{input.tumor}.scatter"