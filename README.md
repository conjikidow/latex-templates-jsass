# latex-templates-jsass

[一般社団法人日本航空宇宙学会 (The Japan Society for Aeronautical and Space Sciences, JSASS)](https://www.jsass.or.jp/) の講演集原稿用の LaTeX document class。
処理系は LuaLaTeX。

`$TEXMFLOCAL` や `$TEXMFHOME` などの texmf ツリー下（推奨），あるいは適当な場所に clone する。
後者の場合，
```latex
\documentclass{/path/to/this/latex-templates-jsass/jsass-nenkai}
```
のようにパスを指定すること。

配布されているテンプレートが MS Word で作成されたものであるため，それに合わせ MS 明朝をデフォルトとしている。Windows 以外の環境では無償で利用できるモガ明朝（推奨，要インストール）や原ノ味明朝（LuaTeX-ja 標準）など適宜変更すること。

## [年会講演会](https://branch.jsass.or.jp/nenkai/)

- [jsass-nenkai](jsass-nenkai.cls)
- 第54期（2023年）用に作成したが，書式は第50期から変わっていない
- 配布された見本
    - [PDF](sample/50_mihon.pdf)
    - [Word](sample/50_mihon.doc)
- 本テンプレートを用いた見本
    - [ソース](example/nenkai_1.tex)，[出力](example/nenkai_1.pdf)
        - 配布見本を模擬
    - [ソース](example/nenkai_2.tex)，[出力](example/nenkai_2.pdf)
        - タイトル内での改行例
        - 著者の所属が複数にわたる例
- 動作確認環境
    - TeX Live 2022 @ Ubuntu 22.04.2 LTS
    - TeX Live 2021 @ Ubuntu 20.04.5 LTS
    - Tex Live 2021 @ Windows 11
    - Tex Live 2021 @ Windows 10
    - Tex Live 2020 / W32TeX @ Windows 10

## latexmk

おまけ。ビルド用の [latekmkrc](latexmk/latexmkrc) を追加してある。
印刷時の確認用に白黒に変換した PDF も自動生成する。
[latekmkrc](latexmk/latexmkrc) をプロジェクト下にコピーすること。
