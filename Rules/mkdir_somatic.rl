rule gatk_realign2:
        input:  
        output: mutect2="mutect2",
                cnvkit="cnvkit",
                strelka="strelka"
        params: rname="pl:mkdir"
        shell:  "mkdir {output.mutect2}; mkdir {output.strelka}; mkdir {output.cnvkit}; mkdir strelka/oncotator; mkdir strelka/mutsigCV; mkdir mutect2/oncotator; mkdir mutect2/mutsigCV"
