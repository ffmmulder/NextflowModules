process MergeVCFs {
    tag {"GATK MergeVCFs ${id}"}
    label 'GATK_4_3_0_0'
    label 'GATK_4_3_0_0_MergeVCFs'
    clusterOptions = workflow.profile == "sge" ? "-l h_vmem=${params.mem}" : ""
    container = 'broadinstitute/gatk:4.3.0.0'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
        tuple (val(id), path(vcf_chunks), path(vcfidxs))

    output:
        tuple (val(id), path("${id}${ext_g}.${ext_vcf}"), path("${id}${ext_g}.${ext_index}"), emit: merged_vcfs)

    script:
//        print "VCF chunks: "+vcf_chunks
        ext_g = vcf_chunks[0] =~ /\.g\.vcf/ ? '.g' : ''
        vcfs = vcf_chunks.join(' -INPUT ')
        ext_vcf = params.compress || vcf_chunks[0].getExtension() == ".gz" ? "vcf.gz" : "vcf"
        ext_index = params.compress || vcf_chunks[0].getExtension() == ".gz" ? "vcf.gz.tbi" : "vcf.idx"
//        ext_vcf = params.compress || vcf_chunks[0] =~ /\.vcf\.gz/ ? "vcf.gz" : "vcf"
//        ext_index = params.compress || vcf_chunks[0] =~ /\.vcf\.gz/ ? "vcf.gz.tbi" : "vcf.idx"

        """
        gatk --java-options "-Xmx${task.memory.toGiga()-4}g -Djava.io.tmpdir=\$PWD" \
        SortVcf \
        --INPUT $vcfs \
        --OUTPUT ${id}${ext_g}.${ext_vcf}
        """
}
