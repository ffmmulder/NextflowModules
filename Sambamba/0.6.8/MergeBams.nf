process MergeBams {
  tag {"Sambamba MergeBams ${sample_id}"}
  label 'Sambamba_0_6_8_MergeBams'
  clusterOptions = workflow.profile == "sge" ? "-l h_vmem=${params.mem}" : ""
  container = 'library://sawibo/default/bioinf-tools:sambamba-0.6.8'
  shell = ['/bin/bash', '-euo', 'pipefail']
  input:
<<<<<<< HEAD
    tuple (val(sample_id), path(bams), path(bais))

  output:
    tuple (val(sample_id), path("${sample_id}_${ext}"), path("${sample_id}_${ext}.bai"), emit: merged_bams)
=======
    tuple(val(sample_id), path(bams), path(bais))

  output:
    tuple(val(sample_id), path("${sample_id}_${ext}"), path("${sample_id}_${ext}.bai"), emit: merged_bams)
>>>>>>> 9fb570cf6539dfb67916a5d3a940e8cd2d8118b4

  script:
    ext = bams[0].toRealPath().toString().split("_")[-1]

    """
    sambamba merge -t ${task.cpus} ${sample_id}_${ext} ${bams}
    sambamba index -t ${task.cpus} ${sample_id}_${ext} ${sample_id}_${ext}.bai
    """
}
