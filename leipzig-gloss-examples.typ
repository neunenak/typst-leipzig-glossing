#import "leipzig-gloss.typ": gloss, numbered_gloss
#import "linguistic-abbreviations.typ": *

#let codeblock(contents) = block(fill: luma(230), inset: 8pt, radius: 4pt, contents)


= Introduction

Interlinear morpheme-by-morpheme glosses are common in linguistic texts to give
information about the meanings of individual words and morphemes in the
language being studied. A set of conventions called the *Leipzig Glossing Rules*
was developed to give linguists a general set of standards and principles for
how to format these glosses. The most recent version of these rules can be
found in pdf form at
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

This pdf will show examples of the module's functionality and detail relevant
parameters. For more information or to inform devs of a bug or other issue,
visit the module's Github repository
#link("https://github.com/neunenak/typst-leipzig-glossing")[neunenak/typst-leipzig-glossing].

= Leipzig Glossing Examples

The classic example of the inflected Georgian verb with an 8-segment
consonant cluster:

#gloss(
    source_text: ([გვ-ფრცქვნ-ი],),
    source_text_style: none,
    transliteration: ([gv-prtskvn-i],),
    morphemes: ([1pl.#obj\-peel-#fmnt],),
    translation: "You peeled us",
)

Some more Georgian examples:

#gloss(
    header_text: [from "Georgian and the Unaccusative Hypothesis", Harris, 1982],
    source_text: ([ბავშვ-ი], [ატირდა]),
    source_text_style: (item) => text(fill: red)[#item],
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
)

#codeblock[
```typst
#gloss(
    header_text: [from "Georgian and the Unaccusative Hypothesis", Harris, 1982],
    source_text: ([ბავშვ-ი], [ატირდა]),
    source_text_style: (item) => text(fill: red)[#item],
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
)
```
]

And an example in English:

#gloss(
  source_text: ([I'm], [eat-ing], [your], [head]),
  morphemes: ([1#sg.#sbj\=to.be], [eat-#prog], [2#sg.#pos], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: "semibold")[I'm eating your head!],
)

#codeblock(
[```typst
#gloss(
  source_text: ([I'm], [eat-ing], [your], [head]),
  morphemes: ([1#sg.#subj\=to.be], [eat-#prog], [2#sg.#pos], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: "semibold")[I'm eating your head!],
)
```])

== Leipzig Glossing Rules PDF examples

See #link("https://www.eva.mpg.de/lingua/pdf/Glossing-Rules.pdf")


#numbered_gloss(
    header_text: [Indonesian (Sneddon 1996:237)],
    source_text: ([Mereka], [di], [Jakarta], [sekarang.]),
    morphemes: ([they], [in], [Jakarta], [now]),
    translation: "They are in Jakarta now",
)

#numbered_gloss(
    header_text: [Lezgian (Haspelmath 1993:207)],
    source_text: ([Gila], [abur-u-n], [ferma], [hamišaluǧ], [güǧüna], [amuq’-da-č.]),
    morphemes: ([now], [they-#obl\-#gen], [farm], [forever], [behind], [stay-#fut\-#neg]),
    translation: "Now their farm will not stay behind forever.",
)

#numbered_gloss(
    header_text: [West Greenlandic (Fortescue 1984:127)],
    source_text: ([palasi=lu], [niuirtur=lu]),
    morphemes: ([priest=and], [shopkeeper=and]),
    translation: "both the priest and the shopkeeper",
)

#numbered_gloss(
    header_text: [Hakha Lai],
    source_text: ([a-nii -láay],),
    morphemes: ([3#sg\-laugh-#fut],),
    translation: [s/he will laugh],
)

#numbered_gloss(
    header_text: [Russian],
    source_text: ([My], [s], [Marko], [poexa-l-i], [avtobus-om], [v], [Peredelkino]),
    morphemes: ([1#pl], [#com], [Marko], [go-#pst\-#pl], [bus-#ins], [#all], [Peredelkino]),
    additional_gloss_lines: (([we], [with], [Marko], [go-#pst\-#pl], [bus-by], [to], [Peredelkino]),),
    translation: "Marko and I went to Perdelkino by bus",
)

#numbered_gloss(
    header_text: [Turkish],
    source_text: ([çık-mak],),
    morphemes: ([come.out-#inf],),
    translation: "to come out",
)

#numbered_gloss(
    header_text: [Latin],
    source_text: ([insul-arum],),
    morphemes: ([island-#gen\-#pl],),
    translation: "of the islands",
)

#numbered_gloss(
    header_text: [French],
    source_text: ([aux], [chevaux]),
    morphemes: ([to-#art\-#pl],[horse.#pl]),
    translation: "to the horses",
)

#numbered_gloss(
    header_text: [German],
    source_text: ([unser-n], [Väter-n]),
    morphemes: ([our-#dat\-#pl],[father.#pl\-#dat.#pl]),
    translation: "to our fathers",
)

#numbered_gloss(
    header_text: [Hittite (Lehmann 1982:211)],
    source_text: ([n=an], [apedani], [mehuni],[essandu.]),
    morphemes: ([#smallcaps[conn]=him], [that.#dat.#sg], [time.#dat.#sg], [eat.they.shall]),
    translation: "They shall celebrate him on that date",
)

#numbered_gloss(
    header_text: [Jaminjung (Schultze-Berndt 2000:92)],
    source_text: ([nanggayan], [guny-bi-yarluga?]),
    morphemes: ([who], [2#du.#A.3#sg.#P\-#fut\-poke]),
    translation: "Who do you two want to spear?",
)
