#import "leipzig-gloss.typ": abbreviations, gloss, numbered-gloss, gloss-count

#show link: x => underline[*#x*]

#let codeblock-old(contents) = block(fill: luma(230), inset: 8pt, radius: 4pt, breakable: false, contents)

#let codeblock(contents, addl-bindings: (:)) = {
    eval(contents, mode: "markup", scope: (gloss: gloss, numbered-gloss: numbered-gloss) + addl-bindings)
    block(fill: luma(230), inset: 8pt, radius: 4pt, breakable: false, raw(contents, lang: "typst"))
}

#let codeblock-no-eval(contents) = {
    block(fill: luma(230), inset: 8pt, radius: 4pt, breakable: false, raw(contents, lang: "typst"))
}

// Abbreviations used in this document

#import abbreviations: poss, prog, sg, pl, sbj, obj, fut, neg, obl, gen, com, ins, all, pst, inf
#import abbreviations: art, dat, du, A, P, prf

#let fmnt = abbreviations.emit-abbreviation("FMNT")


= Introduction

Interlinear morpheme-by-morpheme glosses are common in linguistic texts to give
information about the meanings of individual words and morphemes in the
language being studied. A set of conventions called the *Leipzig Glossing Rules*
was developed to give linguists a general set of standards and principles for
how to format these glosses. The most recent version of these rules can be
found in PDF form at
#link("https://www.eva.mpg.de/lingua/pdf/Glossing-Rules.pdf")[this link],
provided by the Department of Linguistics at the Max Planck Institute for
Evolutionary Anthropology.

There is a staggering variety of LaTex packages designed to properly align and
format glosses (including `gb4e`, `ling-macros`, `linguex`, `expex`, and
probably even more). These modules vary in the complexity of their syntax and
the amount of control they give to the user of various aspects of formatting.
The `typst-leipzig-glossing` module is designed to provide utilities for
creating aligned Leipzig-style glosses in Typst, while keeping the syntax as
intuitive as possible and allowing users as much control over how their glosses
look as is feasible.

This PDF will show examples of the module's functionality and detail relevant
parameters. For more information or to inform devs of a bug or other issue,
visit the module's Github repository
#link("https://github.com/neunenak/typst-leipzig-glossing")

#show raw: x => highlight(fill: luma(230), extent: 1pt)[#x]

= Basic glossing functionality


As a first example, here is a gloss of a text in Georgian, along with the Typst code used to generate it:


#codeblock(
"#gloss(
    header: [from \"Georgian and the Unaccusative Hypothesis\", Alice Harris, 1982],
    source: ([ბავშვ-ი], [ატირდა]),
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
)")


And an example for English which exhibits some additional styling, and uses imports from another file
for common glossing abbreviations:

