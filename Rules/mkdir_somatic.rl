rule mkdir_somatic:
        input:  expand("{s}.dedup.bam", s=samples)
        output: mutect2="mutect2",
                mutect="mutect",
                cnvkit="cnvkit",
                strelka="strelka",
                delly="delly"
        params: rname="pl:mkdir"
        shell:  "mkdir strelka cnvkit delly mutect2 mutect mutect/oncotator mutect/mutsigCV strelka/oncotator strelka/mutsigCV mutect2/oncotator mutect2/mutsigCV"