process FastQC {
    tag {"FastQC ${sample_id} - ${rg_id}"}
    label 'FASTQC'
    label 'FastQC_0_11_5'
    clusterOptions = workflow.profile == "sge" ? "-l h_vmem=${params.mem}" : ""
    container = 'library://sawibo/default/bioinf-tools:fastqc-0.11.5'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
<<<<<<< HEAD
        tuple (val(sample_id), val(rg_id), path(fastq) )
=======
        tuple(val(sample_id), val(rg_id), path(fastq))
>>>>>>> 9fb570cf6539dfb67916a5d3a940e8cd2d8118b4

    output:
        path("*_fastqc.{zip,html}", emit: fastqc_reports)

    script:
        """
        fastqc ${params.optional} -t ${task.cpus} $fastq
        """
}
