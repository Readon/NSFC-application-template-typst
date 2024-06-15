#import "@preview/cuti:0.2.1": show-cn-fakebold

#let custom-numbering(base: 1, depth: 5, first-level: auto, second-level: auto, third-level: auto, format, ..args) = {
  if (args.pos().len() > depth) {
    return
  }
  if (first-level != auto and args.pos().len() == 1) {
      if (first-level != "") {
          numbering(first-level, ..args)
      }
      return
  }
  if (second-level != auto and args.pos().len() == 2) {
      if (second-level != "") {
          numbering(second-level, args.pos().at(1))
      }
      return
  }
  if (third-level != auto and args.pos().len() == 3) {
      if (third-level != "") {
          numbering(third-level, ..args)
      }
      return
  }
  // default
  if (args.pos().len() >= base) {
      numbering(format, ..(args.pos().slice(base - 1)))
      return
  }
}

// This function gets your whole document as its `body` and formats
// it as a simple fiction book.
#let proposal(
  body,
) = {
  show: show-cn-fakebold

  let title = [报告正文]
  let headsize = 14pt
  let headfont = "KaiTi"
  let headcolor = rgb("#0070c0")

  set document(title: title)
  set text(12pt, font: ("Times New Roman", "SongTi"), lang: "zh", region: "cn")
  set page(
    paper: "a4",
    margin: (bottom: 2.5cm, top: 2.78cm, left: 3cm, right: 3cm),
  )
  set par(leading: 1em, first-line-indent: 2em, justify: true)
  show par: set block(spacing: 1.2em)

  // Configure chapter headings.  
  set heading(numbering: custom-numbering.with(base: 2, first-level: "（一）", second-level: "1. ", depth: 5, "1.1"))
  show heading.where(level: 1): it => {
    set text(headsize, font: headfont, weight: "bold", fill: headcolor)
    set par(first-line-indent: 21pt, justify: true)
    show par: set block(above: 18.2pt, below: 18.4pt)
    [#counter(heading).display()#it.body]
  }
  show heading.where(level: 2): it => {
    set text(headsize, font: headfont, weight: "medium", fill: headcolor)
    set par(leading: 12.4pt, first-line-indent: 27.5pt, justify: true)    
    show par: set block(above: 12.6pt, below: 0.2pt)
    [#counter(heading).display()#it.body]
  }

  {
    set text(headsize, font: headfont)
    {
      set text(15.5pt, font: headfont, weight: "bold")
      set align(center)
      // show par: set block(above: 8pt)
      v(-1pt)
      [*#title*]
    }

    set par(leading: 13pt, first-line-indent: 28pt, justify: true)
    show par: set block(above: 16.5pt)
    [参照以下提纲撰写，要求内容翔实、清晰，层次分明，标题突出。]
    text(weight: "bold", fill: headcolor, [请勿删除或改动下述提纲标题及括号中的文字。])
  }

  set text(11.8pt, font: ("Times New Roman", "SongTi"), lang: "zh", region: "cn")
  set par(leading: 14.5pt, first-line-indent: 24pt, justify: true)
  show par: set block(spacing: 1em, above: 14.2pt)
  body
}
