
process SNPSiftDbnsfp {
    tag {"SNPEff SNPSiftDbnsfp ${run_id}"}
    label 'SNPEff_4_3t'
    label 'SNPEff_4_3t_SNPSiftDbnsfp'
    clusterOptions = workflow.profile == "sge" ? "-l h_vmem=${params.mem}" : ""
    container = 'library://sawibo/default/bioinf-tools:snpeff-4.3t'
    shell = ['/bin/bash', '-euo', 'pipefail']
    input:
<<<<<<< HEAD
        tuple (val(run_id), path(vcf), path(vcfidx))

    output:
        tuple (val(run_id), path("${vcf.baseName}_dbnsfp.vcf"), path("${vcf.baseName}_dbnsfp.vcf.idx"), emit : snpsift_dbnsfp_vcfs)
=======
        tuple(val(run_id), path(vcf), path(vcfidx))

    output:
        tuple(val(run_id), path("${vcf.baseName}_dbnsfp.vcf"), path("${vcf.baseName}_dbnsfp.vcf.idx"), emit : snpsift_dbnsfp_vcfs)
>>>>>>> 9fb570cf6539dfb67916a5d3a940e8cd2d8118b4

    script:
        """
        java -Xmx${task.memory.toGiga()-4}g -Djava.io.tmpdir=\$TMPDIR -jar /bin/SnpSift.jar dbnsfp -v \
        ${params.optional} \
        -db ${params.genome_dbnsfp} $vcf > ${vcf.baseName}_dbnsfp.vcf

        java -Xmx${task.memory.toGiga()-4}g -Djava.io.tmpdir=\$TMPDIR -jar /bin/igvtools.jar index ${vcf.baseName}_dbnsfp.vcf
        """
}
