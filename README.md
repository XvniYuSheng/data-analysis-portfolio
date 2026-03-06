# 数据分析实战项目（Data Analysis Portfolio）

本仓库用于展示数据分析/数据运营/业务数据分析岗位的作品集，覆盖 **SQL（MySQL）**、**Python（统计检验）**、**PowerBI（BI建模与可视化）** 的端到端分析流程。

## 项目列表

### Project 1：电商销售与用户价值分析（RFM + 复购）
- 数据集：Kaggle Olist Brazilian E-Commerce（多表：订单/用户/商品/支付/物流等）
- 产出：4页 PowerBI 交互式看板 + SQL脚本（清洗/指标/分层/复购）
- 关键能力：多表 JOIN、窗口函数、RFM 分层、复购/留存、业务洞察与建议

### Project 2：App 增长分析与 A/B 测试评估（漏斗 + 统计显著性）
- 数据集：Kaggle Google Play Store Apps
- 产出：5页 PowerBI 增长看板 + SQL脚本（漏斗/增长指标/分层）+ Python A/B 测试脚本（Welch t-test、CI、分层分析、可视化）
- 关键能力：增长指标体系、漏斗分析、实验设计、显著性检验、置信区间、Simpson 悖论规避

## 快速开始（本地复现）
1. 下载数据集（见各子项目 README）。
2. 将 CSV 导入 MySQL（建议 MySQL 8+）。
3. 运行 `sql/` 下脚本生成视图/中间表。
4. PowerBI Desktop 连接 MySQL，打开 `powerbi/` 下的 pbix（或按 README 步骤自行搭建）。

## 目录结构
- `project1-ecommerce/`：电商分析
- `project2-app-growth/`：增长与实验分析

## 联系
- GitHub: XvniYuSheng

---

# 简历项目描述（STAR 模板）

## 项目一：电商销售与用户价值分析（MySQL + PowerBI）
**S**：基于 Olist 约 10 万条订单、9 张业务表的公开数据，模拟电商运营团队的经营分析需求。  
**T**：独立完成数据清洗、核心指标体系搭建、RFM 用户分层与复购/留存分析，并交付 BI 看板。  
**A**：使用 MySQL 多表 JOIN + CTE + 窗口函数（NTILE/LAG/RANK）计算 GMV、订单量、客单价、品类贡献、地域分布等 20+ 指标；构建 RFM 分层识别高价值用户与流失用户，并形成运营建议；用 PowerBI 搭建 4 页交互式看板支持多维钻取。  
**R**：识别出高价值用户占比约 8% 但贡献约 30% 收入的结构特征，结合复购率偏低提出召回与会员运营建议；项目脚本与文档完整上链，具备可复现性。  

## 项目二：App 增长与 A/B 测试分析（MySQL + Python + PowerBI）
**S**：基于 Google Play Store 250 万条 App 数据，模拟互联网增长分析团队对 UI 改版实验的评估场景。  
**T**：搭建增长指标体系、构建转化漏斗并设计 A/B 测试评估方案，判断改版是否带来指标提升。  
**A**：用 MySQL 计算品类规模、评分/口碑分布与年度新增趋势（YoY）；搭建“曝光→浏览→安装→评价”四级漏斗定位流失节点；使用 Python/scipy 进行 Welch’s t-test、计算 95% 置信区间与 Cohen’s d，并按品类分层分析规避 Simpson 悖论；PowerBI 输出 5 ��增长/实验看板。  
**R**：给出是否上线改版的结论与风险提示（显著性、效应量、分层差异），形成可被业务直接采纳的决策依据；完整复现大厂实验分析流程。  
