process Index {
    tag {"Igvtools Index ${vcf}"}
    label 'Igvtools_2_14_1'
    label 'Igvtools_2_14_1_Index'
    container = 'quay.io/biocontainers/igvtools:2.14.1--hdfd78af_0'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
        path(vcf)

    output:
        path("${vcf}.idx", emit: vcf_idx)

    script:
        """
        tabix -p vcf ${vcf}
        """
}
