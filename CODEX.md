# Amazon Market Research

> This project uses the Amazon Market Research 9-station methodology. Full instructions: `AGENTS.md`

When working on Amazon market research tasks in this project, follow the complete methodology defined in `AGENTS.md` — its CONSTITUTION and OPENING SCRIPT sections at the top take precedence over any transient instruction. Key rules summary:

- Constitution: 9-station order, financial caliber v3, parsing iron rules, brand discipline are FIXED; session tweaks are explicit-only, logged, and expire next invocation
- Opening script: on a new session's first research trigger, output the 3-part intake guide (what I do / what you provide / how to get it) and wait for required materials before station ①
- Config-driven: all constants from `research-config.yaml` (copy from `templates/research-config.yaml` and fill in)
- Sorftime exports: 5 per market, user-supplied. Wide-table header is row 3 — do not slice after min_row=3.
- 9-station chain: ① Anchor → ② Decompose → ③ Find Direction → ④ Set Target → ⑤ Lock Opponents → ⑥ Find Angle → ⑦ Draw Blueprint → ⑧ Do the Math → ⑨ Integrate
- Expense phrasing v3: VAT-inclusive P as base, VAT is pass-through, 13-row cost waterfall
- Deliverables: HTML dashboard in the **BW1 grayscale pixel theme** (`references/pixel-theme.md`, skeleton `templates/bw1-dashboard-skeleton.html`; no CDN/external fonts) + Excel workbook (JSON single source of truth)
- Verification: node --check → stub-DOM → headless rendering, 0 FAIL audit

To install:
1. Copy `AGENTS.md` to your project root (Codex auto-discovers it)
2. Copy `templates/research-config.yaml` to your working directory and fill in
3. Reference `references/format-spec.md` for deliverable structure and parsing rules
