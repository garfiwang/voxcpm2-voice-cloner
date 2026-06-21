# 更新日誌 (Changelog)

## [v1.1.0] - 2026-06-22

### 新增 (Added)
- **macOS/Linux 自動安裝腳本 (`install.sh`)**：支援在 macOS 和 Linux 上使用 `uv` 建立虛擬環境並自動安裝 PyTorch、VoxCPM、Gradio 等所有必要的相依套件。
- **Apple Silicon (M1/M2/M3/M4) GPU 加速 (MPS) 支援**：在 `clone.py` 中支援 Apple Silicon 的 Metal Performance Shaders (MPS) 進行硬體加速，將語音生成速度提升約 5 倍。

### 變更 (Changed)
- **裝置自動偵測邏輯**：更新 `clone.py` 中的 `detect_device` 函數，將 `mps` 納入自動判定與對應。
- **說明文件更新 (`README.md`)**：更新安裝與執行指令，並加入 macOS/Linux 平台的指令說明，便利其他開發者與網友使用。
