vcf_input_and_matrix_output_path="/folder/containing/vcf/files"  #folder containing input files and where output folders will be created
assignment_output_path_SBS="$vcf_input_and_matrix_output_path/SBS/"
assignment_output_path_ID="$vcf_input_and_matrix_output_path/ID/"
assignment_output_path_DBS="$vcf_input_and_matrix_output_path/DBS/"

singularity exec -B /path/to/bind /path/to/container.sif python3  << EOF

from SigProfilerAssignment import Analyzer as Analyze

Analyze.cosmic_fit(samples="$vcf_input_and_matrix_output_path",
                   output="$assignment_output_path_SBS",
                   input_type="vcf",
                   context_type= "96",
                   collapse_to_SBS96= True,
                   make_plots= True,
                   exclude_signature_subgroups=["Artifact_signatures"],
                   genome_build="GRCh38")

Analyze.cosmic_fit(samples="$vcf_input_and_matrix_output_path",
                   output="$assignment_output_path_ID",
                   input_type="vcf",
                   context_type= "ID",
                   collapse_to_SBS96= False,
                   make_plots= True,
                   exclude_signature_subgroups=["Artifact_signatures"],
                   genome_build="GRCh38")

Analyze.cosmic_fit(samples="$vcf_input_and_matrix_output_path",
                   output="$assignment_output_path_DBS",
                   input_type="vcf",
                   context_type= "DINUC",
                   collapse_to_SBS96= False,
                   make_plots= True,
                   exclude_signature_subgroups=["Artifact_signatures"],
                   genome_build="GRCh38")
EOF
