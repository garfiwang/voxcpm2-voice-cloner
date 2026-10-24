# 更新日誌 (Changelog)

## [v1.2.0] - 2026-10-24

### 新增 (Added)
- **AI 語音克隆與 AI 翻唱歌聲全指南 (`GUIDE.md`)**：
  - 詳細記錄日常語音克隆（TTS）、錄音聲韻平衡法則、麥克風設置與防噴音技巧。
  - 完整收錄 AI 歌手翻唱（SVC / RVC / Applio）雲端免費 GPU 訓練 Step-by-Step 實戰流程。
  - 整理人聲與伴奏分離工具（Fadr、VocalRemover、UVR5、剪映）評比。
  - 收錄 Colab 關機重連與 Google Drive 永久模型備份解決方案。
- **聲韻平衡示範文字稿 (`texts/sample_text.txt`)**：涵蓋國語所有聲母與四聲調起伏，大幅提升零樣本克隆音色逼真度。

### 變更 (Changed)
- **更新專案首頁 (`README.md`)**：加入完整操作指南指引連結。
- **優化 `.gitignore`**：排除個人音訊檔案、資料集壓縮檔與模型權重檔，確保個人聲紋隱私安全。

---

## [v1.1.0] - 2026-06-22

### 新增 (Added)
- **macOS/Linux 自動安裝腳本 (`install.sh`)**：支援在 macOS 和 Linux 上使用 `uv` 建立虛擬環境並自動安裝 PyTorch、VoxCPM、Gradio 等所有必要的相依套件。
- **Apple Silicon (M1/M2/M3/M4) GPU 加速 (MPS) 支援**：在 `clone.py` 中支援 Apple Silicon 的 Metal Performance Shaders (MPS) 進行硬體加速，將語音生成速度提升約 5 倍。

### 變更 (Changed)
- **裝置自動偵測邏輯**：更新 `clone.py` 中的 `detect_device` 函數，將 `mps` 納入自動判定與對應。
- **說明文件更新 (`README.md`)**：更新安裝與執行指令，並加入 macOS/Linux 平台的指令說明，便利其他開發者與網友使用。
