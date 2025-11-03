nkmr35.github.io 静的サイト 法務ページ実装計画書
作業指示概要
一文要約
nkmr35.github.io に「プライバシーポリシー」「利用規約」「サポート」の静的HTMLページを追加し、簡易i18n（日本語/英語）対応とトップページからの導線を実装する。
期待する最終成果物
3つの新規ページ: /privacy.html, /terms.html, /support.html（Skeleton＋多言語見出し＋最終更新日）
i18n資源: /i18n/Localizable.xcstrings と適用用スクリプト /assets/js/i18n.js
法務ページ用スタイル /legal.css
/index.html に3ページへのリンクを追加
すべてUTF-8（LF改行）、外部秘密不要、GitHub Pages上で即時公開可能
作業の背景・目的
背景
iOSアプリ公開にあたり、審査・ユーザー向けに参照可能な法務ページ（プライバシー、規約、サポート）が必要。現状は index.html のみ公開済み。
現状の課題
必須/推奨の法務ページURLが未整備で、App Store Connect 等に登録できない
英語レビュー対応のため、多言語の最低限土台がない
目的（なぜやるか）
迅速にURLを用意し、審査・ユーザー案内・アプリ内リンクに使用する
低コストで維持できる静的サイトの枠組みを用意する（ひな型＋i18n最小）
対象範囲・非対象
変更対象の機能/モジュール
nkmr35.github.io 静的サイト（リポジトリルート）
新規: /privacy.html, /terms.html, /support.html, /legal.css, /assets/js/i18n.js, /i18n/Localizable.xcstrings
既存: /index.html（法務リンク追加のみ）
明確な非対象（変更しない領域）
iOS/Watchアプリ側のコード、別リポジトリ（Focus/FocusCore等）
VCS操作（ブランチ作成・コミット・PR）
外部ビルド/デプロイ手順（GitHub Pages 設定操作等）
仕様詳細・受け入れ基準
機能要件
新規3ページの作成（Skeleton）
タイトル（日本語/英語）、ナビゲーション、本文の「作成中」メッセージ、最終更新日（固定: 2025-10-22）を表示
共通スタイル legal.css を適用
クライアントサイドの簡易i18nを適用（/assets/js/i18n.js + /i18n/Localizable.xcstrings）
既定: 日本語（navigator.language が "en" 始まりなら英語）
data-i18n 属性で文字列を置換
失敗時は日本語の既定文をそのまま表示
index.html から3ページへのリンクを追加
非機能要件
セキュリティ: 外部秘密不要、追跡/解析スクリプトなし、相対パスで完結
パフォーマンス: 静的配信のみ、i18n取得は1ファイル（キャッシュ抑止オプション付き）
可観測性: i18nの読込失敗は console.warn のみ（ユーザー影響は既定文のまま）
互換性: 近年の主要ブラウザ（ES6+）で動作
受け入れ基準（Given/When/Then）
Given: ブラウザで /privacy.html を開く
When: navigator.language が "ja" 系
Then: タイトルが「プライバシーポリシー」、本文に「このページは作成中です。」、フッターに「最終更新日: 2025-10-22」を表示
Given: ブラウザで /terms.html を開く
When: navigator.language が "en-US"
Then: タイトルが "Terms of Use"、本文が "This page is under construction." に英訳される
Given: /index.html を開く
When: 画面下部を視認
Then: 「プライバシーポリシー」「利用規約」「サポート」へのリンクがある
Given: ネットワークの都合で /i18n/Localizable.xcstrings の取得に失敗
When: ページを表示
Then: エラーでページが壊れず、日本語の既定テキストのまま表示され、console に警告が出る
影響範囲
依存モジュール: なし（純静的）
外部API: なし（同一オリジンのJSONをfetch）
UI: 3つの新規ページ＋index.html のリンク
ドキュメント: 本計画書、i18n辞書ファイル（Localizable.xcstrings）
実装ステップ全体像
Step.1 i18n資源の追加（辞書ファイルと適用JS）
Step.2 法務ページ用スタイルの追加（legal.css）
Step.3 privacy.html の追加（Skeleton）
Step.4 terms.html の追加（Skeleton）
Step.5 support.html の追加（Skeleton）
Step.6 index.html に法務リンク導線を追加
実装ステップ詳細
ステップ.1: i18n資源の追加

