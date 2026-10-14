# 📝 mathexam

> 一个专业的 LaTeX 数学考试出题宏包

[![License](https://img.shields.io/badge/license-LPPL%201.3c-blue.svg)](http://www.latex-project.org/lppl.txt)
[![Version](https://img.shields.io/badge/version-v2.3.2-green.svg)](https://github.com/vanabel/mathexam/releases)
[![LaTeX](https://img.shields.io/badge/LaTeX-2.09%2B-orange.svg)](https://www.latex-project.org/)

`mathexam` 是一个专为数学类考试设计的 LaTeX 宏包，提供了完整的试卷排版解决方案。它能够自动生成规范的试卷格式，包括试卷头、计分表格、答题区域等，支持多种题型，并可以方便地生成试卷和参考答案。

## ✨ 主要特性

### 📋 题型支持
- ✅ **选择题** - 支持 A/B/C/D 选项，自动排版
- 📝 **填空题** - 支持单空和多空填空
- ✓ **判断题** - 支持对错判断
- 🔢 **计算题** - 提供答题空白区域
- 📐 **证明题** - 支持分步评分

### 🎨 自动排版
- 📊 **自动生成计分表格** - 根据大题数量自动生成试卷头计分表格
- 📄 **试卷头信息** - 自动生成包含学校、课程、考试时间等信息的试卷头
- 📈 **自动统计** - 自动统计总题数、总分值、总页数
- 🔄 **数据库管理** - 使用 datatool 自动管理题目数据

### 🎯 实用功能
- 👁️ **答案显示/隐藏** - 通过 `showans` 选项控制答案显示
- 📑 **A3 纸张支持** - 支持 A3 纸张双页打印
- 📝 **草稿纸** - 可选的草稿纸功能
- 📋 **答题卡** - 提供标准答题卡格式
- 🎨 **灵活布局** - 支持自定义答题区域空白高度

## 🚀 快速开始

### 安装

1. 下载 `mathexam.sty` 文件
2. 将其放置在工作目录或 TeX 搜索路径中

### 基本使用

```latex
\documentclass[zihao=-4]{article}
\usepackage{mathexam}

% 设置试卷基本信息
\university{西南大学}
\school{数学与统计学院}
\course{高等数学}
\AorB{A}
\finalmiddle{期末}
\totaltime{120}
\openclose{闭卷}
\degree{本科}

\begin{document}
\makehead

% 选择题部分
\begin{makepart}{单项选择题}[3]
  \begin{problem}
    函数 $f(x,y)=\sqrt{x^2+y^2}$ 在 $(0,0)$ 处\pickout{B}
    \begin{abcd}
      \item 连续且可微
      \item 连续但不可微
      \item 不连续
      \item 可微但不连续
    \end{abcd}
  \end{problem}
\end{makepart}

% 填空题部分
\begin{makepart}{填空题}[3]
  \begin{problem}
    假设 $f(u)$ 是连续函数，则 $F(t)=\iiint_{x^2+y^2+z^2\leq t^4} 
    f(x^2+y^2+z^2)dxdydz$ 的导数 $F'(1)=$\fillin{$8\pi f(1)$}
  \end{problem}
\end{makepart}

% 计算题部分
\begin{makepart}{计算题}[10]
  \begin{problem}[10]
    计算二重积分 $\iint_D x^2+y^2 dxdy$，其中 $D$ 是单位圆。
    \begin{solution}[6em]
      使用极坐标变换...\score{5}
      计算得结果为 $\frac{\pi}{2}$.\score{5}
    \end{solution}
  \end{problem}
\end{makepart}

\end{document}
```

### 编译

```bash
latexmk -xelatex -shell-escape mathexam-main.tex
```

## 📖 详细文档

### 包选项

| 选项 | 说明 |
|------|------|
| `showans` | 显示答案（用于生成参考答案） |
| `a3paper` | A3 纸张模式（双页打印） |
| `fixlast` | 修复奇数页时的格式问题 |
| `nospace` | 解答题不留空白 |
| `caogaozhi` | 在试卷末尾添加草稿纸 |

### 主要命令

#### 试卷信息设置
```latex
\university{学校名称}
\school{学院名称}
\course{课程名称}
\AorB{A}              % 试卷类型（A 或 B）
\finalmiddle{期末}    % 考试类型
\totaltime{120}       % 考试时间（分钟）
\openclose{闭卷}      % 开卷/闭卷
\degree{本科}         % 学生类别
\major{专业名称}      % 适用专业
\grade{2020}          % 年级
```

#### 题型环境

**选择题**
```latex
\begin{problem}
  题目内容\pickout{A}  % A/B/C/D
  \begin{abcd}
    \item 选项 A
    \item 选项 B
    \item 选项 C
    \item 选项 D
  \end{abcd}
\end{problem}
```

**填空题**
```latex
\begin{problem}
  题目内容\fillin{答案}  % 单空填空
  或者\fillout{答案}     % 填充到行末
\end{problem}
```

**判断题**
```latex
\begin{problem}
  题目内容\true   % 或 \false
\end{problem}
```

**解答题**
```latex
\begin{problem}[10]  % 分值
  题目内容
  \begin{solution}[6em]  % 空白高度
    解答内容
    \score{5}  % 分步评分
  \end{solution}
\end{problem}
```

**答题卡**
```latex
\answertable[1em]{答案数量}{每行答案数}
```

## 📦 项目结构

```
mathexam/
├── mathexam.dtx          # 源文件（包含文档和代码）
├── mathexam.sty          # 生成的宏包文件
├── mathexam.pdf          # 完整文档
├── mathexam-main.tex     # 示例试卷
├── mathexam-main.pdf     # 示例试卷 PDF
├── mathexam-main-answer.tex  # 示例参考答案
├── mathexam-main-answer.pdf  # 示例参考答案 PDF
├── Makefile              # 构建脚本
└── README.md             # 本文件
```

## 🔧 构建

使用提供的 Makefile：

```bash
make          # 生成所有文件
make pkg      # 仅生成 .sty 文件
make doc      # 仅生成文档
make main     # 生成示例试卷
make clean    # 清理临时文件
```

## 📝 更新日志

### v2.3.2 (2026/10/14)
- 🐛 为未设置的试卷信息宏提供默认空值，避免 `Undefined control sequence`
- 🐛 移除 `showans` 在宏包加载时错误执行的 PDF 复制（XeLaTeX 下 PDF 尚不存在）
- 🐛 修正重复且过时的 `\ProvidesPackage` 声明
- 🐛 `make pkg` 不再覆盖手写维护的 `README.md`
- 🐛 修复 a3paper 使用未加载的 `\AtBeginShipout`（改为 eso-pic 每页背景）

### v2.3.1 (2025/11/22)
- ✨ 改进 datatool 相关代码，修复数值累加问题
- 🐛 修复总页数计算，使用 `\@abspage@last` 确保准确性
- 🔄 更新数据库保存方法，使用更标准的 `\DTLwrite` API
- 🐛 修复 a3paper 模式下的页眉/页脚线条定位和旋转表格显示问题

### v2.3.0 (2020/12/12)
- ✨ 添加答题卡命令 `\answertable`
- ✨ 添加 `caogaozhi` 选项，支持草稿纸
- ✨ 添加 `nospace` 选项，解答题不留空白

### v2.2.0 (2020/07/03)
- ✨ 自动根据大题总数生成试卷头计分表格

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目采用 [LaTeX Project Public License (LPPL) v1.3c](http://www.latex-project.org/lppl.txt) 许可证。

## 👤 作者

**Van Abel**
- Email: van141.abel@gmail.com
- GitHub: [@vanabel](https://github.com/vanabel)

## 🙏 致谢

本项目最初开发于上海交通大学，用于准备期中考试。感谢所有贡献者和使用者！

---

⭐ 如果这个项目对你有帮助，请给个 Star！
