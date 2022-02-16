process Faidx {
    tag {"Samtools Faidx ${fasta} ${chr_set} ${fasta_out}"}
    label 'Samtools_1_10'
    label 'Samtools_1_10_Faidx'
    container = 'quay.io/biocontainers/samtools:1.10--h9402c20_2'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
        path(fasta)
        file(fasta_out)
        val(chr_set)


    output:
        path("${fasta.name}.fai", emit: genome_faidx)

    script:
        """
        if [[ "${chr_set}" == "" ]]; then
            samtools faidx ${fasta}
        else
            samtools faidx ${fasta} ${chr_set} > ${fasta_out}
        fi
        """
}