目的
多言語表示の土台（辞書・適用処理）を作る
変更ファイル一覧
パス: i18n/Localizable.xcstrings / 変更種別: new / 検索アンカー: N/A / 挿入・置換: 新規作成（全量）
パス: assets/js/i18n.js / 変更種別: new / 検索アンカー: N/A / 挿入・置換: 新規作成（全量）
作業内容要約
xcstrings 形式の辞書（日本語/英語）と、data-i18n を置換する軽量JSを追加
手順
i18n/Localizable.xcstrings を新規作成（UTF-8, LF）
assets/js/i18n.js を新規作成
JS内の fetch パスは相対 "i18n/Localizable.xcstrings" に固定
辞書が未取得またはキー欠落でもページは壊れないように try/catch
エラーハンドリング・ロギング方針
fetch 失敗・JSON不正: console.warn に記録し、既定の日本語文を維持
リスク・注意点・フォールバック
アンカー未検出の概念なし（新規ファイル）
ブラウザが fetch/Promise 非対応の場合はスクリプト無効（既定文のまま）
新規作成コード
対象ファイル: i18n/Localizable.xcstrings / 言語: JSON <ここから＜ステップ.1＞のソースコード全量> { "sourceLanguage": "ja", "strings": { "site.nav.home": { "localizations": { "ja": { "stringUnit": { "value": "ホーム" } }, "en": { "stringUnit": { "value": "Home" } } } }, "site.nav.privacy": { "localizations": { "ja": { "stringUnit": { "value": "プライバシーポリシー" } }, "en": { "stringUnit": { "value": "Privacy Policy" } } } }, "site.nav.terms": { "localizations": { "ja": { "stringUnit": { "value": "利用規約" } }, "en": { "stringUnit": { "value": "Terms of Use" } } } }, "site.nav.support": { "localizations": { "ja": { "stringUnit": { "value": "サポート" } }, "en": { "stringUnit": { "value": "Support" } } } }, "legal.lastUpdated.label": { "localizations": { "ja": { "stringUnit": { "value": "最終更新日" } }, "en": { "stringUnit": { "value": "Last updated" } } } }, "legal.underConstruction": { "localizations": { "ja": { "stringUnit": { "value": "このページは作成中です。" } }, "en": { "stringUnit": { "value": "This page is under construction." } } } }, "legal.appName": { "localizations": { "ja": { "stringUnit": { "value": "Focus（iOSアプリ）" } }, "en": { "stringUnit": { "value": "Focus (iOS app)" } } } }, "privacy.title": { "localizations": { "ja": { "stringUnit": { "value": "プライバシーポリシー" } }, "en": { "stringUnit": { "value": "Privacy Policy" } } } }, "privacy.summary": { "localizations": { "ja": { "stringUnit": { "value": "本アプリおよび本サイトにおける個人情報の取り扱いについて記載します。" } }, "en": { "stringUnit": { "value": "This page describes how we handle personal data for the app and this site." } } } }, "terms.title": { "localizations": { "ja": { "stringUnit": { "value": "利用規約" } }, "en": { "stringUnit": { "value": "Terms of Use" } } } }, "terms.summary": { "localizations": { "ja": { "stringUnit": { "value": "本アプリのご利用条件について記載します。" } }, "en": { "stringUnit": { "value": "This page contains the terms and conditions for using the app." } } } }, "support.title": { "localizations": { "ja": { "stringUnit": { "value": "サポート" } }, "en": { "stringUnit": { "value": "Support" } } } }, "support.summary": { "localizations": { "ja": { "stringUnit": { "value": "お問い合わせ先やヘルプ情報を案内します。" } }, "en": { "stringUnit": { "value": "Contact and help information." } } } }, "support.contactUs": { "localizations": { "ja": { "stringUnit": { "value": "メールで問い合わせる" } }, "en": { "stringUnit": { "value": "Contact by email" } } } } }, "version": "1.0" } <ここまで＜ステップ.1＞のソースコード全量>

