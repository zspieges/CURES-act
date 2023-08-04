with act_full as (SELECT distinct
PA_Mrn as mrn,
CAST(PA_TIMESTAMP AS DATE) as date,
CASE 
	when datepart(dy,PA_TIMESTAMP)-95 > 0 then datepart(dy,PA_TIMESTAMP)-95
	when datepart(dy,PA_TIMESTAMP)-95 < 0 then datepart(dy,PA_TIMESTAMP)+270
END as doy
from dbo.portalaudit paudit (NOLOCK)
where paudit.PA_WorkStationInfo not in ('CIS_Refresh','Ecosystem_PasswordReset','Ecosystem_MyMSKUserPassword','','system','EcosystemSync')
and paudit.PA_PatId is not null
and paudit.RequestStatus = 'Success'
and CAST(PA_TIMESTAMP AS DATE) between '2022-04-06' and '2023-04-06'
union 
(select distinct 
pt_mrn as mrn,
cast(Msg_CreatedDate as date) as date,
CASE 
	when datepart(dy,Msg_CreatedDate)-95 > 0 then datepart(dy,Msg_CreatedDate)-95
	when datepart(dy,Msg_CreatedDate)-95 < 0 then datepart(dy,Msg_CreatedDate)+270
END as doy
from PortalProd.dbo.Messages mes (NOLOCK)
LEFT JOIN PortalProd.dbo.Mailboxes b (NOLOCK)
ON (mes.Msg_ToUID = b.MBX_UID or (Msg_ToUID  like 'Z%' and mes.Msg_FromUID = b.MBX_UID ))
left join PortalProd.dbo.Patients p on mes.Msg_FromUID = p.PT_PATID 
where Msg_FromUID like 'Z%'
and Msg_CreatedDate between '2022-04-06' and '2023-04-06')),

act_agg as (select mrn,
date,
doy,
CASE
when doy between 1 and 7 then 'w1'
when doy between 8 and 14 then 'w2'
when doy between 15 and 21 then 'w3'
when doy between 22 and 28 then 'w4'
when doy between 29 and 35 then 'w5'
when doy between 36 and 42 then 'w6'
when doy between 43 and 49 then 'w7'
when doy between 50 and 56 then 'w8'
when doy between 57 and 63 then 'w9'
when doy between 64 and 70 then 'w10'
when doy between 71 and 77 then 'w11'
when doy between 78 and 84 then 'w12'
when doy between 85 and 91 then 'w13'
when doy between 92 and 98 then 'w14'
when doy between 99 and 105 then 'w15'
when doy between 106 and 112 then 'w16'
when doy between 113 and 119 then 'w17'
when doy between 120 and 126 then 'w18'
when doy between 127 and 133 then 'w19'
when doy between 134 and 140 then 'w20'
when doy between 141 and 147 then 'w21'
when doy between 148 and 154 then 'w22'
when doy between 155 and 161 then 'w23'
when doy between 162 and 168 then 'w24'
when doy between 169 and 175 then 'w25'
when doy between 176 and 182 then 'w26'
when doy between 183 and 189 then 'w27'
when doy between 190 and 196 then 'w28'
when doy between 197 and 203 then 'w29'
when doy between 204 and 210 then 'w30'
when doy between 211 and 217 then 'w31'
when doy between 218 and 224 then 'w32'
when doy between 225 and 231 then 'w33'
when doy between 232 and 238 then 'w34'
when doy between 239 and 245 then 'w35'
when doy between 246 and 252 then 'w36'
when doy between 253 and 259 then 'w37'
when doy between 260 and 266 then 'w38'
when doy between 267 and 273 then 'w39'
when doy between 274 and 280 then 'w40'
when doy between 281 and 287 then 'w41'
when doy between 288 and 294 then 'w42'
when doy between 295 and 301 then 'w43'
when doy between 302 and 308 then 'w44'
when doy between 309 and 315 then 'w45'
when doy between 316 and 322 then 'w46'
when doy between 323 and 329 then 'w47'
when doy between 330 and 336 then 'w48'
when doy between 337 and 343 then 'w49'
when doy between 344 and 350 then 'w50'
when doy between 351 and 357 then 'w51'
when doy between 358 and 365 then 'w52'
else 'w52'
END AS week
from act_full)

select mrn,
week,
case 
	when count(distinct date) > 0 then 'Y'
end as ActiveUserFlag,
count(distinct date) as NumLoginDays
FROM act_agg
where mrn is not null
group by week, mrn
order by mrn, week