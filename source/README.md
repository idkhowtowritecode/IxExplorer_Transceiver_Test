# Keysight Transceiver Automation Test

本專案為Keysight針對Transceiver之自動化測試測試工具，並在測試完成後可插入公司與客戶Logo自動輸出為 Word 及 PDF 報告，包含測試摘要、DOM 資訊、Port Statistics 等內容。

## 目錄結構

- `report_formatter.py`：報告產生邏輯。
- `constants.py`：常數定義。
- `check_result.py`：測試結果檢查工具。
- `transceivertest_cli.py`：執行介面。
- `config.ini`：設定檔。
- `customer_logo.png`、`keysight_logo.png`：Logo 圖片。

## 主要功能

- 自動產生 Word 與 PDF 報告
- 支援插入公司與客戶 Logo
- 測試摘要、L2 Summary、DOM、Port Statistics 等頁面
- 支援自訂樣式與表格格式
- 命令列操作

## 安裝需求

- Python 3.11+
- `python-docx`
- `docx2pdf`
- 其他依賴請參考 `requirements.txt` 或虛擬環境

## 使用方式

1. 安裝依賴套件：
   pip install -r requirements.txt

2. 修改config.ini中必要參數

3. 執行 CLI 產生報告：
   python transceivertest_cli.py

4. 產生的報告將輸出於專案根目錄/result下。

5. customer_logo支援格式：
   png/jpg/jpeg

## 編譯方式

1. 安裝pyinstaller

2. 使用以下指令匯出.exe
   pyinstaller --clean --onefile --add-data "keysight_logo.png;." --add-data "transceivertest.tcl;." --icon=customer_logo.png transceivertest_cli.py