対象ファイル: assets/js/i18n.js / 言語: JavaScript <ここから＜ステップ.1＞のソースコード全量> (function () { 'use strict';

function detectLang() { try { const url = new URL(window.location.href); const q = url.searchParams.get('lang'); if (q) { localStorage.setItem('site.lang', q); return q; } } catch (_) { /* noop */ } const stored = localStorage.getItem('site.lang'); if (stored) return stored; const nav = (navigator.language || navigator.userLanguage || 'ja').toLowerCase(); return nav.startsWith('en') ? 'en' : 'ja'; }

function getValueForKey(strings, key, lang) { if (!strings || !strings[key] || !strings[key].localizations) return null; const locs = strings[key].localizations; // prefer chosen lang, then ja fallback const candidate = (locs[lang] && locs[lang].stringUnit && locs[lang].stringUnit.value) || (locs.ja && locs.ja.stringUnit && locs.ja.stringUnit.value); return candidate || null; }

async function applyI18n() { const lang = detectLang(); try { const res = await fetch('i18n/Localizable.xcstrings', { cache: 'no-store' }); if (!res.ok) throw new Error('i18n fetch failed: ' + res.status); const data = await res.json(); const dict = data && data.strings ? data.strings : {};

  // Replace text contents for data-i18n elements
  const nodes = document.querySelectorAll('[data-i18n]');
  nodes.forEach(node => {
    const key = node.getAttribute('data-i18n');
    const val = getValueForKey(dict, key, lang);
    if (val) node.textContent = val;
  });
  // Optionally set <html lang="..">
  document.documentElement.setAttribute('lang', lang);
} catch (e) {
  console.warn('[i18n] fallback to default texts:', e && e.message ? e.message : e);
}
}

if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', applyI18n); } else { applyI18n(); } })(); <ここまで＜ステップ.1＞のソースコード全量>

ステップ.2: 法務ページ用スタイルの追加

目的
法務ページの簡素で読みやすいレイアウトを提供
変更ファイル一覧
パス: legal.css / 変更種別: new / 検索アンカー: N/A / 挿入・置換: 新規作成（全量）
作業内容要約
ベーシックなタイポグラフィ、レイアウト、ナビゲーションの見た目
手順
legal.css を新規作成
各法務ページの にて読み込み
エラーハンドリング・ロギング方針
CSS 読込失敗時はブラウザ既定スタイル（影響軽微）
リスク・注意点・フォールバック
既存 style.css への影響なし（別ファイル）
新規作成コード
対象ファイル: legal.css / 言語: CSS <ここから＜ステップ.2＞のソースコード全量> /* Basic legal pages styles */ :root { color-scheme: light dark; --fg: #111; --bg: #fff; --muted: #666; --link: #0b5fff; --border: #e5e5e5; } @media (prefers-color-scheme: dark) { :root { --fg: #eee; --bg: #121212; --muted: #aaa; --link: #72a0ff; --border: #2a2a2a; } }

html { font-size: 16px; } body { margin: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans JP", "Hiragino Sans", "Yu Gothic UI", "YuGothic", "Helvetica Neue", Arial, sans-serif; color: var(--fg); background: var(--bg); line-height: 1.7; -webkit-text-size-adjust: 100%; text-size-adjust: 100%; } .site-header { border-bottom: 1px solid var(--border); background: transparent; } .site-nav { max-width: 880px; margin: 0 auto; padding: 12px 16px; display: flex; gap: 16px; flex-wrap: wrap; } .site-nav a { color: var(--link); text-decoration: none; font-weight: 600; } .site-nav a:hover { text-decoration: underline; }

.container { max-width: 880px; margin: 0 auto; padding: 24px 16px 56px; } h1 { font-size: 1.75rem; line-height: 1.25; margin: 0 0 8px; } p.summary { margin: 0 0 18px; color: var(--muted); } .under-construction { color: var(--muted); }

.site-footer { border-top: 1px solid var(--border); padding: 16px; text-align: center; color: var(--muted); } .site-footer small { font-size: 0.85rem; } <ここまで＜ステップ.2＞のソースコード全量>

ステップ.3: privacy.html の追加（Skeleton）

目的
プライバシーポリシーの公開用URLを提供（後日本文差し替え可）
変更ファイル一覧
パス: privacy.html / 変更種別: new / 検索アンカー: N/A / 挿入・置換: 新規作成（全量）
作業内容要約
文字列は data-i18n でi18n適用、Skeletonメッセージと最終更新日を記載
手順
privacy.html を新規作成
HTML出力時はタグを [[ と ]] に置換（後述手順で復元）
リンクは相対パスで統一
エラーハンドリング・ロギング方針
i18nロード失敗時は既定日本語を表示
リスク・注意点・フォールバック
HTMLをそのまま貼るとレンダリングされる可能性があるため、[[ / ]] 置換で回避。復元漏れに注意。
新規作成コード（HTMLはタグを [[ と ]] に置換。保存時に [[ -> <, ]] -> > に一括置換してから保存）
対象ファイル: privacy.html / 言語: HTML（角括弧置換表記） <ここから＜ステップ.3＞のソースコード全量> [[!doctype html]] [[html lang="ja"]] [[head]] [[meta charset="utf-8"]] [[meta name="viewport" content="width=device-width, initial-scale=1"]] [[title data-i18n="privacy.title"]]プライバシーポリシー[[/title]] [[link rel="stylesheet" href="legal.css"]] [[script defer src="assets/js/i18n.js"]][[/script]] [[/head]] [[body]] [[header class="site-header"]] [[nav class="site-nav"]] [[a href="index.html" data-i18n="site.nav.home"]]ホーム[[/a]] [[a href="privacy.html" data-i18n="site.nav.privacy"]]プライバシーポリシー[[/a]] [[a href="terms.html" data-i18n="site.nav.terms"]]利用規約[[/a]] [[a href="support.html" data-i18n="site.nav.support"]]サポート[[/a]] [[/nav]] [[/header]]

[[main class="container"]] [[h1 data-i18n="privacy.title"]]プライバシーポリシー[[/h1]] [[p class="summary" data-i18n="privacy.summary"]] 本アプリおよび本サイトにおける個人情報の取り扱いについて記載します。 [[/p]]

[[p class="under-construction" data-i18n="legal.underConstruction"]]
  このページは作成中です。
[[/p]]

[[p data-i18n="legal.appName"]]Focus（iOSアプリ）[[/p]]
[[/main]]

[[footer class="site-footer"]] [[small]] [[span data-i18n="legal.lastUpdated.label"]]最終更新日[[/span]]: 2025-10-22 [[/small]] [[/footer]] [[/body]] [[/html]] <ここまで＜ステップ.3＞のソースコード全量>

ステップ.4: terms.html の追加（Skeleton）

目的
利用規約の公開用URLを提供
変更ファイル一覧
パス: terms.html / 変更種別: new / 検索アンカー: N/A / 挿入・置換: 新規作成（全量）
作業内容要約
privacy.html と同構成でタイトルと本文キーを差し替え
手順
terms.html 作成 → [[ / ]] をHTMLタグに復元して保存
エラーハンドリング・ロギング方針
同上
リスク・注意点・フォールバック
同上
新規作成コード
対象ファイル: terms.html / 言語: HTML（角括弧置換表記） <ここから＜ステップ.4＞のソースコード全量> [[!doctype html]] [[html lang="ja"]] [[head]] [[meta charset="utf-8"]] [[meta name="viewport" content="width=device-width, initial-scale=1"]] [[title data-i18n="terms.title"]]利用規約[[/title]] [[link rel="stylesheet" href="legal.css"]] [[script defer src="assets/js/i18n.js"]][[/script]] [[/head]] [[body]] [[header class="site-header"]] [[nav class="site-nav"]] [[a href="index.html" data-i18n="site.nav.home"]]ホーム[[/a]] [[a href="privacy.html" data-i18n="site.nav.privacy"]]プライバシーポリシー[[/a]] [[a href="terms.html" data-i18n="site.nav.terms"]]利用規約[[/a]] [[a href="support.html" data-i18n="site.nav.support"]]サポート[[/a]] [[/nav]] [[/header]]

[[main class="container"]] [[h1 data-i18n="terms.title"]]利用規約[[/h1]] [[p class="summary" data-i18n="terms.summary"]] 本アプリのご利用条件について記載します。 [[/p]]

[[p class="under-construction" data-i18n="legal.underConstruction"]]
  このページは作成中です。
[[/p]]

[[p data-i18n="legal.appName"]]Focus（iOSアプリ）[[/p]]
[[/main]]

[[footer class="site-footer"]] [[small]] [[span data-i18n="legal.lastUpdated.label"]]最終更新日[[/span]]: 2025-10-22 [[/small]] [[/footer]] [[/body]] [[/html]] <ここまで＜ステップ.4＞のソースコード全量>

ステップ.5: support.html の追加（Skeleton）

目的
サポート窓口・ヘルプの公開用URLを提供
変更ファイル一覧
パス: support.html / 変更種別: new / 検索アンカー: N/A / 挿入・置換: 新規作成（全量）
作業内容要約
Skeleton＋問い合わせメールリンク（mailto:）を配置
手順
support.html 作成 → [[ / ]] をHTMLタグに復元して保存
エラーハンドリング・ロギング方針
同上
リスク・注意点・フォールバック
同上
新規作成コード
対象ファイル: support.html / 言語: HTML（角括弧置換表記） <ここから＜ステップ.5＞のソースコード全量> [[!doctype html]] [[html lang="ja"]] [[head]] [[meta charset="utf-8"]] [[meta name="viewport" content="width=device-width, initial-scale=1"]] [[title data-i18n="support.title"]]サポート[[/title]] [[link rel="stylesheet" href="legal.css"]] [[script defer src="assets/js/i18n.js"]][[/script]] [[/head]] [[body]] [[header class="site-header"]] [[nav class="site-nav"]] [[a href="index.html" data-i18n="site.nav.home"]]ホーム[[/a]] [[a href="privacy.html" data-i18n="site.nav.privacy"]]プライバシーポリシー[[/a]] [[a href="terms.html" data-i18n="site.nav.terms"]]利用規約[[/a]] [[a href="support.html" data-i18n="site.nav.support"]]サポート[[/a]] [[/nav]] [[/header]]

[[main class="container"]] [[h1 data-i18n="support.title"]]サポート[[/h1]] [[p class="summary" data-i18n="support.summary"]] お問い合わせ先やヘルプ情報を案内します。 [[/p]]

[[p class="under-construction" data-i18n="legal.underConstruction"]]
  このページは作成中です。
[[/p]]

[[p]]
  [[a href="mailto:35nkmr@gmail.com" data-i18n="support.contactUs"]]メールで問い合わせる[[/a]]
[[/p]]
[[/main]]

[[footer class="site-footer"]] [[small]] [[span data-i18n="legal.lastUpdated.label"]]最終更新日[[/span]]: 2025-10-22 [[/small]] [[/footer]] [[/body]] [[/html]] <ここまで＜ステップ.5＞のソースコード全量>

ステップ.6: index.html に法務リンク導線を追加

目的
トップから法務ページへ遷移可能にする
変更ファイル一覧
パス: index.html / 変更種別: modify / 検索アンカー文字列:
'
'
''（上記 icons ブロックのクローズ）
挿入・置換方針: 「icons」ブロック直後に法務リンク塊を挿入（HTMLは [[ / ]] 置換表記で示す）
作業内容要約
シンプルな3リンク行（法務リンク）を追加
手順（番号付き）
index.html を開く
検索: 一意のアンカー '
' を見つける
そのブロックの終端（対応する最初の閉じタグ '' の直後）を特定
直後に以下の挿入スニペット（[[ / ]] 表記）を貼り付け
ファイル内で [[ -> <, ]] -> > に変換は不要（index.html は元からHTMLのため、挿入スニペットのみ手動復元して貼付）
整形して保存
エラーハンドリング・ロギング方針
該当アンカー未検出の場合: 代替として 直前（最下部の閉じdiv群の直前）に挿入
リスク・注意点・フォールバック
同名の '' が多いため、必ず class="icons" の直後の閉じタグを対象にすること
スタイルは既存 style.css に依存しないミニマルな構造
修正前後コードブロック（抜粋）
対象ファイル: index.html / 言語: HTML <ここから＜ステップ.6＞の修正前コードブロック（抜粋）>

 
 
 
 
 
<ここまで＜ステップ.6＞の修正前コードブロック（抜粋）> <ここから＜ステップ.6＞の修正後コードブロック（抜粋）>
 
 
 
 
 
  <!-- Legal links -->
  <div class="legal-links" style="margin-top:12px;font-size:1.1em;">
    <!-- 以下3つのリンクは日本語で表示（英訳は Localizable.xcstrings に登録済み） -->
    <a href="privacy.html">プライバシーポリシー</a>
    <span>・</span>
    <a href="terms.html">利用規約</a>
    <span>・</span>
    <a href="support.html">サポート</a>
  </div>

</div>
</div>
<ここまで＜ステップ.6＞の修正後コードブロック（抜粋）>

パフォーマンス・セキュリティ・互換性
パフォーマンス
静的配信のみでオーバーヘッドは極小
i18nファイル1回fetch（no-store指定）。将来必要ならキャッシュ活用も検討可
セキュリティ
外部秘密・トークン不要
相対パスのみ、外部スクリプト非依存（indexは既存の外部CSS/FontAwesomeを保持、追加は無し）
mailtoリンク以外で個人情報送信は行わない
互換性
モダンブラウザ（fetch/Promise/ES6）で動作
非対応環境では既定日本語表示（フォールバック）
ダーク/ライトに応じた配色変数（color-scheme）
補足: HTML貼付時の復元ルール

本計画書の新規HTMLは、レンダリング抑止のためタグを [[ と ]] に置換して出力しています。ファイル作成時は以下の文字置換を行ってから保存してください。
[[ を < に一括置換
]] を > に一括置換