#codeblock(
"#gloss(
  source: ([I'm], [eat-ing], [your], [head]),
  source-style: (item) => text(fill: red)[#item],
  morphemes: ([1#sg.#sbj\=to.be], [eat-#prog], [2#sg.#poss], [head]),
  morphemes-style: text.with(size: 10pt, fill: blue),
  translation: text(weight: \"semibold\")[I'm eating your head!],
  translation-style: (item) => [\"#item\"],
)
", addl-bindings: (poss: poss, prog: prog, sg: sg, sbj: sbj))


The `#gloss` function has three pre-defined parameters for glossing levels:
`source`, `transliteration`, and `morphemes`. It also has two parameters
for unaligned text: `header` for text that precedes the gloss, and
`translation` for text that follows the gloss.


The `morphemes` param can be skipped, if you just want to provide a source
text and translation, without a gloss:

#codeblock(
"#gloss(
    source: ([Trato de entender, debo comprender, qué es lo que ha hecho conmigo],),
    source-style: emph,
    translation: [I try to understand, I must comprehend, what she has done with me],
)
")


Note that it is still necessary to wrap the `source` argument in an array of length one.


To add more than three glossing lines, there is an additional parameter
`additional-lines` that can take a list of arbitrarily many more glossing
lines, which will appear below those specified in the aforementioned
parameters:

#codeblock(
"#gloss(
    header: [Hunzib (van den Berg 1995:46)],
    source: ([ождиг],[хо#super[н]хе],[мукъер]),
    transliteration: ([oʒdig],[χõχe],[muqʼer]),
    morphemes: ([ož-di-g],[xõxe],[m-uq'e-r]),
    additional-lines: (
        ([boy-#smallcaps[obl]-#smallcaps[ad]], [tree(#smallcaps[g4])], [#smallcaps[g4]-bend-#smallcaps[pret]]),
        ([at boy], [tree], [bent]),
    ),
    translation: [\"Because of the boy, the tree bent.\"]
)
")



== Numbering Glosses

The `gloss` function takes a boolean parameter `numbering` which will add an incrementing
count to each gloss. A function `numbered-gloss` is exported for convenience; this is
defined as simply `#let numbered-gloss = gloss.with(numbering: true)`, and is called with the
same arguments as `gloss`:


#codeblock(
"#gloss(
    source: ([გვ-ფრცქვნ-ი],),
    transliteration: ([gv-prtskvn-i],),
    morphemes: ([1#pl.#obj\-peel-#fmnt],),
    translation: \"You peeled us\",
    numbering: true,
)

#numbered-gloss(
    source: ([მ-ფრცქვნ-ი],),
    transliteration: ([m-prtskvn-i],),
    morphemes: ([1#sg.#obj\-peel-#fmnt],),
    translation: \"You peeled me\",
)

", addl-bindings: (pl: pl, obj: obj, sg: sg, fmnt: fmnt))

The displayed number for numbered glosses is iterated for each numbered gloss
that appears throughout the document. Unnumbered glosses do not increment the
counter for the numbered glosses.

The gloss count is controlled by the Typst counter variable `gloss-count`. This
variable can be imported from the `leipzig-gloss` package and manipulated using the
standard Typst counter functions to control gloss numbering:

#codeblock(
"#gloss-count.update(20)

#numbered-gloss(
    header: [from _Standard Basque: A Progressive Grammar_ by Rudolf de Rijk, quoting P. Charriton],
    source: ([Bada beti guregan zorion handi baten nahia.],),
    translation: [There always is in us a will for a great happiness.],
)", addl-bindings: (gloss-count: gloss-count))


== Styling lines of a gloss

Each of the aforementioned text parameters has a corresponding style parameter,
formed by adding `-style` to its name: `header-style`, `source-style`,
`transliteration-style`, `morphemes-style`, and `translation-style`. These parameters
allow you to specify formatting that should be applied to each entire line of
the gloss. This is particularly useful for the aligned gloss itself, since
otherwise one would have to modify each content item in the list individually.

In addition to these parameters, Typst’s usual content formatting can be applied
to or within any given content block in the gloss. Formatting applied in this
way will override any contradictory line-level formatting.

#codeblock(
"#gloss(
    header: [This text is about eating your head.],
    header-style: text.with(weight: \"bold\", fill: green),
    source: (text(fill:black)[I'm], [eat-ing], [your], [head]),
    source-style: text.with(style: \"italic\", fill: red),
    morphemes: ([1#sg.#sbj\=to.be], text(fill:black)[eat-#prog], [2#sg.#poss], [head]),
    morphemes-style: text.with(fill: blue),
    translation: text(weight: \"bold\")[I'm eating your head!],
)", addl-bindings: (prog: prog, sbj: sbj, poss: poss, sg: sg))

//TODO add `line_styles` param

= Standard Abbreviations

The Leipzig Glossing Rules define a commonly-used set of short abbreviations
for grammatical terms used in glosses, such as #abbreviations.acc for
"accusative (case)", or #abbreviations.ptcp for "participle". By convention,
these are typeset using #smallcaps[smallcaps]. This package contains a module value `abbreviations`. Individual abbreviations may be accessed either
with Typst field access notation or by importing them from `abbreviations`:


#gloss(
    header: [(from _Why Caucasian Languages?_, Bernard Comrie, in _Endangered Languages of the Caucasus and Beyond_)],
    source: ([\[qálɐ-m], [∅-kw’-á\]], [ɬ’ə́-r]),
    morphemes: ([city-#obl], [3#sg\-go-#prf], [man-#abbreviations.abs]),
    translation: "The man who went to the city."
)

#codeblock-no-eval(
"#import \"leipzig-gloss.typ\": abbreviations
#import abbreviations: obl, sg, prf

#gloss(
    header: [(from _Why Caucasian Languages?_, by Bernard Comrie, in _Endangered Languages of the Caucasus and Beyond_)],
    source: ([\[qálɐ-m], [∅-kw’-á\]], [ɬ’ə́-r]),
    morphemes: ([city-#obl], [3#sg\-go-#prf], [man-#abbreviations.abs]),
    translation: \"The man who went to the city.\"
)")

The full list of abbreviations available is identical to the list in "Appendix:
List of Standard Abbreviations" of the Leipzig Glossing Rules document.
//TODO document this in full somewhere


= Further Example Glosses

These are the first twelve example glosses given in #link("https://www.eva.mpg.de/lingua/pdf/Glossing-Rules.pdf").
along with the Typst markup needed to generate them:

#{
    gloss-count.update(0)
}

#codeblock(
"#numbered-gloss(
    header: [Indonesian (Sneddon 1996:237)],
    source: ([Mereka], [di], [Jakarta], [sekarang.]),
    morphemes: ([they], [in], [Jakarta], [now]),
    translation: \"They are in Jakarta now\",
)")

#codeblock(
"#numbered-gloss(
    header: [Lezgian (Haspelmath 1993:207)],
    source: ([Gila], [abur-u-n], [ferma], [hamišaluǧ], [güǧüna], [amuq’-da-č.]),
    morphemes: ([now], [they-#obl\-#gen], [farm], [forever], [behind], [stay-#fut\-#neg]),
    translation: \"Now their farm will not stay behind forever.\",
)", addl-bindings: (fut: fut, neg: neg, obl: obl, gen:gen))

#codeblock(
"#numbered-gloss(
    header: [West Greenlandic (Fortescue 1984:127)],
    source: ([palasi=lu], [niuirtur=lu]),
    morphemes: ([priest=and], [shopkeeper=and]),
    translation: \"both the priest and the shopkeeper\",
)")

#codeblock(
"#numbered-gloss(
    header: [Hakha Lai],
    source: ([a-nii -láay],),
    morphemes: ([3#sg\-laugh-#fut],),
    translation: [s/he will laugh],
)", addl-bindings: (sg: sg, fut: fut))

#codeblock(
"#numbered-gloss(
    header: [Russian],
    source: ([My], [s], [Marko], [poexa-l-i], [avtobus-om], [v], [Peredelkino]),
    morphemes: ([1#pl], [#com], [Marko], [go-#pst\-#pl], [bus-#ins], [#all], [Peredelkino]),
    additional-lines: (([we], [with], [Marko], [go-#pst\-#pl], [bus-by], [to], [Peredelkino]),),
    translation: \"Marko and I went to Perdelkino by bus\",
)", addl-bindings: (com: com, pl: pl, ins: ins, all: all, pst:pst))

#codeblock(
"#numbered-gloss(
    header: [Turkish],
    source: ([çık-mak],),
    morphemes: ([come.out-#inf],),
    translation: \"to come out\",
)", addl-bindings: (inf: inf))

#codeblock(
"#numbered-gloss(
    header: [Latin],
    source: ([insul-arum],),
    morphemes: ([island-#gen\-#pl],),
    translation: \"of the islands\",
)", addl-bindings: (gen:gen, pl: pl))

#codeblock(
"#numbered-gloss(
    header: [French],
    source: ([aux], [chevaux]),
    morphemes: ([to-#art\-#pl],[horse.#pl]),
    translation: \"to the horses\",
)",addl-bindings: (art:art, pl:pl))

#codeblock(
"#numbered-gloss(
    header: [German],
    source: ([unser-n], [Väter-n]),
    morphemes: ([our-#dat\-#pl],[father.#pl\-#dat.#pl]),
    translation: \"to our fathers\",
)", addl-bindings: (dat:dat, pl:pl))

#codeblock(
"#numbered-gloss(
    header: [Hittite (Lehmann 1982:211)],
    source: ([n=an], [apedani], [mehuni],[essandu.]),
    morphemes: ([#smallcaps[conn]=him], [that.#dat.#sg], [time.#dat.#sg], [eat.they.shall]),
    translation: \"They shall celebrate him on that date\",
)", addl-bindings: (pl:pl, sg:sg, dat:dat))

#codeblock(
"#numbered-gloss(
    header: [Jaminjung (Schultze-Berndt 2000:92)],
    source: ([nanggayan], [guny-bi-yarluga?]),
    morphemes: ([who], [2#du.#A.3#sg.#P\-#fut\-poke]),
    translation: \"Who do you two want to spear?\",
)", addl-bindings: (du:du, sg:sg, fut:fut, A:A, P:P))
