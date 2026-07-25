# Flow 簽核 Checklist

依序打勾。未通過前一階段，不建議進入下一階段。

## 1. RTL
- [ ] Port / 介面符合規格
- [ ] 可綜合寫法（無 delay、無 initial 用於功能邏輯）
- [ ] Reset 策略明確（非同步高有效或其他，已文件化）
- [ ] `rtl/filelist.f` 已更新

## 2. SIM
- [ ] Smoke test 通過
- [ ] 主要 pattern 全過
- [ ] Corner / illegal 輸入有覆蓋（若規格要求）

## 3. COV
- [ ] Line / Toggle / FSM 達標（目標自訂，例如 >90%）
- [ ] Exclusion 有理由與負責人
- [ ] Report 已存檔於 `cov/report/`

## 4. SpyGlass
- [ ] Lint goal 無 error（warning 已審查）
- [ ] CDC / RDC 問題已處理或 waiver
- [ ] Waiver 記錄在 `spyglass/waiver/`

## 5. SYN
- [ ] Compile / map 成功
- [ ] Timing（理想網表）可接受
- [ ] Area / Power report 已保存
- [ ] Netlist 輸出至 `syn/netlist/`

## 6. LEC（Formality）
- [ ] RTL（golden）vs Syn netlist（revised）等價
- [ ] Abort / Not-compared 點已清零或解釋
- [ ] Session / report 存於 `lec/`

## 7. TMAX
- [ ] Fault coverage 達標
- [ ] Pattern 可回放（若需要）
- [ ] Report / pattern 已歸檔

## 8. PrimeTime
- [ ] Setup / Hold 無未解釋 violation
- [ ] Pre-layout / Post-layout（若適用）皆檢查
- [ ] Report 存於 `primetime/report/`

## 9. APR
- [ ] Placement / CTS / Route 完成
- [ ] DRC / LVS 相關檢查（依流程）
- [ ] DEF / GDS 產出
- [ ] Post-route STA 已重跑（回 PT）

## 簽核紀錄

| 階段 | 負責人 | 日期 | 結果 | 備註 |
| :--- | :--- | :--- | :--- | :--- |
| RTL | | | | |
| SIM | | | | |
| COV | | | | |
| SpyGlass | | | | |
| SYN | | | | |
| LEC | | | | |
| TMAX | | | | |
| PT | | | | |
| APR | | | | |
