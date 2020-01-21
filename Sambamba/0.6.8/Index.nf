process Index {
  tag {"SAMBAMBA_index ${sample_id}"}
  label 'SAMBAMBA_index_0_6_8'
  clusterOptions = workflow.profile == "sge" ? "-l h_vmem=${params.index_mem}" : ""
  container = "/hpc/cog_bioinf/ubec/tools/rnaseq_containers/sambamba_0.6.8-squashfs-pack.gz.squashfs"
  shell = ['/bin/bash', '-euo', 'pipefail']

  input:
    tuple sample_id, file(bam_input)

  output:
    tuple sample_id, file("${bam_input}.bai")

  script:
  """
  sambamba index -t ${task.cpus} $bam_input ${bam_input}.bai
  """
}



