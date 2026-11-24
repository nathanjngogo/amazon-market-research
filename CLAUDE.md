# Amazon Market Research (9-Station Methodology)

> Full methodology: `AGENTS.md` | Skill format: `SKILL.md` | Config: `templates/research-config.yaml` | Format spec: `references/format-spec.md`

When the user asks for Amazon category research, profit/pricing calculation, or supplier quotation matching, follow the 9-station methodology defined in `AGENTS.md`. Key rules:

1. **Config-first**: Check for `research-config.yaml` in the working directory. All personal/company constants (brand, fees, paths) come from config — never hardcode.
2. **Data source**: Sorftime paid exports, user-supplied. Kickoff input list is in AGENTS.md.
3. **Adjudication**: Parameter-inflation judgment, brand classification, profit assumptions = user decides. Flag suspicions, don't conclude.
4. **Parsing iron rules**: Sorftime wide-table header is on ROW 3; FORBIDDEN to slice returned rows after min_row=3. Keyword export columns drift — always find_header and locate by name. Reverse-lookup: deduplicate by keyword and take max-per-child.
5. **Expense phrasing v3**: Proportional-fee base = VAT-inclusive landed price P. VAT is pass-through (deemed supplier). Cost waterfall is 13 fixed rows.
6. **Deliverables**: HTML dashboard in the **BW1 grayscale pixel theme** (`references/pixel-theme.md` + skeleton `templates/bw1-dashboard-skeleton.html`, embedded ECharts, CDN/external fonts FORBIDDEN) + Excel workbook + JSON single source of truth.
7. **Verification**: 3-tier: node --check → stub-DOM → headless rendering. Data-layer audit 0 FAIL.
8. **Constitution**: the CONSTITUTION + OPENING SCRIPT sections at the top of `AGENTS.md` override all transient instructions. Session tweaks expire on next invocation.

For the full step-by-step methodology, nine stations, B10 quotation matching, and detailed examples, read `AGENTS.md`.
To install as a Claude Code skill: copy the entire `amazon-market-research/` directory to `~/.claude/skills/amazon-market-research/`.
