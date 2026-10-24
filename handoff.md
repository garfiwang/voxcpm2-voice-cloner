# 專案交接檔 (handoff.md)

## ⏯️ 目前做到哪
- 已完成 VoxCPM2 在 macOS (Apple Silicon M 系列) 的全自動安裝與 MPS GPU 加速支援。
- 已採集並建立「rich的聲音」聲紋檔案（16kHz 單聲道標準化），並成功生成語音。
- 已成功打通 AI 歌聲轉換（RVC / Applio）雲端訓練流程，完成《出頭天》整曲 4:14 翻唱生成與音軌試聽。
- 已撰寫完整的《AI 語音克隆與 AI 翻唱歌聲全指南》([GUIDE.md](GUIDE.md))，更新首頁說明與日誌 ([CHANGELOG.md](CHANGELOG.md))。
- 已將最新版本代碼與文件推送到 GitHub 儲存庫 `garfiwang/voxcpm2-voice-cloner` 並發布 Release `v1.2.0`。

## 🚦 目前狀態
- **系統運作狀況**：✅ 完全可用、環境健全
- **本地端 (TTS)**：`clone.py` 與 `webui_record.py` 運作正常，已登記「rich的聲音」。
- **雲端 (SVC)**：Applio 訓練模型已完成，可在 Google Colab 連線後直接使用。

## ➡️ 下一步（建議待辦）
1. **多首歌曲翻唱**：挑選更多想翻唱的經典歌曲，透過人聲分離工具（如 Fadr.com）取得人聲後於 Applio 中一鍵置換。
2. **伴奏與人聲後製混音**：將生成的翻唱人聲與背景伴奏軌放進剪映 / CapCut 或 Logic Pro / Audacity 疊合微調音量與殘響，導出最終 MP3/WAV。
3. **訓練模型長期保存**：在 Google Colab 中執行最上方的「Save/Load models from your mounted drive」，確保模型永遠免重練。

## ⚠️ 注意事項與踩坑紀錄
- **逐字稿必須 100% 精確匹配**：錄音時若有贅字、口誤或自言自語，會導致 VoxCPM2 cross-attention 特徵對齊混亂，出現含糊電音；已在 `texts/sample_text.txt` 提供 20 秒聲韻平衡稿。
- **macOS Apple Silicon (MPS) 加速**：`clone.py` 已加入 `torch.backends.mps.is_available()` 判定，自動將 dtype 調為 float32，生成速度比 CPU 快 5 倍。
- **Google Colab 斷線機制**：電腦關機或 Colab 閒置後，`gradio.live` 網址會失效，只需重新進 Colab 點擊「Start server」播放鈕即可產生新網址。

## 🕐 最後更新
- **時間**：2026-10-24 16:08 (GMT+8)
- **更新者**：Antigravity @ M3-Air---garfiwang-3.local
- **Git Push 狀態**：✅ 已推至 GitHub (`garfiwang/voxcpm2-voice-cloner`)
