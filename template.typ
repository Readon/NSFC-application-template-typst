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
  let title = [报告正文]
  let headsize = 14pt
  let headfont = "KaiTi"

  set document(title: title)
  set text(12pt, font: ("Times New Roman", "SongTi"), lang: "zh", region: "cn")
  set page(
    paper: "a4",
    numbering: "1",
    margin: (bottom: 2.5cm, top: 2.5cm, left: 3cm, right: 3cm),
  )
  set par(leading: 1.3em, first-line-indent: 24pt, justify: true)
  show par: set block(spacing: 1em)

  // Configure chapter headings.  
  set heading(numbering: custom-numbering.with(base: 2, first-level: "（一）", second-level: "1. ", depth: 5, "1.1"))
  show heading.where(level: 1): it => {
    set text(headsize, font: headfont, weight: "bold", fill: blue)
    set par(first-line-indent: 22pt, justify: true)
    v(0.2em)
    [#counter(heading).display()#it.body]
    v(0.3em)
  }
  show heading.where(level: 2): it => {
    set text(headsize, font: headfont, weight: "bold", fill: blue)
    set par(leading: 0.9em, first-line-indent: 28pt, justify: true)
    [#counter(heading).display()#it.body]
  }

  {
    set text(headsize, font: headfont, weight: "bold")
    set par(leading: 0.9em, first-line-indent: 28pt, justify: true)
    {
      set text(16pt, font: headfont, weight: "bold")
      set align(center)
      v(0.45em)
      [*#title*]
    }
    
    [参照以下提纲撰写，要求内容翔实、清晰，层次分明，标题突出。]
    text(fill: blue, [请勿删除或改动下述提纲标题及括号中的文字。])
  }

  body
}
