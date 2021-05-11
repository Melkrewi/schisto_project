###############################################
# Strata Identification #
###############################################
 
### De novo determination of Z-specific regions in S. mansoni 

1.bowtie2_mansoni.sh script needs as inputs: male and female DNA reads + fasta file of the reference genome

2.soapcov_mansoni.sh script needs as inputs: sam outputs of script 1 + fasta file of the reference genome

* InputFile1_Smansoni_SoapCov_By10kb_ForR_NewG.csv (i.e. modified output from script2) is used as input for the STEP1 of the R script titled 3.Zregions_Smansoni.R

* InputFile2_Zonly_10kb.txt is the output of STEP1, and is used as input for the STEP2 of the R script titled 3.Zregions_Smansoni.R

* InputFile3_windows-to-exclude.csv is used as input for the script titled 4.GeneSelector.pl    

* InputFile4_mansoni-gene-coordinates.csv is used as input for the script titled 4.GeneSelector.pl 

### Inference of the location of  S. japonicum scaffolds along the S. mansoni Z-chromosome

5.blat.sh script needs as inputs: the CDS of S. mansoni as fasta file + the genome of S. japonicum as fasta file

6.besthitblat.pl script needs as inputs: the output of script 5, sorted by scaffold name (column 10)

7.blatreverse.pl script needs as inputs: the output of script 6, sorted by target name (column 14)

8.Figure1.R script needs as inputs: InputFile5_Smansoni_SoapCov_By10kb_ForR_NewG_onlyZW.csv + InputFile6_Sjaponicum_coverage_FST.csv + supplementary dataset 4 (ZW_pairs_dNdS_with_strata_assignments.xlsx) + supplementary dataset 6 (MEANfst_per_scaffold_Sjap.txt)