#import "leipzig-gloss.typ": gloss, numbered-gloss, gloss-count
#import "linguistic-abbreviations.typ": *

#show link: x => underline[*#x*]
//#show raw: x => text(fill: rgb("#43464b"))[#x]

#let codeblock-old(contents) = block(fill: luma(230), inset: 8pt, radius: 4pt, breakable: false, contents)

#let codeblock(contents, addl-bindings: (:)) = {
    eval(contents, mode: "markup", scope: (gloss: gloss, numbered-gloss: numbered-gloss) + addl-bindings)
    block(fill: luma(230), inset: 8pt, radius: 4pt, breakable: false, raw(contents, lang: "typst"))
}

#let fmnt = emit-abbreviation("FMNT")


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

= Basic glossing functionality


As a first example, here is a gloss of a text in Georgian, along with the Typst code used to generate it:


#codeblock(
"#gloss(
    header_text: [from \"Georgian and the Unaccusative Hypothesis\", Alice Harris, 1982],
    source_text: ([ბავშვ-ი], [ატირდა]),
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
)")


And an example for English which exhibits some additional styling, and uses imports from another file
for common glossing abbreviations:

#codeblock(
"#gloss(
  source_text: ([I'm], [eat-ing], [your], [head]),
  source_text_style: (item) => text(fill: red)[#item],
  morphemes: ([1#sg.#sbj\=to.be], [eat-#prog], [2#sg.#poss], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: \"semibold\")[I'm eating your head!],
)
", addl-bindings: (poss: poss, prog: prog, sg: sg, sbj: sbj))


The `#gloss` function has three pre-defined parameters for glossing levels:
`source_text`, `transliteration`, and `morphemes`. It also has two parameters
for unaligned text: `header_text` for text that precedes the gloss, and
`translation` for text that follows the gloss.


The `morphemes` param can be skipped, if you just want to provide a source
text and translation, without a gloss:

#codeblock(
"#gloss(
    source_text: ([Trato de entender, debo comprender, qué es lo que ha hecho conmigo],),
    translation: [I try to understand, I must comprehend, what she has done with me],
)
")


Note that it is still necessary to wrap the `source_text` argument in an array of length one.


To add more than three glossing lines, there is an additional parameter
`additional_gloss_lines` that can take a list of arbitrarily many more glossing
lines, which will appear below those specified in the aforementioned
parameters:

#codeblock(
"#gloss(
    header_text: [Hunzib (van den Berg 1995:46)],
    source_text: ([ождиг],[хо#super[н]хе],[мукъер]),
    transliteration: ([oʒdig],[χõχe],[muqʼer]),
    morphemes: ([ož-di-g],[xõxe],[m-uq'e-r]),
    additional_gloss_lines: (
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
    source_text: ([გვ-ფრცქვნ-ი],),
    source_text_style: none,
    transliteration: ([gv-prtskvn-i],),
    morphemes: ([1#pl.#obj\-peel-#fmnt],),
    translation: \"You peeled us\",
    numbering: true,
)

#numbered-gloss(
    source_text: ([მ-ფრცქვნ-ი],),
    source_text_style: none,
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
    header_text: [_Standard Basque: A Progressive Grammar_ by Rudolf de Rijk, quoting P. Charriton],
    source_text: ([Bada beti guregan zorion handi baten nahia.],),
    source_text_style: none,
    translation: [There always is in us a will for a great happiness.],
)", addl-bindings: (gloss-count: gloss-count))


== Styling lines of a gloss

Each of the aforementioned text parameters has a corresponding style parameter,
formed by adding `_style` to its name: `header_text_style`, `source_text_style`,
`transliteration_style`, `morphemes_style`, and `translation_style`. These parameters
allow you to specify formatting that should be applied to each entire line of
the gloss. This is particularly useful for the aligned gloss itself, since
otherwise one would have to modify each content item in the list individually.

In addition to these parameters, Typst’s usual content formatting can be applied
to or within any given content block in the gloss. Formatting applied in this
way will override any contradictory line-level formatting.

#codeblock(
"#gloss(
    header_text: [This text is about eating your head.],
    header_text_style: text.with(weight: \"bold\", fill: green),
    source_text: (text(fill:black)[I'm], [eat-ing], [your], [head]),
    source_text_style: text.with(style: \"italic\", fill: red),
    morphemes: ([1#sg.#sbj\=to.be], text(fill:black)[eat-#prog], [2#sg.#poss], [head]),
    morphemes_style: text.with(fill: blue),
    translation: text(weight: \"bold\")[I'm eating your head!],
)", addl-bindings: (prog: prog, sbj: sbj, poss: poss, sg: sg))

//TODO add `line_styles` param


= Further Example Glosses

These are the first twelve example glosses given in #link("https://www.eva.mpg.de/lingua/pdf/Glossing-Rules.pdf").
along with the Typst markup needed to generate them:

#{
    gloss-count.update(0)
}

#codeblock(
"#numbered-gloss(
    header_text: [Indonesian (Sneddon 1996:237)],
    source_text: ([Mereka], [di], [Jakarta], [sekarang.]),
    morphemes: ([they], [in], [Jakarta], [now]),
    translation: \"They are in Jakarta now\",
)")

#codeblock(
"#numbered-gloss(
    header_text: [Lezgian (Haspelmath 1993:207)],
    source_text: ([Gila], [abur-u-n], [ferma], [hamišaluǧ], [güǧüna], [amuq’-da-č.]),
    morphemes: ([now], [they-#obl\-#gen], [farm], [forever], [behind], [stay-#fut\-#neg]),
    translation: \"Now their farm will not stay behind forever.\",
)", addl-bindings: (fut: fut, neg: neg, obl: obl, gen:gen))

#codeblock(
"#numbered-gloss(
    header_text: [West Greenlandic (Fortescue 1984:127)],
    source_text: ([palasi=lu], [niuirtur=lu]),
    morphemes: ([priest=and], [shopkeeper=and]),
    translation: \"both the priest and the shopkeeper\",
)")

#codeblock(
"#numbered-gloss(
    header_text: [Hakha Lai],
    source_text: ([a-nii -láay],),
    morphemes: ([3#sg\-laugh-#fut],),
    translation: [s/he will laugh],
)", addl-bindings: (sg: sg, fut: fut))

#codeblock(
"#numbered-gloss(
    header_text: [Russian],
    source_text: ([My], [s], [Marko], [poexa-l-i], [avtobus-om], [v], [Peredelkino]),
    morphemes: ([1#pl], [#com], [Marko], [go-#pst\-#pl], [bus-#ins], [#all], [Peredelkino]),
    additional_gloss_lines: (([we], [with], [Marko], [go-#pst\-#pl], [bus-by], [to], [Peredelkino]),),
    translation: \"Marko and I went to Perdelkino by bus\",
)", addl-bindings: (com: com, pl: pl, ins: ins, all: all, pst:pst))

#codeblock(
"#numbered-gloss(
    header_text: [Turkish],
    source_text: ([çık-mak],),
    morphemes: ([come.out-#inf],),
    translation: \"to come out\",
)", addl-bindings: (inf: inf))

#codeblock(
"#numbered-gloss(
    header_text: [Latin],
    source_text: ([insul-arum],),
    morphemes: ([island-#gen\-#pl],),
    translation: \"of the islands\",
)", addl-bindings: (gen:gen, pl: pl))

#codeblock(
"#numbered-gloss(
    header_text: [French],
    source_text: ([aux], [chevaux]),
    morphemes: ([to-#art\-#pl],[horse.#pl]),
    translation: \"to the horses\",
)",addl-bindings: (art:art, pl:pl))

#codeblock(
"#numbered-gloss(
    header_text: [German],
    source_text: ([unser-n], [Väter-n]),
    morphemes: ([our-#dat\-#pl],[father.#pl\-#dat.#pl]),
    translation: \"to our fathers\",
)", addl-bindings: (dat:dat, pl:pl))

#codeblock(
"#numbered-gloss(
    header_text: [Hittite (Lehmann 1982:211)],
    source_text: ([n=an], [apedani], [mehuni],[essandu.]),
    morphemes: ([#smallcaps[conn]=him], [that.#dat.#sg], [time.#dat.#sg], [eat.they.shall]),
    translation: \"They shall celebrate him on that date\",
)", addl-bindings: (pl:pl, sg:sg, dat:dat))

#codeblock(
"#numbered-gloss(
    header_text: [Jaminjung (Schultze-Berndt 2000:92)],
    source_text: ([nanggayan], [guny-bi-yarluga?]),
    morphemes: ([who], [2#du.#A.3#sg.#P\-#fut\-poke]),
    translation: \"Who do you two want to spear?\",
)", addl-bindings: (du:du, sg:sg, fut:fut, A:A, P:P))
