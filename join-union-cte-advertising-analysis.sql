SELECT ad_date, campaign_id, adset_id, spend, impressions, reach, clicks, leads, value, url_parameters, total
FROM public.facebook_ads_basic_daily;

SELECT adset_id, adset_name
FROM public.facebook_adset;

SELECT campaign_id, campaign_name
FROM public.facebook_campaign;

SELECT ad_date, campaign_name, adset_name, spend, impressions, reach, clicks, leads, value, url_parameters
FROM public.google_ads_basic_daily;


---- facebook_ads_basic_daily --> f
---- facebook_adset --> a
---- facebook_campaign --> c
---- public.google_ads_basic_daily --> g


with facebook_combined as 
(
select f.ad_date, c.campaign_name, a.adset_name, f.spend, f.impressions, f.reach, f.clicks, f.leads, f.value, 'facebook ads' AS media_source 
from public.facebook_ads_basic_daily as f 
join public.facebook_adset as a on f.adset_id = a.adset_id
join public.facebook_campaign as c on f.campaign_id = c.campaign_id
),

google_combined as 
(
select g.ad_date, g.campaign_name, g.adset_name, g.spend, g.impressions, g.reach, g.clicks, g.leads, g.value,  'google ads' AS media_source
from public.google_ads_basic_daily as g
),

all_ads as
(
select *
from facebook_combined
union
select *
from google_combined
)

select ad_date, media_source, campaign_name, adset_name, sum(spend) as total_spend, sum(impressions) as total_impressions, sum(clicks) as total_clicks, sum(value) as total_conversion_value
from all_ads
group by ad_date, media_source, campaign_name, adset_name 
order by ad_date, media_source, campaign_name, adset_name;



---- EK GÖREV 

---- top_campaign --> tc
---- top_adset --> ta


with all_ads as
(
-- facebook verileri
select f.ad_date, c.campaign_name, a.adset_name, f.spend, f.value
from public.facebook_ads_basic_daily as f
join public.facebook_adset as a on f.adset_id = a.adset_id
join public.facebook_campaign as c on f.campaign_id = c.campaign_id

union

-- google verileri
select g.ad_date, g.campaign_name, g.adset_name, g.spend, g.value
from public.google_ads_basic_daily as g
),


-- ROMI ve 500.000 filtre aşaması
campaign_romi as 
(
select campaign_name, sum(spend) as total_spend, sum(value) as total_value, sum(value)/sum(spend) as romi
from all_ads 
group by campaign_name
having sum(spend) > 500000
),

-- en yüksek romi
top_campaign as 
(
select * 
from campaign_romi
order by romi desc
limit 1
),

-- O kampanyadaki en yüksek romi adset
top_adset as 
(
select adset_name, sum(spend) as total_spend, sum(value) as total_value, sum(value)/sum(spend) as romi
from all_ads
where campaign_name = (select campaign_name from top_campaign)
group by adset_name
order by romi desc
limit 1
)

--sonuç

select tc.campaign_name as top_campaign_name, tc.romi as top_campaign_romi, ta.adset_name as top_adset_name, ta.romi as top_adset_romi
from top_campaign as tc
join top_adset as ta on 1=1;


