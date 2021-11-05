process ExportParams {
    tag {"Workflow Export Params"}
    label 'Workflow_Export_Params'
    shell = ['/bin/bash', '-euo', 'pipefail']

    output:
        path("workflow_params.txt")

    script:
        def workflow_params = params.collect{param -> "$param.key\t$param.value"}.sort().join("\n")
        """
        echo -e "param\tvalue" > workflow_params.txt
        echo -e "${workflow_params}" >> workflow_params.txt
        """
}
