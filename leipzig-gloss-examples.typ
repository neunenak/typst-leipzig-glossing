#import "leipzig-gloss.typ": gloss, numbered_gloss, gloss_count
#import "linguistic-abbreviations.typ": *

#show link: x => underline[*#x*]
//#show raw: x => text(fill: rgb("#43464b"))[#x]

#let codeblock(contents) = block(fill: luma(230), inset: 8pt, radius: 4pt, breakable: false, contents)

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
#link("https://github.com/neunenak/typst-leipzig-glossing")[neunenak/typst-leipzig-glossing].

= Basic glossing functionality


As a first example, here is a gloss of a text in Georgian, along with the Typst code used to generate it:


#gloss(
    header_text: [from "Georgian and the Unaccusative Hypothesis", Alice Harris, 1982],
    source_text: ([ბავშვ-ი], [ატირდა]),
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
)

#codeblock[
```typst
#gloss(
    header_text: [from "Georgian and the Unaccusative Hypothesis", Alice Harris, 1982],
    source_text: ([ბავშვ-ი], [ატირდა]),
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
)
```
]

And an example for English which exhibits some additional styling, and uses imports from another file
for common glossing abbreviations:

#gloss(
  source_text: ([I'm], [eat-ing], [your], [head]),
  source_text_style: (item) => text(fill: red)[#item],
  morphemes: ([1#sg.#sbj\=to.be], [eat-#prog], [2#sg.#poss], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: "semibold")[I'm eating your head!],
)

#codeblock[
```typst
#import "linguistic-abbreviations.typ": *

#gloss(
  source_text: ([I'm], [eat-ing], [your], [head]),
  source_text_style: (item) => text(fill: red)[#item],
  morphemes: ([1#sg.#subj\=to.be], [eat-#prog], [2#sg.#pos], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: "semibold")[I'm eating your head!],
)
```
]


The `#gloss` function has three pre-defined parameters for glossing levels:
`source_text`, `transliteration`, and `morphemes`. It also has two parameters
for unaligned text: `header_text` for text that precedes the gloss, and
`translation` for text that follows the gloss.


The `morphemes` param can be skipped, if you just want to provide a source
text and translation, without a gloss:

#gloss(
    source_text: ([Trato de entender, debo comprender qué es lo que ha hecho conmigo],),
    translation: [I try to understand, I should comprehend, what it has done with me],
)

#codeblock[
```typst
#gloss(
    source_text: ([Trato de entender, debo comprender qué es lo que ha hecho conmigo],),
    translation: [I try to understand, I should comprehend, what it has done with me],
)
```
]

Note that it is still necessary to wrap the `source_text` argument in an array of length one.



If one wishes to add more than three glossing lines, there is an additional
parameter `additional_gloss_lines` that can take a list of arbitrarily many more glossing
lines, which will appear below those specified in the aforementioned
parameters:

#gloss(
    header_text: [Hunzib (van den Berg 1995:46)],
    source_text: ([ождиг],[хо#super[н]хе],[мукъер]),
    transliteration: ([oʒdig],[χõχe],[muqʼer]),
    morphemes: ([ož-di-g],[xõxe],[m-uq'e-r]),
    additional_gloss_lines: (
        ([boy-#smallcaps[obl]-#smallcaps[ad]], [tree(#smallcaps[g4])], [#smallcaps[g4]-bend-#smallcaps[pret]]),
        ([at boy], [tree], [bent]),
    ),
    translation: ["Because of the boy, the tree bent."]
)

#codeblock[
```typst
#gloss(
    header_text: [Hunzib (van den Berg 1995:46)],
    source_text: ([ождиг],[хо#super[н]хе],[мукъер]),
    transliteration: ([oʒdig],[χõχe],[muqʼer]),
    morphemes: ([ož-di-g],[xõxe],[m-uq'e-r]),
    additional_gloss_lines: (
        ([boy-#smallcaps[obl]-#smallcaps[ad]], [tree(#smallcaps[g4])], [#smallcaps[g4]-bend-#smallcaps[pret]]),
        ([at boy], [tree], [bent]),
    ),
    translation: ["Because of the boy, the tree bent."]
)
```
]

To number gloss examples, use `#numbered_gloss` in place of `gloss`. All other parameters remain the same.

#numbered_gloss(
    source_text: ([გვ-ფრცქვნ-ი],),
    source_text_style: none,
    transliteration: ([gv-prtskvn-i],),
    morphemes: ([1#pl.#obj\-peel-#fmnt],),
    translation: "You peeled us",
)

#codeblock[
```typst
#import "linguistic-abbreviations.typ": *

#gloss(
    source_text: ([გვ-ფრცქვნ-ი],),
    source_text_style: none,
    transliteration: ([gv-prtskvn-i],),
    morphemes: ([1#pl.#obj\-peel-#fmnt],),
    translation: "You peeled us",
```)]

The displayed number for numbered glosses is iterated for each numbered gloss
that appears throughout the document. Unnumbered glosses do not increment the
counter for the numbered glosses.

The gloss count is controlled by the Typst counter variable `gloss_count`. This
variable can be imported from the `leipzig-gloss` package and reset using the
standard Typst counter functions to control gloss numbering.

//TODO add examples here


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

#gloss(
    header_text: [This text is about eating your head.],
    header_text_style: text.with(weight: "bold", fill: green),
    source_text: (text(fill:black)[I'm], [eat-ing], [your], [head]),
    source_text_style: text.with(style: "italic", fill: red),
    morphemes: ([1#sg.#sbj\=to.be], text(fill:black)[eat-#prog], [2#sg.#poss], [head]),
    morphemes_style: text.with(fill: blue),
    translation: text(weight: "bold")[I'm eating your head!],
)
#codeblock[
```typst
#gloss(
    header_text: [This text is about eating your head.],
    header_text_style: text.with(weight: "bold", fill: green),
    source_text: (text(fill:black)[I'm], [eat-ing], [your], [head]),
    source_text_style: text.with(style: "italic", fill: red),
    morphemes: ([1#sg.#sbj\=to.be], text(fill:black)[eat-#prog], [2#sg.#poss], [head]),
    morphemes_style: text.with(fill: blue),
    translation: text(weight: "bold")[I'm eating your head!],
)
```
]
//TODO add `line_styles` param


== Further Example Glosses

These example glosses replicate the ones given in
#link("https://www.eva.mpg.de/lingua/pdf/Glossing-Rules.pdf").

#{
    gloss_count.update(0)
}

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
