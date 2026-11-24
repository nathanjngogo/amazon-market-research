# 交付格式规范（固化 · 多品类多站实战定稿）

新品类调研的产物结构、维度定义、验证流程一律照此执行。改任何口径 → 全链重跑，禁止手补产物。文中 `{brand}` = config `identity.brand_name`；`{产出}` = config `paths.output_dir`；`{调研}` = config `paths.research_dir`。

## 1. 文件命名与目录

```
{产出}\
├─ {品类}{站点中文}市场洞察-{brand}看板.html   ← 看板与底稿必须同名同构
├─ {品类}{站点中文}市场洞察-{brand}底稿.xlsx
├─ {品类}品牌多站拉通表.xlsx                    ← 独立对照表
└─ {品类}市场调研\                              ← 首发站可单独子目录
{调研}\{品类}{区域}市场数据\{SITE}_dashboard.json  ← 单一真相源
```

管线脚本放工作区 `scratch\`，按站点分链：数据层 → B10匹配 → 看板+底稿生成 → 审计 → 瀑布sheet注入 → 横评sheet → 品牌拉通注入 → 三级验证。

## 2. 九站维度定义（站名固定，看板 sec(1..9)）

| 站 | 名称 | 核心维度 | 判据 |
|---|---|---|---|
| ① | 锚地盘｜样本口径 | 整机样本数(剔配件)、月销量/额、空价行 | 配件剔除清单单独成表 |
| ② | 拆结构 | 价格带(6档 band/n/qty/mean/qshare/ashare)、功能渗透、场景、卖家类型、履约、原产国 | 量份额与额份额分开看，反差=机会 |
| ③ | 找方向｜增量与动量 | monthly(24月)、yoy(5-7月窗口削平 Prime Day 错位)、momentum 双榜、new3/new12 | 新品占比、动量倍数 |
| ④ | 定目标｜排名-月销曲线 | rank_curve(bin/n/med_q/min_q)、300台门槛线 | 近12月新品实际爬到的排名带=可达上限 |
| ⑤ | 锁对手｜头部与系别穿透 | brands/brands_recon(Top20)/cr3/cr5/family_share、三锚反查词源 | 每条背调带证据+出处URL |
| ⑥ | 找切口｜低分高销海选 | low_rating(评分<4.2×月销前列)、语义缺口词、SWOT | 海选表进看板+底稿 |
| ⑦ | 画蓝图｜定位假设 | 开发画像5维(功能/参数/价格/配色/人群) | 每维标数据出处；与⑧内环互验 |
| ⑧ | 算账｜成本上限 | ceil_table(0%/及格线/上限×锚点)、B10矩阵、成本瀑布13行 | v3 口径见 §3 |
| ⑨ | 合并发｜双维合成 | 类目四象限×关键词四象限、埋词清单、跨市场对照 | 矛盾点标出待使用者裁决 |

每份看板末尾必附「下一步喂数清单」：①该站类目关键词导出 ②3 个对标 ASIN 反查（ASIN+品名+选择理由，三种词源结构=新品爆量样板/差评失守高销/本土二线）。

站④「300台门槛线」为示例常量——实际门槛按 config/使用者产能资金天花板定。

## 3. 财务口径 v3（定稿，替换此前一切版本）

**两条官方依据**
- 比例费基数 = 含 VAT 的买家实付价 P（已扣折扣/Coupon）。sell.amazon.de：total amount paid by the buyer, including item price and any delivery or gift wrapping charges；aboutamazon.de 例：含税收货 €100 → 佣金 €15。
- VAT 是**过路项**：亚马逊 deemed supplier（欧盟 Art.14a / 英国 NETP）代收自缴，卖家从未拿到——不记收入也不记成本。回款 = P ÷ (1+v)。

**税率表（已按官方源核实；税率会变动，跨期复用前复核 europa.eu/DG TAXUD TEDB/HMRC/USITC）**

| 站点 | VAT | 关税 HS8508.11（清洁电器示例，新品类重查 HS） | 依据 |
|---|---|---|---|
| DE/FR/IT/ES | 19/20/22/21% | 2.2% 对 CIF | europa.eu Youreurope、DG TAXUD TEDB、TARIC |
| UK | **20%（已入表）** | 2.2% | HMRC VATA 1994 Sch.7A；亚马逊 UK 对非英卖家 = deemed supplier (NETP) |
| US | 无（销售税不经平台向第三方卖家代收） | free | HTS 8508.11.80 |
| JP | 消费税 8% 暂未入表（售价已含、卖方自缴） | 0 | 二期评估 |

**成本瀑布 13 行（站⑧必配，结构固定；百分比为示例值，实取 config `fees.*`）**

① 消费者支付(挂牌含税价)=P ｜ ② 销项VAT→亚马逊代收代缴=P×v/(1+v)，kind=vat ｜ ③ 你的实际收入(不含税净额)=P/(1+v)，kind=head ｜ ④ 采购价·含税=BOM$×汇率 ｜ ⑤ 头程（按 config `first_leg` 分线路公式）｜ ⑥ FBA履约费(同带竞品实测中位，保守取高档) ｜ ⑦ 进口关税=税率×CIF ｜ ⑧ 仓储=P×storage% ｜ ⑨ 佣金=P×commission% ｜ ⑩ 退货损耗=P×return% ｜ ⑪ 利润(既定目标)=P×profit%，kind=profit ｜ ⑫ 管理成本=P×admin% ｜ ⑬ 广告预算空间(倒挤)=③−(④~⑫)，kind=space(绿≥及格线/黄0~及格线/红<0) ｜ 勾稽校验：③=④+…+⑬，误差必须 0.00，kind=check。

核心机制：⑧~⑫按毛价 P 计收、用净额③支付——**两力方向相反**。

**B10 判决**：`max_ad% = [P/(1+v) − (commission+return+storage+profit+admin)%×P − landed] / P × 100`（示例费率合计 54%）；分母=P（ACOS 口径），及格线与投放上限（config `fees.ad_pass_pct`/`ad_cap_pct`）同按 P 判。禁按供应商标价直接对上限——先把画像强制项折进 BOM。无锚达标时输出「最优但未达标」+「需换供应商或再提价」。

## 4. 品牌审计（多站拉通）

判定顺序：先资方穿透（工商/商标/上市代码）→ 再定盘型（大厂系/集团子品牌/新兴品牌商/铺货白牌）。已核实归属（清洁电器类，跨品类复用时新品类必须重新穿透）：eufy=安克创新(300866)、tapo=TP-Link、eureka=美的、mova=追觅、ilife/easine=智一、proscenic=深圳浦桑尼克（≠普渡 PuduTech）、irobot=Picea/360系、roborock=石头、dreame=追觅、ecovacs=科沃斯、narwal=云鲸、switchbot=威迈系。白牌=无品牌主体仅铺货；有独立官网的新兴品牌归「品牌商」。拉通表：品牌×系别×各站量份额，`✓`=入系未进前10、`—`=未出现，**同一品牌各站系别必须一致**；进每份看板(⑤附)+每份底稿(sheet)+独立 xlsx。注册国籍与实控资方背离时结论双口径并列。

## 5. HTML 看板格式

单文件自包含：内嵌 CSS（变量主题）→ 头部标题+meta 徽章 → 顶部编号叙事结论（每句数字回指数据层字段）→ 9 个 `<details>` 站点区块 → 每站 = .concl 结论句 + tbl 表格 + ECharts 图 + .src/.note 来源注 → 附品牌多站拉通(xf-body)/产品横评(xc-body)/喂数清单 → 本地内嵌 ECharts 5.5.1（npmmirror，禁 CDN）→ `const DATA={…}` 全量内嵌。

图型白名单：柱=排名/分布、饼=占比、折线=趋势。同品类细分颜色跨图一致；开工定色板全程沿用。标准图位：①1柱 ②每维度1柱+1饼 ③柱+柱+饼+折线 ④1折线(标目标排名带) ⑤1饼(系别份额) ⑥⑦⑧表格不强配图。

**渲染基线**（真机验证必须达到；数值为历史实战基线，新市场按自身区块/图表数重算并固化进审计脚本）：单市场看板 details≥12、canvas≥9；多站合并板块 details≥11、canvas≥7；品牌拉通表行数=表内品牌总数（静态或动态 xf-body 均可）。

**JS 模板字符串铁律**（三次白屏事故）
1. `${cond?`x`:}` 空分支三元必须写 `:""`，否则整板静默白屏且数据审计照样全绿；
2. 三元内引用的变量必须先定义（`vat` vs `vt` 拼错曾让 4 站全白）；
3. 站点特例文案优先走数据驱动（读 `DATA.assumptions.vat_pct`），硬编码站点分支容易与数据层脱节。

## 6. Excel 底稿格式

sheet 清单按站点复杂度伸缩（历史实战参考：单市场精简 10 sheet：`看板|品牌Top20|价格带与结构|三锚反查词表|差评与SWOT|GT与需求|B10匹配|产品横评|品牌多站拉通|成本瀑布`；多站合并 18-20 sheet；全量深度站 29 sheet，另含：数据源/结构分布/月度矩阵/新品3月/配件剔除/B10定稿判决/成本模型/埋词与画像/品牌背调/广告经济学/广告敏感性/复核记录/原始数据）。必配 sheet：`00口径`、`B10匹配`、`成本瀑布`、`品牌拉通`、`产品横评`、`结论`。

样式：表头白字加粗10号+深蓝底(1F4E5D)、冻结 A2。`00口径` 必含：站点/样本/量额/佣金退货仓储/利润管理广告（均取 config `fees.*`）/汇率/VAT口径/关税/头程公式/FBA带/数据层文件名。成本瀑布 sheet 列=序·项目|金额(本币)|占挂牌价%|说明，13 行 + vat_note/caliber_note 全文。产品横评首行=我方选定产品（含计划上架时间）+ 站⑤竞品。

## 7. 三级验证（每板必过，缺一不可）

```
① node --check   抽出内联 JS 写临时 .js → 语法零错误
② stub-DOM 冒烟  模拟 document/echarts 挂载全部区块 → NaN/undefined 即报
③ 真机无头渲染   chrome --headless=new --disable-gpu --no-first-run
                 --virtual-time-budget=30000 --dump-dom "file:///{路径}"
                 → 统计 details/canvas/tr、xf 行数、瀑布行数，对照 §5 基线
                 → 再跑数据层审计脚本，必须 0 FAIL
