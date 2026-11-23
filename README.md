# 論文テンプレート（特定課題研究 報告書・修士論文）

[English version below](#english)

卒論（特定課題研究 報告書）・修論を LaTeX で作成するためのテンプレートです。日本語・英語の両方に対応しています。Overleaf での利用も可能です。

[Overleaf で開く](https://www.overleaf.com/docs?snip_uri=https%3A%2F%2Fgithub.com%2Ffomlab%2Fthesis-template%2Freleases%2Flatest%2Fdownload%2Fthesis-template.zip)

上のリンクから、このテンプレートを Overleaf の新しいプロジェクトとして開くことができます。リンクから開けない場合は、下の「使い方」の手順で ZIP ファイルを保存し、Overleaf にアップロードしてください。

このテンプレートは、東京工業大学（現・東京科学大学）環境・社会理工学院 融合理工学系 カリキュラム委員会「特定課題研究 研究報告書の執筆様式について（ガイドライン）2021年度版」（2021年6月）をもとに作成したものです。大学や系が公式に配布しているテンプレートではありません。

This template is based on "Guidelines in Preparing the Independent Research Project (IRP) report in English (for AY 2021)" (June 2021) by the GSEP faculty group and the Curriculum Committee, Department of Transdisciplinary Science and Engineering, School of Environment and Society, Tokyo Institute of Technology (now Institute of Science Tokyo). It is not an official template distributed by the university or the department.

書式の細部について指導教員から指示がある場合は、その指示に従ってください。

## 使い方

1. このページの緑の「Code」ボタンから「Download ZIP」を選び、ZIP ファイルを保存します（展開する必要はありません）。
2. [Overleaf](https://www.overleaf.com/) で「New project」→「Existing project (.zip)」を選び、「Upload Zipped Project」の画面で、保存した ZIP ファイルをアップロードします。
3. 「Recompile」を押し、見本の PDF が表示されることを確認します。
4. `main.tex` の冒頭にある「設定」を、自分の論文の内容に書き換えます。
5. 本文は `ja/` フォルダー（英語の場合は `en/` フォルダー）のファイルに書きます。

## 設定

`main.tex` の冒頭にある次の部分だけを書き換えます。

```latex
\documentclass[
  ja,        % 言語 / language:   ja（日本語）または en（English）
  bachelor,  % 種別 / kind:       bachelor（特定課題研究 報告書）または master（修士論文）
]{labthesis}

\title{論文の題目をここに書く}           % 題目 / title（改行は \\）
\author{山田 太郎}                       % 名前 / name（英語は Given SURNAME: Taro YAMADA）
\supervisor{○○ ○○ 教授}                % 指導教員 / supervisor（英語は Prof. Given SURNAME）
\submitdate{2027}{1}                     % 提出年月 / submission {year}{month}
\affiliation{%                           % 所属（英語のみ）/ affiliation (English only)
  Department of Transdisciplinary Science and Engineering\\
  School of Environment and Society\\
  Institute of Science Tokyo}
% \citationstyle{Harvard 形式（著者・年方式）}   % 引用形式の書き換え / citation style line
```

| 書き換えるところ | 書き方 |
| --- | --- |
| 言語 | 日本語は `ja`、英語は `en` を指定します。`en` にすると、本文には `en/` フォルダーのファイルが使われ、書式も英語版のガイドラインに準拠したものになります。表紙の題目、名前、指導教員は自動では英語に切り替わらないため、英語で書き直してください。 |
| 種別 | 卒論は `bachelor`（表紙は「特定課題研究　報告書」）、修論は `master`（表紙は「修士論文」）を指定します。 |
| 題目、名前、指導教員 | 英語の名前は Taro YAMADA のように、名を先に、姓をすべて大文字で書きます。 |
| 提出年月 | `{2027}{1}` と書くと、2027年1月（英語では January 2027）と表示されます。 |
| 所属 | 英語の表紙にのみ表示されます。 |
| 引用形式 | 既定は Harvard 形式（著者・年方式）です。`% \citationstyle{Harvard 形式（著者・年方式）}` の `%` を外して書き換えます。日本語では最後のページに「引用形式：○○に準拠」、英語では目次の下に「Citation style: ○○」と表示されます。 |
| 見出しの形 | 既定は「第1章／1.1／1.1.1」です。`bachelor,` の下に `heading-simple,`（1．／1)／(1)）または `heading-setsu,`（第1章／第1節／第1項）を追加すると、見出しの形式を切り替えることができます。 |

表紙、要約、目次、図一覧、表一覧にはページ番号が付かず、第1章の最初のページが 1 ページになります。図、表、式の番号は章ごとに自動で付きます。

## ファイルの構成

| ファイル | 中身 |
| --- | --- |
| `main.tex` | 設定と全体の構成。 |
| `ja/`、`en/` | 本文（要約 `abstract.tex`、各章 `chapter1.tex` など、付録 `appendix.tex`）。 |
| `figures/` | 図のファイル。 |
| `refs.bib` | 参考文献のデータ。 |
| `labthesis.cls` | 書式の設定（通常は編集しません）。 |
| `latexmkrc` | Overleaf でコンパイルするための設定（削除しないでください）。 |
| `jecon.bst` | 参考文献の書式（通常は編集しません）。 |

## 書き方の例

章を追加する場合は、`ja/chapter4.tex` のようなファイルを作成し、`main.tex` に `\input{\textfolder/chapter4}` の行を追加します。

### 章・節・項

```latex
\chapter{序論}\label{chap:intro}
\section{研究の背景}
\subsection{項の見出し}
```

### 図

図のファイル（PDF、PNG、JPEG のいずれか）を `figures/` にアップロードしてから、次のように書きます。ファイル名に空白が含まれていると図が表示されないため、`fig1.png` のような名前にしてください。キャプションは図の下に置きます。

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.7\linewidth]{figures/sample-chart.pdf}
  \caption{棒グラフの例}\label{fig:sample}
  \source{著者による}
\end{figure}
```

本文で `\figref{fig:sample}` と書くと、「図 2.1」（英語では Fig. 2.1）と表示されます。`\source{...}` は出典を示す行で、不要な場合は削除してください。

### 表

キャプションは表の上に置きます。

```latex
\begin{table}[htbp]
  \centering
  \caption{表の例}\label{tab:sample}
  \begin{tabular}{lrr}
    \hline
    項目   & 値 A & 値 B \\
    \hline
    項目 1 & 1.2 & 3.4 \\
    項目 2 & 2.3 & 4.5 \\
    \hline
  \end{tabular}
\end{table}
```

本文で `\tabref{tab:sample}` と書くと、「表 3.1」（英語では Table 3.1）と表示されます。

### 式

```latex
\begin{equation}
  F(x) = \int_{0}^{1} x^{2} \, dx
  \label{eq:sample}
\end{equation}
```

式の番号は、「（式 2-1）」（英語では (Eq. 2.1)）の形で式の右側に付きます。本文で `\eqref{eq:sample}` と書くと、「式 2-1」（英語では Eq. (2.1)）と表示されます。

### 文献の引用

`refs.bib` に文献のデータを追加します。Zotero などの文献管理ソフトから BibTeX 形式で書き出したデータを貼り付けることも可能です。日本語の文献には `yomi`（読み）を記入すると、正しい順に並びます。

```bibtex
@book{okumura2020,
  author    = {奥村, 晴彦 and 黒木, 裕介},
  yomi      = {おくむら, はるひこ and くろき, ゆうすけ},
  title     = {[改訂第8版] \LaTeXe 美文書作成入門},
  publisher = {技術評論社},
  year      = {2020}
}
```

本文では次のように引用します。

```latex
\citet{okumura2020}によれば……      % → 奥村・黒木 (2020) によれば……
……である\citep{lamport1994}。      % → ……である (Lamport, 1994)。
```

本文の後の参考文献一覧には、引用した文献のみが表示されます。

## うまくいかないとき

- 赤いエラーが出た場合は、表示された行の付近で、`{` と `}` の数、`\` の打ち間違い、全角の空白や記号の混入がないかを確認してください。
- 「This template must be compiled with upLaTeX」というエラーは、`latexmkrc` がプロジェクトから削除されていると表示されます。このテンプレートの ZIP から `latexmkrc` だけを取り出し、Overleaf の「Upload」で `main.tex` と同じ場所にアップロードし直してください。
- 図が表示されず「Cannot determine size of graphic」と表示された場合は、図のファイル名に空白が含まれていないかを確認してください。
- 英語のガイドラインでは、付録を含めて 25 ページ以上が目安とされています。

## ライセンス

MIT License（`LICENSE` を参照してください）。ただし、`jecon.bst`（作者：武田史郎）は LaTeX Project Public License 1.3 で配布されているファイルを改変せずに同梱したもので、同ライセンスに従います（<https://github.com/ShiroTakeda/jecon-bst>）。

---

<a id="english"></a>

## English

A LaTeX template for the bachelor's Independent Research Project (IRP) report and the master's thesis, supporting both Japanese and English. It can also be used on Overleaf.

[Open in Overleaf](https://www.overleaf.com/docs?snip_uri=https%3A%2F%2Fgithub.com%2Ffomlab%2Fthesis-template%2Freleases%2Flatest%2Fdownload%2Fthesis-template.zip)

This link opens the template as a new project in Overleaf. If it does not work, download the ZIP and upload it to Overleaf as described in "How to use" below.

This template is based on "Guidelines in Preparing the Independent Research Project (IRP) report in English (for AY 2021)" (June 2021) by the GSEP faculty group and the Curriculum Committee, Department of Transdisciplinary Science and Engineering, School of Environment and Society, Tokyo Institute of Technology (now Institute of Science Tokyo). It is not an official template distributed by the university or the department.

If your supervisor gives different instructions on the format, follow them.

### How to use

1. On this page, click the green "Code" button, choose "Download ZIP", and save the file (no need to unzip it).
2. In [Overleaf](https://www.overleaf.com/), choose "New project" → "Existing project (.zip)" and upload the ZIP file in the "Upload Zipped Project" window.
3. Click "Recompile" and check that the sample PDF appears.
4. At the top of `main.tex`, change `ja` to `en`, choose `bachelor` or `master`, and fill in your title, name (Given SURNAME, e.g. Taro YAMADA), supervisor (e.g. Prof. Given SURNAME), submission year and month, and affiliation.
5. Write your text in the files in the `en/` folder.

The title page, abstract, table of contents, list of figures and list of tables have no page numbers, and the first page of Chapter 1 is page 1. Figures, tables and equations are numbered by chapter. The examples in the Japanese section above also work in English mode: `\figref{...}` gives "Fig. 2.1", `\tabref{...}` gives "Table 3.1", and `\eqref{...}` gives "Eq. (2.1)". The default citation style is Harvard style (author-date). To change the citation style line below the table of contents, remove the `%` before `\citationstyle{...}` and edit it. The guideline suggests at least 25 pages including appendices.

If you see "This template must be compiled with upLaTeX", the file `latexmkrc` is missing: take it from the template's ZIP and upload it again to the top level of the project (next to `main.tex`). If a figure does not appear and you see "Cannot determine size of graphic", remove any spaces from the figure's file name.

License: MIT (see `LICENSE`). `jecon.bst` by Shiro Takeda is included unchanged under the LaTeX Project Public License 1.3.
