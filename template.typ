#let project(title: "",  body) = {
  let authors = ("David",);
  let school = "FFHS - Fernfachhochschule Schweiz";
  let degree = "BsC in Cyber Security";
  let date = "2024";

  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Berkeley Mono", lang: "en")
  set heading(numbering: "1.1")

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

  // Table of contents.
  outline(title: "Table of contents", depth: 3, indent: true)
  pagebreak()
  outline(title: "List of figures", target: figure.where(kind: image))
  outline(title: "List of tables", target: figure.where(kind: table))
  outline(title: "List of listings", target: figure.where(kind: raw))

  pagebreak()

  // Main body.
  set par(justify: true)
  body
  pagebreak()
}
