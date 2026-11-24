# Amazon Market Research — 亚马逊市场调研（九站方法论）

当前版本：**V2.0**

> **把类目的产品数据分析成可交付的市场调研报告。**

输入一个亚马逊类目的 Sorftime 导出数据（Top100 产品明细、销量趋势、类目概览、关键词挖掘、关键词反查）和一组财务假设，按**九站主链方法论**逐步推进，每站供给侧（类目数据）×需求侧（关键词数据）双视角交叉验证，最终产出一份可以直接拿去开产品会的市场调研报告。

**交付物**：BW1 报纸灰阶像素风 HTML 交互看板 + 同构 Excel 底稿 + 跨站品牌拉通表，三者共用一份 JSON 单一真相源，**报告中每个数字都可回溯到数据源字段**。

跨平台 AI Agent 技能包，支持 **Claude Code / Codex / Trae / Cursor / DeepSeek Harness / Hermes Agent / WorkBuddy** 等主流 AI 编程助手。

A cross-platform AI agent skill package that turns category product data into a deliverable market research report — Amazon new-category research and profit/pricing calculation using the 9-station methodology. Compatible with Claude Code, Codex, Trae, Cursor, DeepSeek Harness, Hermes Agent, and WorkBuddy.

---

## 它解决什么问题

做亚马逊新品类，最贵的错误不是选错品，是**在信息不全的时候下判断**：

| 常见误区 | 本技能的应对 |
|---|---|
| 只看类目总量，不知道钱在哪个细分 | 站②把技术路线 × 链接形态拆开，销量占比与销售额占比分开看，从反差找结构性机会 |
| 看到关键词搜索量大就以为有机会 | 站③做增量切片 + 上升词榜 + Google Trends 交叉，**趋势分歧本身即结论** |
| 照抄头部产品的参数定价 | 站⑤锁同档竞品，站⑦用差评痛点和盲区词反推该做什么，而不是抄什么 |
| 算利润时漏项，或按峰值价算稳态 | 站⑧强制 13 行成本瀑布 + VAT 过路项口径，**禁用峰值价算常态利润**，正反向闭合误差必须 0.00 |
| 把集团子品牌当白牌打 | 站⑤强制资方穿透，注册国籍与实控人并列呈现 |
| 报告数字对不上，无法复核 | 看板与底稿共用 JSON 数据层，结论每处数字回指具体字段，底部强制输出「口径声明」栏 |

---

## 九站主链

思维链：**锚地盘 → 拆结构 → 找方向 → 定目标 → 锁对手 → 找切口 → 画蓝图 → 算账 → 合并发**

| 站 | 名称 | 核心问题 | 供给侧 | 需求侧 |
|---|---|---|---|---|
| ① | 锚地盘 | 市场在哪 | Best Sellers 类目 + Top100 剔配件定样本口径 | 种子词扩词成词池，标题分词校验覆盖率 |
| ② | 拆结构 | 钱以什么形态流动 | 技术路线 × 链接形态交叉，销量/销售额占比反差 | 意图六分类（大品类/参数/场景/人群/痛点/品牌词） |
| ③ | 找方向 | 增量在哪 | 近 1 年 / 近 3 月新品切片 | 上升词榜 + 新冒头词 + ABA 梯队 + Google Trends 交叉 |
| ④ | 定目标 | 我们站哪 | 新品实际爬到的排名带 = 可达上限 | 剔伪信号：平台自营位、老牌评论壁垒、季节峰值 |
| ⑤ | 锁对手 | 和谁打 | 锚定 3 竞品单品深挖 + 品牌背调 Top20 资方穿透 | 词源反查：大词硬打 vs 长尾包围 |
| ⑥ | 找切口 | 打哪里 | 低分 × 高销海选，差评痛点聚类 | 语义缺口：有搜索量但 Top100 无人覆盖 |
| ⑦ | 画蓝图 | 做什么产品 | 5 维画像：功能/参数/价格/配色/人群 | 每维标注数据出处 |
| ⑧ | 算账 | 赚不赚 | 13 行成本瀑布，正反向定价闭合 | 广告列 = PPC 均价 ÷ 转化率 |
| ⑨ | 合并发 | 输出 | 类目四象限 × 关键词四象限 | 中环：对不上 = 矛盾点标出待裁决 |

**三级闭环**：

- **内环**：站⑧算不平 → 回站⑦改画像迭代
- **中环**：站⑨双维矛盾 → 回站②/③对账
- **外环**：末站自检核验（Verification 全项）

---

## 关键设计

### 宪法层（CONSTITUTION）

技能顶部有一层**不可协商的宪法**，凌驾于其余内容和使用者临时指令之上：

