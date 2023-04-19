#import "leipzig-gloss.typ": *
#import "linguistic-abbreviations.typ": *

= Leipzig Glossing for Typst

This module provides functionality to create aligned leipzig-style glosses in Typst. For example, here's a gloss of a text in Georgian:

#gloss(
    header_text: [from "Georgian and the Unaccusative Hypothesis", Harris, 1982],
    source_text: ([ბავშვ-ი], [ატირდა]),
    source_text_style: (item) => text(fill: red)[#item],
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
)

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [```typst
#gloss(
    header_text: [from "Georgian and the Unaccusative Hypothesis", Harris, 1982],
    source_text: ([ბავშვ-ი], [ატირდა]),
    source_text_style: (item) => text(fill: red)[#item],
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
)
```],
)

To number gloss examples, use `#numbered_gloss` in place of `gloss`:

#numbered_gloss(
    header_text: [Indonesian (Sneddon 1996:237)],
    source_text: ([Mereka], [di], [Jakarta], [sekarang.]),
    morphemes: ([they], [in], [Jakarta], [now]),
    translation: "They are in Jakarta now",
)

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [```typst
#numbered_gloss(
    header_text: [Indonesian (Sneddon 1996:237)],
    source_text: ([Mereka], [di], [Jakarta], [sekarang.]),
    morphemes: ([they], [in], [Jakarta], [now]),
    translation: "They are in Jakarta now",
)
```],
)

The displayed number for numbered glosses is iterated for each numbered gloss that appears throughout the document. Unnumbered glosses do not increment the counter for the numbered glosses:

#gloss(
    header_text: [Jaminjung (Schultze-Berndt 2000:92)],
    source_text: ([nanggayan], [guny-bi-yarluga?]),
    morphemes: ([who], [2#du.#A.3#sg.#P\-#fut\-poke]),
    translation: "Who do you two want to spear?",
)

#numbered_gloss(
    header_text: [West Greenlandic (Fortescue 1984:127)],
    source_text: ([palasi=lu], [niuirtur=lu]),
    morphemes: ([priest=and], [shopkeeper=and]),
    translation: ["both the priest and the shopkeeper"],
)

== Specifying text \& style for each line of a gloss

The `#gloss` function has three pre-defined parameters for glossing levels: `source_text`, `transliteration`, and `morphemes`. It also has two parameters for unaligned text: `header_text` for text that precedes the gloss, and `translation` for text that follows the gloss. Each of these parameters has a corresponding style parameter, formed by adding `_style` to its name. This allows you to specify various style elements individually for each line, like so:

#gloss(
  header_text: [This text is about eating your head.],
  header_text_style: text.with(weight: "bold", fill: green),
  source_text: ([I'm], [eat-ing], [your], [head]),
  source_text_style: text.with(style: "italic", fill: red),
  morphemes: ([1#sg.#sbj\=to.be], [eat-#prog], [2#sg.#pos], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: "semibold")[I'm eating your head!],
)

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
[```typst
#gloss(
  header_text: [This text is about eating your head.],
  header_text_style: text.with(weight: "bold", fill: green),
  source_text: ([I'm], [eat-ing], [your], [head]),
  source_text_style: text.with(style: "italic", fill: red),
  morphemes: ([1#sg.#sbj\=to.be], [eat-#prog], [2#sg.#pos], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: "semibold")[I'm eating your head!],
)
```])

As seen above, the style for unaligned lines like `header_text` and `translation` may be specified either with the associated `_style` parameter or by directly modifying the content. The same is not true of the glossed lines -- they must be specified using the relevant `_style` attribute.

If one wishes to add more than three glossing lines, there is an additional parameter `gloss_lines` that can take a list of arbitrarily many more glossing lines, which will appear below those specified in the aforementioned parameters. A list of styles to use for these lines can also be provided using the `line_styles` parameter. The list of styles will be evaluated in order and apply to the gloss line at the same index.

#numbered_gloss(
    header_text: [Lezgian (Haspelmath 1993:207)],
    source_text: ([Gila], [abur-u-n], [ferma], [hamišaluǧ], [güǧüna], [amuq’-da-č.]),
    morphemes: ([now], [they-#obl\-#gen], [farm], [forever], [behind], [stay-#fut\-#neg]),
    gloss_lines: (
        ([now],[their],[farm],[forever],[behind],[will stay]),
    ),
    line_styles: (text.with(fill:green),),
    translation: "Now their farm will not stay behind forever.",
)

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
[```typst
#numbered_gloss(
    header_text: [Lezgian (Haspelmath 1993:207)],
    source_text: ([Gila], [abur-u-n], [ferma], [hamišaluǧ], [güǧüna], [amuq’-da-č.]),
    morphemes: ([now], [they-#obl\-#gen], [farm], [forever], [behind], [stay-#fut\-#neg]),
    gloss_lines: (
        ([now],[their],[farm],[forever],[behind],[will stay]),
    ),
    line_styles: (text.with(fill:green),),
    translation: "Now their farm will not stay behind forever.",
)
```])

#block(
    breakable: false,
stack(
    dir:ttb,
    spacing: 1em,
    [#numbered_gloss(
    source_text: ([Мы], [с], [Марко], [поехали], [автобусом], [в], [Переделкино]),
    source_text_style: strong,
    transliteration: ([My], [s], [Marko], [poexa-l-i], [avtobus-om], [v], [Peredelkino]),
    morphemes: ([1#pl], [#com], [Marko], [go-#pst\-#pl], [bus-#ins], [#all], [Peredelkino]),
    gloss_lines: (
        ([we], [with], [Marko], [go-#pst\-#pl], [bus-by], [to], [Peredelkino]),([nous], [avec], [Marco], [allés], [en bus], [à], [Peredelkino]),
        ([私たちは],[と], [マルコ], [行きました], [バスで], [に], [ペレデルキノ])
    ),
    line_styles: (
        none,
        text.with(style: "italic", fill: purple, font: "Noto Serif"),
        text.with(font: "Noto Sans CJK JP", fill: red),
    ),
    translation: "Marko and I went to Peredelkino by bus",
    translation_style: text.with(style: "italic", weight: "bold")
    )],
    block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
[```typst
#numbered_gloss(
    source_text: ([Мы], [с], [Марко], [поехали], [автобусом], [в], [Переделкино]),
    source_text_style: strong,
    transliteration: ([My], [s], [Marko], [poexa-l-i], [avtobus-om], [v], [Peredelkino]),
    morphemes: ([1#pl], [#com], [Marko], [go-#pst\-#pl], [bus-#ins], [#all], [Peredelkino]),
    gloss_lines: (
        ([we], [with], [Marko], [go-#pst\-#pl], [bus-by], [to], [Peredelkino]),
        ([nous], [avec], [Marco], [allés], [en bus], [à], [Peredelkino]),
        ([私たちは],[と], [マルコ], [行きました], [バスで], [に], [ペレデルキノ])
    ),
    line_styles: (
        none,
        text.with(style: "italic", fill: purple, font: "Noto Serif"),
        text.with(font: "Noto Sans CJK JP", fill: red),
    ),
    translation: "Marko and I went to Peredelkino by bus",
    translation_style: text.with(style: "italic", weight: "bold")
)
```
])
)
)

== Customizing spacing

== N-level glossing: alternative syntax

== Leipzig Glossing Rules PDF examples

See https://www.eva.mpg.de/lingua/pdf/Glossing-Rules.pdf


#numbered_gloss(
    header_text: [Hakha Lai],
    source_text: ([a-nii -láay],),
    morphemes: ([3#sg\-laugh-#fut],),
    translation: [s/he will laugh],
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


