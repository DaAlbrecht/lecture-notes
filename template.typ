#let project(title: "", header:"", body) = {
  let authors = ("David",);
  let school = "FFHS - Fernfachhochschule Schweiz";
  let degree = "BsC in Cyber Security";
  let date = "2024";

  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center, header: align(center, header))
  set text(font: "Berkeley Mono", size: 11pt,spacing: 80%)
  show raw: set text(font: "Berkeley Mono", size: 11pt, spacing: 100%)
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

  outline(title: "Table of contents", depth: 3, indent: true)

  pagebreak()

  // Main body.
  set par(justify: true)
  body
}

#let classes = ("Definition", "Example", "Statement")
#let h1_marker = counter("h1")
#let h2_marker = counter("h2")

#let note_block(body, class: "Block", fill: rgb("#FFFFFF"), stroke: rgb("#000000")) = {
  let block_counter = counter(class)

  locate(loc => {
    // Returns the serial number of the current block
    // The format is just like "Definition 1.3.1"
    let serial_num = (
    h1_marker.at(loc).last(),
    h2_marker.at(loc).last(),
    block_counter.at(loc).last() + 1)
    .map(str)
    .join(".")

    let serial_label = label(class + " " + serial_num)
        

    block(fill:fill,
    width: 100%,
    inset:8pt,
    radius: 4pt,
    stroke:stroke,
    body)
    v(-8pt)
    text(10pt, weight: "bold")[#class #serial_num #serial_label #block_counter.step()]
    v(2pt)
  })
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

#let fill_alternating(x, y) = {
  if calc.even(y) {
     return rgb("#F5F5F5")
  }
  else{
    return rgb("#FFFFFF")
  }
}

