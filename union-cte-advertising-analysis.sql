
-- Module 2 - Assignment 3
-- Combining Facebook and Google Ads using UNION ALL and CTE

WITH combined_ads AS (
    SELECT
        ad_date,
        'Facebook Ads' AS media_source,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM public.facebook_ads_basic_daily

    UNION ALL

    SELECT
        ad_date,
        'Google Ads' AS media_source,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM public.google_ads_basic_daily
)

SELECT
    ad_date,
    media_source,
    SUM(spend) AS total_spend,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(value) AS total_conversion_value
FROM combined_ads
GROUP BY
    ad_date,
    media_source
ORDER BY
    ad_date,
    media_source;
