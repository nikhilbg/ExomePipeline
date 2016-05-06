rule make_somatic_network:
    input: "germline.vcf"
    output:"sample_network.bmp"
    params: batch ="-l nodes=1:gpfs -q ccr",rname="make.somatic.network"
    shell: """
         perl Scripts/make_sample_network.pl {input}

           """