1. 九站思考维度与顺序不可跳过、合并、重排
2. 财务口径 v3 全部公式固定（比例费基数、VAT 过路项、13 行瀑布、闭合误差 0.00）
3. Sorftime 解析铁律（表头在行 3、禁二次切片、列名定位、反查去重）
4. 品牌归因纪律（集团子品牌绝不可归白牌、先穿透资方、注册国籍与实控人并列）
5. 裁决权边界（虚标判定/品牌定性/利润假设 = 使用者裁决，agent 不得自行下结论）
6. 验证外环 + 口径声明栏强制输出
7. 看板主题钦定 BW1 灰阶像素风

**会话微调层**是唯一弹性：只在用户**明示**时允许改数值参数，必须当场登记并打印进报告口径声明栏，且**下次调用自动失效**（冷启动重置）。改数值可以，改公式结构不行。

### 财务口径 v3

- **比例费基数** = 含 VAT 买家实付价 P（非税前价、非标价）
- **VAT 是过路项**：欧盟/英国视同供应商代收代付，不计收入不计成本
- **可争取费率** = 100/(1+v) − (佣金% + 退货% + 仓储% + 利润% + 管理%) − 广告%
- **13 行成本瀑布结构固定**：消费者付款 → 销项 VAT 代缴 → 净回款 → 采购 → 头程 → FBA → 关税 → 仓储 → 佣金 → 退货 → 目标利润 → 管理费 → 广告空间
- **勾稽校验**：③ = ④+…+⑬，误差必须 0.00
- **售价取现行 BuyBox / 中位数**，峰值价仅作天花板，**禁用峰值价算稳态利润**

### 数据解析铁律

这些规则来自真实踩坑（曾静默丢失类目 Top1、少算约 $5M 数据）：

- Sorftime 宽表**表头在行 3**（`min_row=3`），且**禁止再切返回行**
- 关键词导出**列位置会漂移**（59/62/32 列不定），必须按列名 `find_header` 定位，禁止硬编码列索引
- 父级全子体反查：同关键词按子体重复出现，**必须先按关键词去重取 max** 再聚合，否则占比总和 >100%
- 自然/广告流量混在 `自然流量:53%，广告流量:47%` 字符串里，需正则拆分
- 趋势表真实数据块从 `row[2:]` 开始

### 三级验证（看板）

1. `node --check` 校验内联 JS 语法
2. stub-DOM 冒烟测试
3. 真机无头渲染，统计 `<details>` / `<canvas>` / 表格行数对照基线 + 数据层审计脚本 0 FAIL

> 已知致命坑：内联模板字符串 `${cond?`x`:}` 的三元空分支会让**整块看板静默白屏**，而数据审计照样全绿。else 分支必须写 `:""`。

---

## 技能包结构

```
amazon-market-research/
├── SKILL.md                    # 核心方法论（Hermes / Claude Code / Trae / DSH 原生格式）
├── AGENTS.md                   # 通用指令文件（Codex / Trae / Cursor / Copilot 自动发现）
├── CLAUDE.md                   # Claude Code 项目级指令（放项目根目录）
├── CODEX.md                    # Codex 项目级指令（放项目根目录）
├── .cursorrules                # Cursor 项目规则
├── README.md                   # 本文件
├── templates/
│   ├── research-config.yaml    # 配置模板（开工前复制到工作区并填写）
│   └── bw1-dashboard-skeleton.html  # BW1 看板骨架（纯 CSS、零外部依赖）
├── references/
│   ├── format-spec.md          # 交付格式规范（财务口径 v3、瀑布表、看板结构、验证流程）
│   └── pixel-theme.md          # BW1 像素主题 token 规范
├── scripts/
│   └── sorftime_helpers.py     # Sorftime 通用解析工具
└── installers/
    ├── install.ps1             # Windows 一键安装
    └── install.sh              # macOS/Linux 一键安装
```

---

## 安装方法 (Installation)

### Claude Code

**方法 1：作为技能安装（推荐）**
```bash
# 复制整个目录到 Claude Code 技能目录
cp -r amazon-market-research ~/.claude/skills/amazon-market-research/
```
重启 Claude Code 后自动发现，可通过 `/amazon-market-research` 手动调用，或在相关对话中自动加载。

**方法 2：项目级 CLAUDE.md**
```bash
# 把 CLAUDE.md 复制到项目根目录
cp amazon-market-research/CLAUDE.md ./CLAUDE.md
```

### DeepSeek Harness (dsh)

**方法 1：用户级技能（推荐）**
```bash
# 复制到用户技能目录
cp -r amazon-market-research ~/.agents/skills/amazon-market-research/
# 或者
cp -r amazon-market-research ~/.dsh/skills/amazon-market-research/
```
重启 dsh 后自动发现，可通过 `/amazon-market-research` 调用。

**方法 2：项目级技能**
```bash
cp -r amazon-market-research .agents/skills/amazon-market-research/
# 或者
cp -r amazon-market-research .dsh/skills/amazon-market-research/
```

