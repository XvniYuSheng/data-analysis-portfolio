-- ============================================================
-- 项目二：App 市场增长与 A/B 测试分析
-- 模块：02_growth_metrics.sql  增长核心指标分析
-- ============================================================

-- ── 1. 各类别 App 市场规模 TOP10 ──────────────────────────
SELECT
    category,
    COUNT(DISTINCT app_id)                                      AS app_cnt,
    ROUND(SUM(installs)/1e8, 2)                                 AS total_installs_亿,
    ROUND(AVG(rating), 2)                                       AS avg_rating,
    ROUND(AVG(rating_count), 0)                                 AS avg_reviews,
    -- 市场份额
    ROUND(SUM(installs)/SUM(SUM(installs)) OVER () * 100, 2)   AS market_share_pct
FROM v_apps
GROUP BY category
ORDER BY total_installs_亿 DESC
LIMIT 10;

-- ── 2. 年度新增 App 趋势（含同比增长率）──────────────────
SELECT
    YEAR(released)                                              AS release_year,
    COUNT(DISTINCT app_id)                                      AS new_apps,
    ROUND(SUM(installs)/1e8, 2)                                 AS total_installs_亿,
    -- 同比增长率（LAG 窗口函数）
    ROUND(
        (COUNT(DISTINCT app_id)
            - LAG(COUNT(DISTINCT app_id)) OVER (ORDER BY YEAR(released)))
        / LAG(COUNT(DISTINCT app_id)) OVER (ORDER BY YEAR(released)) * 100
    , 2)                                                        AS yoy_growth_pct
FROM v_apps
WHERE released IS NOT NULL
  AND YEAR(released) BETWEEN 2015 AND 2023
GROUP BY release_year
ORDER BY release_year;

-- ── 3. 免费 vs 付费 App 竞争力对比 ────────────────────────
SELECT
    app_type,
    COUNT(*)                                                    AS app_cnt,
    ROUND(SUM(installs)/1e8, 2)                                 AS total_installs_亿,
    ROUND(AVG(rating), 2)                                       AS avg_rating,
    ROUND(AVG(rating_count), 0)                                 AS avg_reviews,
    -- 高分App（>=4.5）占比
    ROUND(SUM(CASE WHEN rating >= 4.5 THEN 1 ELSE 0 END)
          / COUNT(*) * 100, 1)                                  AS high_rating_pct,
    -- 爆款App（下载量>1000万）占比
    ROUND(SUM(CASE WHEN installs >= 1e7 THEN 1 ELSE 0 END)
          / COUNT(*) * 100, 1)                                  AS blockbuster_pct
FROM v_apps
GROUP BY app_type;

-- ── 4. 评分分布桶分析 ──────────────────────────────────────
SELECT
    CASE
        WHEN rating < 2.0 THEN '1-2分（差评）'
        WHEN rating < 3.0 THEN '2-3分（较差）'
        WHEN rating < 4.0 THEN '3-4分（一般）'
        WHEN rating < 4.5 THEN '4-4.5分（良好）'
        ELSE                    '4.5-5分（优秀）'
    END                                                         AS rating_bucket,
    COUNT(*)                                                    AS app_cnt,
    ROUND(COUNT(*)/SUM(COUNT(*)) OVER () * 100, 1)             AS pct
FROM v_apps
GROUP BY rating_bucket
ORDER BY MIN(rating);

-- ── 5. 内容分级与市场定位（气泡图数据源）─────────────────
SELECT
    content_rating,
    category,
    COUNT(*)                                                    AS app_cnt,
    ROUND(AVG(installs)/1e6, 2)                                 AS avg_installs_M,
    ROUND(AVG(rating), 2)                                       AS avg_rating,
    ROUND(SUM(installs)/1e8, 2)                                 AS total_installs_亿
FROM v_apps
GROUP BY content_rating, category
HAVING app_cnt >= 50
ORDER BY total_installs_亿 DESC;