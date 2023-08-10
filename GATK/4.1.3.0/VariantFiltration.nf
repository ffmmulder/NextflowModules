process VariantFiltration {
    tag {"GATK VariantFiltration ${run_id}.${interval}.${type}"}
    label 'GATK_4_1_3_0'
    label 'GATK_4_1_3_0_VariantFiltration'
    clusterOptions = workflow.profile == "sge" ? "-l h_vmem=${params.mem}" : ""
    container = 'library://sawibo/default/bioinf-tools:gatk4.1.3.0'
    shell = ['/bin/bash', '-euo', 'pipefail']
    input:
        tuple (run_id, interval, type, path(vcf), path(vcftbi))

    output:
        tuple (run_id, interval, type, path("${run_id}.${interval}.${type}.filtered_variants.vcf.gz"), path("${run_id}.${interval}.${type}.filtered_variants.vcf.gz.tbi"), emit: filtered_vcfs)

    script:
        if (type == 'SNP'){
          filter_criteria = params.gatk_snp_filter
        } else if (type == 'RNA') {
           filter_criteria = params.gatk_rna_filter
        } else {
           filter_criteria = params.gatk_indel_filter
        }
        """
        gatk --java-options "-Xmx${task.memory.toGiga()-4}g -Djava.io.tmpdir=\$TMPDIR" \
        VariantFiltration \
        ${params.optional} \
        -R $params.genome_fasta \
        -V $vcf \
        -O ${run_id}.${interval}.${type}.filtered_variants.vcf.gz \
        $filter_criteria
        """
}
