process LCExtrap {
    tag {"Preseq LCExtrap ${sample_id} "}
    label 'Preseq_2_0_3'
    label 'Preseq_2_0_3_LCExtrap'
    container = "quay.io/biocontainers/preseq:2.0.3--hf53bd2b_3"
    shell = ['/bin/bash', '-euo', 'pipefail']

<<<<<<< HEAD
    input:
        tuple(val(sample_id), path(bam_file), path(bai_file))

    output:
        tuple(val(sample_id), path("${bam_file.baseName}.ccurve.txt") , emit: ccurve_table)
=======
      input:
          tuple(val(sample_id), path(bam_file), path(bai_file))

      output:
          tuple(val(sample_id), path("${bam_file.baseName}.ccurve.txt") , emit: ccurve_table)

      script:
          //Adapted code from: https://github.com/nf-core/rnaseq - MIT License - Copyright (c) Phil Ewels, Rickard Hammarén
          """
          preseq lc_extrap ${params.optional} ${bam_file} -o ${bam_file.baseName}.ccurve.txt
          """
  }
>>>>>>> 9fb570cf6539dfb67916a5d3a940e8cd2d8118b4

    script:
        //Adapted code from: https://github.com/nf-core/rnaseq - MIT License - Copyright (c) Phil Ewels, Rickard Hammarén
        """
        preseq lc_extrap ${params.optional} ${bam_file} -o ${bam_file.baseName}.ccurve.txt
        """
}
