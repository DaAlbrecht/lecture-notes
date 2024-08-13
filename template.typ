#let project(title: "",  body) = {
  let authors = ("David",);
  let school = "FFHS - Fernfachhochschule Schweiz";
  let degree = "BsC in Cyber Security";
  let date = "2024";

  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Berkeley Mono", lang: "en", size: 12pt)
  set heading(numbering: "1.1")

  show math.equation: set text(style: "italic")



[
  #set align(center)
  #text(school)
  #linebreak()
  #text(degree)
  #linebreak()
]

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  v(3.6fr)
  text(1.1em, date)
  v(1.2em, weak: true)
  text(2em, weight: 700, title)

  // Author information.
  pad(top: 0.7em, right: 20%, grid(
    columns: (1fr,) * calc.min(3, authors.len()),
    gutter: 1em,
    ..authors.map(author => align(start, strong(author))),
  ))
  v(2.4fr)

  pagebreak()

  // Main body.
  set par(justify: true)
  body
}

#let note_block(body, class: "Block", fill: rgb("#FFFFFF"), stroke: rgb("#000000")) = {
  block(fill:fill,
  width: 100%,
  inset:8pt,
  radius: 4pt,
  stroke:stroke,
  body)
}

#let example(body) = note_block(
  body, class: "Example", fill: rgb("#F5F5F5"), stroke: none 
)

#let definition(body) = note_block(
  body, class: "Definition", fill: rgb("#F2F6FE"), stroke: rgb("#6983EE")
)

#let statement(body) = note_block(
  body, class: "Statement", fill: rgb("#FEF2F4"), stroke: rgb("#EE6983")
)