```
①查语法、②查运行时 NaN、③查模板串静默白屏（stub 查不出）。headless dump-dom 输出里瀑布表若只有 1-2 行 = JS 未执行，去 ③ 的 stderr 找 TypeError。Windows 下 chrome 路径常见为 `"/c/Program Files/Google/Chrome/Application/chrome.exe"` 或 Edge `msedge --headless=new`。

## 8. Sorftime 解析铁律（血泪坑）

1. 类目宽表表头在**第 3 行**（第1行注释+第2行空行），`min_row=3` 且**禁止再切片**——双跳丢掉真实 #1 best-seller（曾少算 ~$5M）。
2. 趋势表 ASIN 锚 col A，月度数据块从 col C 起。
3. 关键词/反查导出表头在第 1 或 2 行漂移、列数 59/62/32 不一——一律 find_header 扫前 3 行 + **按列名定位，禁写死索引**。
4. 父体全子体反查：同一关键词按子体重复，占比分母=该子体总流量——**按关键词去重取 max-per-child 再聚合**，否则求和 >100%。
5. 自然/广告拆流藏在“贡献流量”字符串（`自然流量:53%，广告流量:47%`）需正则解析；`--`=None，缺失字段不计入加权分母；部分导出无 Asin 列（已聚合到父体）或无 CPC 列——卡片如实标"导出缺列"。
6. openpyxl `iter_rows` 返回 Cell 必须取 `.value`；merged cell 无值属正常。
7. 套装链接（セット買い）归整机；上架时长看 Listing 上架时间非 ASIN 上架时间。
8. 噪音词表必配（示例：扫地机类的擦窗机器人词 robot limpiacristales/winbox/fenster sauger 级 47k/月）——每品类开工先建 config `category_constants.noise_keywords`。

## 9. 协作流程（使用者偏好，可按人调整）

动手前批量提问确认意图；正式成品前先看目录/结构过目；交付后多轮交叉审核（逐项核数字/用词/公式口径，术语必须准确人类能看懂，事实口径查官方文件并注明出处）。虚标判定、利润假设、品牌定性 = 使用者裁决，agent 只标存疑不下结论。利润/佣金/汇率等假设一律使用者定义，agent 勿编造。
