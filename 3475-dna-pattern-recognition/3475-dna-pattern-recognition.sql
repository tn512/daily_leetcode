-- 3475. DNA Pattern Recognition 

-- Main Solution
SELECT sample_id, dna_sequence, species,
       CASE WHEN dna_sequence LIKE 'ATG%' THEN 1 ELSE 0 END AS has_start,
       CASE WHEN REGEXP_LIKE(dna_sequence, '(TAA|TAG|TGA)$') THEN 1 ELSE 0 END AS has_stop,
       CASE WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 END AS has_atat,
       CASE WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0 END AS has_ggg
FROM Samples;

-- Alternative Solution
SELECT sample_id, dna_sequence, species,
       CASE WHEN REGEXP_LIKE(dna_sequence, '^ATG') THEN 1 ELSE 0 END AS has_start,
       CASE WHEN REGEXP_LIKE(dna_sequence, '(TAA|TAG|TGA)$') THEN 1 ELSE 0 END AS has_stop,
       CASE WHEN REGEXP_LIKE(dna_sequence, 'ATAT') THEN 1 ELSE 0 END AS has_atat,
       CASE WHEN REGEXP_LIKE(dna_sequence, 'GGG') THEN 1 ELSE 0 END AS has_ggg
FROM Samples;
