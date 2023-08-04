WITH activept_full AS (SELECT DISTINCT VIS_MRN AS mrn, 
CAST(VIS_ADM_DTE AS DATE) as date
FROM idb.VISIT_V vv
where CAST(VIS_ADM_DTE AS DATE) between '2022-02-06' and '2023-04-06'),

activept AS (SELECT mrn,
date,
CASE
when (date between '2022-02-06' and '2022-04-12') then 'w1'
when (date between '2022-02-13' and '2022-04-19') then 'w2'
when (date between '2022-02-20' and '2022-04-26') then 'w3'
when (date between '2022-02-27' and '2022-05-03') then 'w4'
when (date between '2022-03-06' and '2022-05-10') then 'w5'
when (date between '2022-03-13' and '2022-05-17') then 'w6'
when (date between '2022-03-20' and '2022-05-24') then 'w7'
when (date between '2022-03-27' and '2022-05-31') then 'w8'
when (date between '2022-04-03' and '2022-06-07') then 'w9'
when (date between '2022-04-10' and '2022-06-14') then 'w10'
when (date between '2022-04-17' and '2022-06-21') then 'w11'
when (date between '2022-04-24' and '2022-06-28') then 'w12'
when (date between '2022-05-01' and '2022-07-05') then 'w13'
when (date between '2022-05-08' and '2022-07-12') then 'w14'
when (date between '2022-05-15' and '2022-07-19') then 'w15'
when (date between '2022-05-22' and '2022-07-26') then 'w16'
when (date between '2022-05-29' and '2022-08-02') then 'w17'
when (date between '2022-06-05' and '2022-08-09') then 'w18'
when (date between '2022-06-12' and '2022-08-16') then 'w19'
when (date between '2022-06-19' and '2022-08-23') then 'w20'
when (date between '2022-06-26' and '2022-08-30') then 'w21'
when (date between '2022-07-03' and '2022-09-06') then 'w22'
when (date between '2022-07-10' and '2022-09-13') then 'w23'
when (date between '2022-07-17' and '2022-09-20') then 'w24'
when (date between '2022-07-24' and '2022-09-27') then 'w25'
when (date between '2022-07-31' and '2022-10-04') then 'w26'
when (date between '2022-08-07' and '2022-10-11') then 'w27'
when (date between '2022-08-14' and '2022-10-18') then 'w28'
when (date between '2022-08-21' and '2022-10-25') then 'w29'
when (date between '2022-08-28' and '2022-11-01') then 'w30'
when (date between '2022-09-04' and '2022-11-08') then 'w31'
when (date between '2022-09-11' and '2022-11-15') then 'w32'
when (date between '2022-09-18' and '2022-11-22') then 'w33'
when (date between '2022-09-25' and '2022-11-29') then 'w34'
when (date between '2022-10-02' and '2022-12-06') then 'w35'
when (date between '2022-10-09' and '2022-12-13') then 'w36'
when (date between '2022-10-16' and '2022-12-20') then 'w37'
when (date between '2022-10-23' and '2022-12-27') then 'w38'
when (date between '2022-10-30' and '2023-01-03') then 'w39'
when (date between '2022-11-06' and '2023-01-10') then 'w40'
when (date between '2022-11-13' and '2023-01-17') then 'w41'
when (date between '2022-11-20' and '2023-01-24') then 'w42'
when (date between '2022-11-27' and '2023-01-31') then 'w43'
when (date between '2022-12-04' and '2023-02-07') then 'w44'
when (date between '2022-12-11' and '2023-02-14') then 'w45'
when (date between '2022-12-18' and '2023-02-21') then 'w46'
when (date between '2022-12-25' and '2023-02-28') then 'w47'
when (date between '2023-01-01' and '2023-03-07') then 'w48'
when (date between '2023-01-08' and '2023-03-14') then 'w49'
when (date between '2023-01-15' and '2023-03-21') then 'w50'
when (date between '2023-01-22' and '2023-03-28') then 'w51'
when (date between '2023-01-29' and '2023-04-05') then 'w52'
ELSE 'w52'
END AS week
FROM activept_full),

pts AS (SELECT mrn, week,
count(DISTINCT date) AS numencdays
FROM activept
GROUP BY mrn, week)

SELECT trim(mrn) AS mrn, 
week,
CASE 
	WHEN numencdays > 0 THEN 'Y'
END AS ActivePatientFlag
FROM pts