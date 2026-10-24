# AI 聲音克隆與 AI 翻唱歌聲全指南：從說話到唱歌完整實戰

本指南記錄了從零開始搭建本地語音克隆系統（說話／旁白）、優化錄音品質，到進一步利用雲端免費 GPU 訓練專屬 AI 歌手模型（翻唱歌聲）的完整實戰流程。供所有對 AI 語音感興趣的網友參考、實作與分享。

---

## 目錄
- [第一部分：AI 語音克隆（說話／影片旁白／TTS）](#第一部分ai-語音克隆說話影片旁白tts)
  - [1. 系統特色與硬體支援](#1-系統特色與硬體支援)
  - [2. 一鍵安裝教學（macOS / Windows / Linux）](#2-一鍵安裝教學macos--windows--linux)
  - [3. 錄音黃金法則（決定音質的關鍵）](#3-錄音黃金法則決定音質的關鍵)
  - [4. 啟動錄音介面與儲存聲紋](#4-啟動錄音介面與儲存聲紋)
  - [5. 生成克隆語音與影片剪輯整合](#5-生成克隆語音與影片剪輯整合)
- [第二部分：AI 歌聲轉換與翻唱（唱歌／歌手模型／SVC）](#第二部分ai-歌聲轉換與翻唱唱歌歌手模型svc)
  - [1. 為什麼說話模型不能唱歌？什麼是 SVC？](#1-為什麼說話模型不能唱歌什麼是-svc)
  - [2. 準備與打包歌聲訓練素材](#2-準備與打包歌聲訓練素材)
  - [3. Google Colab 免費 GPU 雲端訓練全流程（Applio）](#3-google-colab-免費-gpu-雲端訓練全流程applio)
  - [4. 人聲與伴奏分離推薦工具（取得純人聲）](#4-人聲與伴奏分離推薦工具取得純人聲)
  - [5. 一鍵轉換翻唱歌曲與成品匯出](#5-一鍵轉換翻唱歌曲與成品匯出)
  - [6. 常見問題：電腦關機後如何重啟？如何永久保存模型？](#6-常見問題電腦關機後如何重啟如何永久保存模型)

---

## 第一部分：AI 語音克隆（說話／影片旁白／TTS）

### 1. 系統特色與硬體支援
本專案採用 **VoxCPM2** 語音合成模型（基於 Apache-2.0 授權，可商用）：
- **跨平台支援**：Windows、macOS（全面支援 Apple Silicon M 系列晶片 MPS 硬體加速）、Linux。
- **免訓練即時克隆（Zero-Shot Cloning）**：只要提供約 20 秒的乾淨參考音檔與精確逐字稿，即可複製說話者的音色、腔調與語氣。
- **支援自然語言與自動化**：可直接透過 AI Agent 或是命令列呼叫。

### 2. 一鍵安裝教學（macOS / Windows / Linux）

#### 🍎 macOS / Linux
開啟終端機（Terminal）執行：
```bash
# 賦予執行權限並執行自動安裝腳本
chmod +x install.sh
./install.sh
```
*腳本會自動使用 `uv` 建立 Python 3.12 虛擬環境，安裝 PyTorch、VoxCPM、Gradio 等所有相依套件，並自動啟用 Apple Silicon GPU (MPS) 加速。*

#### 🪟 Windows
雙擊執行專案目錄下的 `install.bat`（或在 PowerShell 中執行 `.\install.ps1`）。

---

### 3. 錄音黃金法則（決定音質的關鍵）

AI 語音克隆模型（VoxCPM2）的特點是：**「錄進去什麼音質，生成出來就是什麼音質」**。為了達到最自然的聲音，錄音時請遵循以下規範：

1. **逐字稿一字不差（最關鍵）**：
   - 念的內容必須與逐字稿 **100% 完全相符**。
   - 千萬不要出現「呃、嗯、那個」等贅字或自言自語修正口誤，否則模型對齊錯位會導致發音含糊或機器電音。
2. **麥克風距離 10～15 公分**：
   - 約一個拳頭到巴掌寬度。
   - 麥克風稍微斜向嘴角（約 30～45 度），避免「ㄆ、ㄊ、ㄎ」等爆破音直衝麥克風產生噴麥噗噗聲。
3. **安靜與吸音環境**：
   - 避開空曠有回音的大房間（回音會被 AI 當成你聲音的一部分一起克隆）。
   - 在有地毯、窗簾或軟質家具的房間錄製效果最佳，暫時關閉冷氣直吹與電風扇。
4. **推薦聲韻平衡朗讀稿（約 20 秒，涵蓋國語所有聲母與四聲調）**：
   > 「歡迎大家來到這裡。今天我想用最自然的聲音，跟大家分享生活與工作中的觀察。無論面對什麼挑戰，只要保持好奇心與專注，就能發現許多意想不到的驚喜。謝謝你們的聆聽，讓我們一起探索更多可能。」

---

### 4. 啟動錄音介面與儲存聲紋

在專案目錄下啟動網頁錄音工具：
```bash
.venv/bin/python webui_record.py
```
1. 瀏覽器開啟 `http://127.0.0.1:7860`。
2. **聲音名稱**：輸入名稱（例如：`rich的聲音`）。
3. **朗讀文字**：畫面上會自動載入上述聲韻平衡稿。
4. 按下麥克風按鈕錄音，順暢讀完後按停止，點擊 **「💾 存檔」**。
5. 音檔將自動正規化為 16kHz 單聲道並存放在 `voices/<聲音名稱>/`。

---

### 5. 生成克隆語音與影片剪輯整合

#### 生成語音指令
```bash
.venv/bin/python clone.py "你想說的台詞內容" --voice "rich的聲音" -o output/cloned_voice.wav
```
*(若有長篇逐字稿，可存成文字檔執行 `.venv/bin/python clone.py --file script.txt --voice "rich的聲音"`)*

#### 整合進剪輯軟體（YouTube / Shorts / 教學影片）
- 生成的音檔保存在 `output/` 目錄。
- 直接將 `.wav` 拖入 **剪映 (CapCut)、Premiere Pro、Final Cut Pro、DaVinci Resolve**，點擊剪輯軟體的「自動生成字幕」，即可無縫產出口播或解說影片。

---

## 第二部分：AI 歌聲轉換與翻唱（唱歌／歌手模型／SVC）

### 1. 為什麼說話模型不能唱歌？什麼是 SVC？
- **TTS（語音合成）**：像 VoxCPM2，輸入文字輸出語音，缺乏音高（Pitch/F0）、旋律調性與節拍長音，念歌詞只會像唸詩。
- **SVC（歌聲轉換）**：如 **RVC (Retrieval-based Voice Conversion)**，專門用於唱歌。它的原理是輸入一首原唱歌曲的「純人聲」，**保留原唱完美的轉音、音準、節奏與情感，但把聲帶音色無縫置換成你的聲音**（如 AI 孫燕姿、AI 周杰倫）。

---

### 2. 準備與打包歌聲訓練素材

將您剛才錄好的聲音（例如 `voices/rich的聲音/ref_voice.wav`）打包成訓練用壓縮檔：
```bash
mkdir dataset_rich
cp voices/rich的聲音/ref_voice.wav dataset_rich/
zip -r rich_voice_dataset.zip dataset_rich
```
*(大約 25 秒以上的乾淨人聲即可進行基礎訓練，素材越豐富長度 3~5 分鐘效果更佳)*

---

### 3. Google Colab 免費 GPU 雲端訓練全流程（Applio）

我們推薦使用目前 RVC 最強大、現代化且支援雲端免費 GPU 的分支：**Applio**。

#### 步驟 1：開啟 Google Colab 筆記本
點擊開啟官方免費筆記本：
👉 **[Applio 官方 Google Colab Notebook](https://colab.research.google.com/github/IAHispano/Applio/blob/main/assets/Applio.ipynb)**

#### 步驟 2：啟動伺服器
1. 確保 Colab 硬體加速器為 **T4 GPU**（選單：執行階段 ➜ 變更執行階段類型）。
2. 滑到畫面下方的 **「Start server」** 區塊：
   - `method` 保持預設 `gradio`
   - `ngrok_token` 留空
   - 點擊左側紅色 **「▶️ 播放按鈕」**。
3. 等待約 30～60 秒，下方會出現一行公開網址：
   `Running on public URL: https://xxxxxxxx.gradio.live`
4. 點擊該網址進入 Applio 黑色介面。

#### 步驟 3：進入 Training 訓練專屬模型
在 Applio 左側選單點選 **「Training」**：
1. **Model Name**：填入模型名稱（例如：`rich_voice`）。
2. **Prepare Dataset**：
   - 勾選 **`[x] Dataset Creator`**
   - 拖曳上傳剛才打包好的 **`rich_voice_dataset.zip`**
   - 點擊下方按鈕：**「Preprocess Dataset」**（約 5 秒完成切片）。
3. **Extract Features**：
   - 演算法保持預設 **`rmvpe`**（抓音準最強）。
   - Embedder 保持預設 **`contentvec`**。
   - 點擊下方按鈕：**「Extract Features」**（約 15 秒提取特徵完畢）。
4. **Train Model**：
   - **Total Epoch** 設為 **`200`**。
   - **Batch Size** 設為 **`4`**。
   - **勾選 `[x] I agree to the terms of use`**（關鍵，沒勾無法開始）。
   - 點擊白色按鈕：**「Start Training」**！
   - *（Google 雲端 GPU 跑 200 輪約需 3～5 分鐘，右下角黑框會顯示進度）*
5. **建立索引（Index）**：
   - 訓練跑完後，點擊右邊按鈕：**「Generate Index」**（看見 `Index file generated successfully` 即代表全部搞定！）。

---

### 4. 人聲與伴奏分離推薦工具（取得純人聲）

要翻唱一首歌，必須先把歌曲拆成「純人聲」與「伴奏」：

| 工具類型 | 工具名稱 | 適用情境與特色 | 網址 / 獲取方式 |
| :--- | :--- | :--- | :--- |
| **免費線上網站** | **Fadr.com** | 完全免費、可細分人聲/鼓/貝斯、自動算 BPM | [fadr.com](https://fadr.com/) |
| **免費線上網站** | **VocalRemover.org** | 最知名快速、一鍵拆成人聲與音樂兩軌 | [vocalremover.org](https://vocalremover.org/) |
| **商用級線上** | **LALAL.AI** | 人聲過濾極度乾淨、和聲去除能力極強 | [lalal.ai](https://www.lalal.ai/) |
| **剪輯軟體內建** | **剪映 / CapCut 電腦版** | 剪片最順手、右鍵一鍵智能分離人聲 | 軟體內建功能 |
| **本地開源天花板**| **UVR5** | 業界公認最強神器、完全免費、無限制、支援 Mac | [ultimatevocalremover.com](https://ultimatevocalremover.com/) |

---

### 5. 一鍵轉換翻唱歌曲與成品匯出

1. 回到 Applio 左側選單最上方的 **「Convert Audio」**。
2. **Voice Model**：下拉選單拉到底部，選擇最後一輪的 **`rich_voice_200e_...`**（或 `rich_voice.pth`）。
3. **Index File**：下拉選擇 `rich_voice` 的 `.index` 檔案。
4. **Audio Source**：將分離好的歌曲純人聲（例如：`出頭天_vocals.mp3`）拖入上傳區。
5. 點擊 **「Convert」** 按鈕！
6. 幾秒鐘後，右側會出現音訊波形圖，點擊 **「▶️ 播放按鈕」** 即可試聽！
7. 點擊右上角 **「⬇️ 下載圖示」**，將轉換後的歌聲音檔存回電腦。
8. 將「你的翻唱歌聲軌」與原本的「純伴奏軌」丟進剪輯軟體疊合，一首專屬的個人 AI 翻唱單曲就大功告成！

---

### 6. 常見問題：電腦關機後如何重啟？如何永久保存模型？

#### Q1：為什麼我關機後再開，網址顯示「No interface is running right now」？
* **原因**：Colab 提供的 `gradio.live` 是暫時性的即時連線。當你關閉瀏覽器或電腦關機一段時間，Google 雲端主機會自動休眠或斷開連線。
* **重啟方法**：
  1. 重新打開 [Applio Colab](https://colab.research.google.com/github/IAHispano/Applio/blob/main/assets/Applio.ipynb)。
  2. 點擊「Start server」的 **▶️ 播放按鈕**（若環境被重置，點選單的「執行階段」➜「全部執行」）。
  3. 約 1 分鐘後，點擊下方生成的新 `gradio.live` 網址即可恢復。

#### Q2：如何讓訓練好的模型永遠不用重新訓練？
在 Colab 筆記本的最上方有一格：
> 💾 **`Run this cell to automatically Save/Load models from your mounted drive`**
- 執行這格（按播放 ▶️）並授權連接您的 Google Drive。
- 訓練出來的模型會自動儲存在 Google 雲端硬碟的 `ApplioBackup` 資料夾中。
- 如此一來，即使更換電腦或重新開啟 Colab，模型都會永遠保留，打開就能直接唱歌！

---

## 授權與社群分享
- **VoxCPM2 核心**：Apache-2.0 License（可商業化使用）
- **Applio / RVC**：MIT License
- 歡迎自由 Fork、星標（Star）與分享給更多對 AI 語音與歌聲感興趣的創作者！
