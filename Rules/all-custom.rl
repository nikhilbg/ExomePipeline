ext='qualimapReport'
prefix='QC/'
rule all_custom:
    input:  expand("{p}{s}.{e}",e=ext,s=samples,p=prefix)
    output: 
