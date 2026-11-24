"""
Sorftime 通用解析工具 — 封装多品类实战中验证的铁律。
所有 Agent 平台（Claude Code / Codex / Trae / DSH / Hermes）均可通过 `python sorftime_helpers.py` 调用。
"""
from openpyxl import load_workbook
from typing import Optional
import re

# ─── 宽表解析（类目 Top100 产品详情）────────────────────────────
def parse_wide_table(
    path: str,
    sheet_name: Optional[str] = None,
    header_row: int = 3,  # Sorftime 表头在第 3 行（第1行注释 + 第2行空行）
):
    """
    解析 Sorftime 类目宽表。返回 (columns, rows)。
    铁律：header_row 之后禁止对 rows 再切片（曾经双跳丢掉 Top1，少算 ~$5M）。
    """
    wb = load_workbook(path, data_only=True, read_only=True)
    ws = wb[sheet_name] if sheet_name else wb.active

    # 读表头
    header = []
    for col in range(1, ws.max_column + 1):
        header.append(ws.cell(row=header_row, column=col).value)

    # 读数据行（从 header_row+1 到最后，禁止切片）
    rows = []
    for row in ws.iter_rows(
        min_row=header_row + 1, max_row=ws.max_row, values_only=True
    ):
        rows.append(list(row))

    wb.close()
    return header, rows


# ─── 关键词/反查导出解析 ──────────────────────────────────────
def find_header(ws, scan_rows: int = 3):
    """
    扫描前 N 行定位真实表头行。
    铁律：关键词导出表头行和列数会漂移（59/62/32 列），必须按列名定位，禁止写死索引。
    返回 (header_row, headers_dict: {col_idx: col_name})。
    """
    for r in range(1, scan_rows + 1):
        row_vals = [ws.cell(row=r, column=c).value for c in range(1, ws.max_column + 1)]
        # 统计非空且含中文/英文词特征的有效列名
        meaningful = [v for v in row_vals if v and isinstance(v, str) and len(v.strip()) > 1]
        if len(meaningful) >= 3:
            return r, {c: v for c, v in enumerate(row_vals) if v}
    return 1, {}


def parse_keyword_export(path: str, sheet_name: Optional[str] = None):
    """
    解析关键词导出 / 反查导出。
    返回 (columns, rows)。
    自动 find_header，按列名读取，不受列数/列序漂移影响。
    """
    wb = load_workbook(path, data_only=True, read_only=True)
    ws = wb[sheet_name] if sheet_name else wb.active

    header_row, header_map = find_header(ws)

    rows = []
    for row in ws.iter_rows(min_row=header_row + 1, values_only=True):
        record = {}
        for col_idx, col_name in header_map.items():
            record[col_name] = row[col_idx] if col_idx < len(row) else None
        rows.append(record)

    wb.close()
    return list(header_map.values()), rows


# ─── 父体全子体反查去重 ──────────────────────────────────────
def dedup_reverse_lookup(rows: list, keyword_col: str, asin_col: str = "Asin",
                          traffic_share_col: str = "流量占比"):
    """
    父体全子体反查：同一关键词按子体重复出现，流量占比分母=该子体总流量。
    铁律：必须先按关键词去重取 max-per-child，再聚合，否则求和 >100%。

    返回去重后的行列表。
    """
    # 按 (keyword, ASIN) 去重，保留最大流量占比例的行
    best = {}
    for row in rows:
        kw = str(row.get(keyword_col, "")).strip()
        asin = str(row.get(asin_col, "")).strip()
        if not kw or not asin:
            continue
        key = (kw, asin)
        try:
            share = float(str(row.get(traffic_share_col, 0)).replace("%", ""))
        except (ValueError, TypeError):
            share = 0
        if key not in best or share > best[key][1]:
            best[key] = (row, share)

    return [v[0] for v in best.values()]


# ─── 自然/广告拆流解析 ──────────────────────────────────────
def parse_traffic_split(contribution_str: str):
    """
    从 "自然流量:53%，广告流量:47%" 字符串中提取自然/广告占比。
    铁律：'--' = None；缺失字段不计入加权分母。
    返回 (natural_pct, ad_pct) 或 (None, None)。
    """
    if not contribution_str or contribution_str == "--":
        return None, None
    natural = re.search(r"自然流量[：:](\d+\.?\d*)%", str(contribution_str))
    ad = re.search(r"广告流量[：:](\d+\.?\d*)%", str(contribution_str))
    return (
        float(natural.group(1)) if natural else None,
        float(ad.group(1)) if ad else None,
    )


# ─── 趋势表解析 ──────────────────────────────────────────────
def parse_trend_table(path: str, sheet_name: Optional[str] = None):
    """
    解析销量趋势表（ASIN × 月份矩阵）。
    铁律：ASIN 在 col A (index 0)，月度数据从 col C (index 2) 起。
    返回 (columns, rows) — columns 含 ASIN + 各月。
    """
    wb = load_workbook(path, data_only=True, read_only=True)
    ws = wb[sheet_name] if sheet_name else wb.active

    # 假设第 2 行是月份表头（按实际漂移调整），ASIN 列在 col A
    months = []
    for col in range(3, ws.max_column + 1):  # col C 起为月度数据
        val = ws.cell(row=2, column=col).value
        if val:
            months.append(str(val))

    columns = ["ASIN"] + months

    rows = []
    for r in range(3, ws.max_row + 1):
        asin = ws.cell(row=r, column=1).value
        if not asin:
            continue
        record = [asin]
        for col in range(3, ws.max_column + 1):
            record.append(ws.cell(row=r, column=col).value)
        rows.append(record)

    wb.close()
    return columns, rows


# ─── 通用辅助 ────────────────────────────────────────────────
def safe_value(row: list, col_index: int, default=None):
    """从列表型行中安全取值（索引越界返回 default）。"""
    try:
        return row[col_index]
    except IndexError:
        return default


def strip_accessories(rows: list, title_col_idx: int,
                      accessory_keywords: list) -> tuple:
    """
    ①站配件剔除：从宽表中分离配件/整机。
    配件关键词由 config category_constants.accessory_exclude 提供。
    返回 (整机行, 配件行)。
    """
    whole = []
    accessories = []
    for row in rows:
        title = str(safe_value(row, title_col_idx, "")).lower()
        if any(kw.lower() in title for kw in accessory_keywords):
            accessories.append(row)
        else:
            whole.append(row)
    return whole, accessories
