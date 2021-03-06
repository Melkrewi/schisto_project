#Pooling the different life stages together
cat SRR3223434_trimmed.fq SRR3223443_trimmed.fq SRR3223447_trimmed.fq > csi_1.fq
cat SRR3223435_trimmed.fq SRR3223444_trimmed.fq SRR3223448_trimmed.fq > csi_2.fq
cat ERR506083_forward_paired.fq.gz ERR506084_forward_paired.fq.gz > ERR50608_1.fq.gz
cat ERR506083_reverse_paired.fq.gz ERR506084_reverse_paired.fq.gz > ERR50608_2.fq.gz
cat ERR506083_forward_paired.fq.gz ERR506083_reverse_paired.fq.gz > ERR506083.fq.gz
gunzip ERR506083.fq.gz
cat ERR506083.fq csi_1.fq > csim_1.fq
cat ERR506084_forward_paired.fq.gz ERR506084_reverse_paired.fq.gz > ERR506084.fq.gz
gunzip ERR506084.fq.gz
cat ERR506084.fq csi_2.fq > csim_2.fq

#Running the Kmer pipeline
module load java
module load bbmap

kmer=31
echo "### Step 0: Kmer pipeline starting"
kmercountexact.sh k=$kmer in1=ERR562990_forward_paired.fq.gz in2=ERR562990_reverse_paired.fq.gz out=female_dna_mer_1.fa

kmercountexact.sh k=$kmer in=csim_1.fq out=sfemale_rna_mer_1.fa

kmercountexact.sh k=$kmer in=csim_2.fq out=sfemale_rna_mer_2.fa

kmercountexact.sh k=$kmer in=female_dna_mer_1.fa,sfemale_rna_mer_1.fa,sfemale_rna_mer_2.fa out=shared_female_mer.fa mincount=3

bbduk.sh k=$kmer in=shared_female_mer.fa out=female_specific_mers.fasta ref=ERR562989_forward_paired.fq.gz,ERR562989_reverse_paired.fq.gz -Xmx350g

bbduk.sh k=$kmer in=female_specific_mers.fasta out=v_female_specific_mers.fasta ref=ERR506088_forward_paired.fq.gz,ERR506088_reverse_paired.fq.gz,ERR506090_forward_paired.fq.gz,ERR506090_reverse_paired.fq.gz

bbduk.sh k=$kmer in=v_female_specific_mers.fasta out=v_v_female_specific_mers.fasta ref=SRR3211868_trimmed.fq,SRR3216389_trimmed.fq,SRR3223428_trimmed.fq,SRR3223429_trimmed.fq,SRR3223433_trimmed.fq,E1bis_E2bis_CTTGTA_L003_R1_concat_trimmed.fq

bbduk.sh k=$kmer in=csi_1.fq outm=female_specific_rna_reads_1.fastq ref=v_v_female_specific_mers.fasta minkmerfraction=0.4

bbduk.sh k=$kmer in=csi_2.fq outm=female_specific_rna_reads_2.fastq ref=v_v_female_specific_mers.fasta minkmerfraction=0.4

bbduk.sh k=$kmer in1=ERR50608_1.fq.gz in2=ERR50608_2.fq.gz outm1=mature_adult_specific_rna_reads_1.fastq outm2=mature_adult_specific_rna_reads_2.fastq ref=v_v_female_specific_mers.fasta minkmerfraction=0.4

#concatenate the female_specific_rna_read files
cat female_specific_rna_reads_1.fastq female_specific_rna_reads_2.fastq > female_specific_rna_reads.fastq