> DeepSeek Harness 与 Claude Code 使用完全相同的 SKILL.md 格式，本包中的 SKILL.md 已包含 `name`、`description`、`whenToUse` 字段，可直接使用。

### Codex (OpenAI)

**方法 1：AGENTS.md 自动发现（推荐）**
```bash
# 把 AGENTS.md 复制到项目根目录
cp amazon-market-research/AGENTS.md ./AGENTS.md
# 同时复制配置模板
cp amazon-market-research/templates/research-config.yaml ./
```
Codex 会自动从项目根目录发现 AGENTS.md 并加载。

**方法 2：配置 CODEX.md**
```bash
cp amazon-market-research/CODEX.md ./CODEX.md
```
在 `~/.codex/config.toml` 中添加：
```toml
project_doc_fallback_filenames = ["CODEX.md"]
```

### Trae

**方法 1：作为技能安装（推荐）**
```bash
# Windows
xcopy /E amazon-market-research %userprofile%\.trae\skills\amazon-market-research\
# macOS/Linux
cp -r amazon-market-research ~/.trae/skills/amazon-market-research/
```

**方法 2：项目级**
```bash
cp -r amazon-market-research .trae/skills/amazon-market-research/
cp amazon-market-research/AGENTS.md ./AGENTS.md
```

### Cursor

```bash
# 把 .cursorrules 复制到项目根目录
cp amazon-market-research/.cursorrules ./.cursorrules
# 同时把 AGENTS.md 也放过去（Cursor 支持）
cp amazon-market-research/AGENTS.md ./
```

### GitHub Copilot

```bash
cp amazon-market-research/AGENTS.md .github/copilot-instructions.md
```

### Hermes Agent

```bash
# Windows
xcopy /E amazon-market-research %LOCALAPPDATA%\hermes\skills\productivity\amazon-market-research\
# macOS/Linux
cp -r amazon-market-research ~/.hermes/skills/productivity/amazon-market-research/
```

### WorkBuddy

将 `SKILL.md` 或 `AGENTS.md` 内容粘贴到 WorkBuddy 的自定义指令中。

---

## 使用流程 (Quick Start)

1. **填写配置**：复制 `templates/research-config.yaml` 到工作区，逐项填写品牌名、费率、路径。
2. **准备数据**：从 Sorftime 导出 5 份数据（见 SKILL.md 开工进料单 A）。
3. **启动 Agent**：在任意支持的 Agent 中告知品类和站点，Agent 按九站链逐步推进。
4. **产出交付**：HTML 看板 + Excel 底稿 + JSON 数据层。

---

## 前置条件 (Prerequisites)

- **Sorftime 付费账号**：数据源为 Sorftime 导出，无则仅能做站外公开信息部分
- **Python 3.8+** + openpyxl、pytrends
- **Node.js**（看板 JS 语法校验用）
- **Chrome/Edge**（看板真机渲染验证用）
- **ECharts 5.5.1**（从 npm 镜像下载，内嵌到看板，禁 CDN）

---

## 平台兼容性速查 (Compatibility Matrix)

| 平台 | 原生技能格式 | 安装路径 | 自动发现 |
|------|------------|---------|---------|
| **Claude Code** | SKILL.md | `~/.claude/skills/<name>/` | ✅ |
| **DeepSeek Harness** | SKILL.md | `~/.agents/skills/<name>/` | ✅ |
| **Trae** | SKILL.md | `~/.trae/skills/<name>/` | ✅ |
| **Hermes Agent** | SKILL.md | `~/.hermes/skills/<name>/` | ✅ |
| **Codex** | AGENTS.md | 项目根目录 | ✅ |
| **Cursor** | .cursorrules / AGENTS.md | 项目根目录 | ✅ |
| **Copilot** | AGENTS.md | `.github/copilot-instructions.md` | ✅ |
| **WorkBuddy** | 自定义指令 | 手动粘贴 | ❌ |


## V2.0 版本说明（2026-09-22 定版）

- **宪法层（CONSTITUTION）**：九站思考维度、财务口径 v3、数据解析铁律、品牌归因纪律、裁决权边界、口径声明栏、BW1 看板主题 = 永不可变；会话微调仅限明示改动、登记进报告、下次调用自动失效（冷启动重置）。见 `AGENTS.md` / `SKILL.md` 顶部章节。
- **开场引导语（OPENING SCRIPT）**：新会话首次触发调研时自动输出三段——我能做什么 / 需要你提供什么（□必须 □后补 □可选）/ 资料怎么获取（逐项路径）。必须项未齐不进 站①。
- **BW1 报纸灰阶像素主题**：看板唯一钦定样式。规范 `references/pixel-theme.md`，骨架模板 `templates/bw1-dashboard-skeleton.html`（纯 CSS、零外部字体/CDN）。
