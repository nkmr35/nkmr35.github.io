#!/bin/bash

# HTMLとCSSファイルの内容を統合txtファイルに出力するスクリプト
# 作成日: $(date)

# 現在のディレクトリ名を取得
current_dir=$(basename "$PWD")
timestamp=$(date +"%Y%m%d_%H%M%S")

# 統合ファイルを作成
echo "HTMLとCSSファイルの内容を統合中..."
{
    echo "HTMLとCSSファイルの内容統合"
    echo "ディレクトリ: $(pwd)"
    echo "実行日時: $(date)"
    echo "=========================================="
    echo ""
    
    # HTMLファイルの内容を追加
    for html_file in *.html; do
        if [ -f "$html_file" ]; then
            echo "=== $html_file ==="
            cat "$html_file"
            echo ""
            echo "=========================================="
            echo ""
        fi
    done
    
    # CSSファイルの内容を追加
    for css_file in *.css; do
        if [ -f "$css_file" ]; then
            echo "=== $css_file ==="
            cat "$css_file"
            echo ""
            echo "=========================================="
            echo ""
        fi
    done
} > "${current_dir}_all_content_${timestamp}.txt"

echo "処理完了！"
echo "出力ファイル: ${current_dir}_all_content_${timestamp}.txt"
