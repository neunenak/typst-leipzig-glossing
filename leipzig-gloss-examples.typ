#import "leipzig-gloss.typ": *
#import "linguistic-abbreviations.typ": *

#show link: x => underline[*#x*]

= Leipzig Glossing for Typst

== Introduction

Interlinear morpheme-by-morpheme glosses are common in linguistic texts to give information about the meanings of individual words and morphemes in the language being studied. A set of conventions for these glosses, called the "Leipzig Glossing Rules", was developed to give linguists a general set of standards and principles for how to format these glosses. The most recent version of these rules can be found in pdf form at #link("https://www.eva.mpg.de/lingua/pdf/Glossing-Rules.pdf")[this link], provided by the Department of Linguistics at the Max Planck Institute for Evolutionary Anthropology.

There is a staggering variety of LaTex packages designed to properly align and format glosses (including `gb4e`, `ling-macros`, `linguex`, `expex`, and probably even more). These modules vary in the complexity of their syntax and the amount of control they give to the user of various aspects of formatting. The `typst-leipzig-glossing` module is designed to provide utilities for creating aligned Leipzig-style glosses in Typst, while keeping the syntax as intuitive as possible and allowing users as much control over how their glosses look as is feasible.

This pdf will show examples of the module's functionality and detail relevant parameters. For more information or to inform devs of a bug or other issue, visit the module's github repository #link("https://github.com/neunenak/typst-leipzig-glossing")[neunenak/typst-leipzig-glossing].

== Basic glossing functionality

As a first example, here is a gloss of a text in Georgian, along with the Typst code used to generate it:

#gloss(
    header_text: [from "Georgian and the Unaccusative Hypothesis", Harris, 1982],
    source_text: ([ბავშვ-ი], [ატირდა]),
    source_text_style: (item) => text(fill: red)[#item],
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: ["The child burst out crying"],
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
    translation: ["The child burst out crying"],
)
```],
)

The `#gloss` function has three pre-defined parameters for glossing levels: `source_text`, `transliteration`, and `morphemes`. It also has two parameters for unaligned text: `header_text` for text that precedes the gloss, and `translation` for text that follows the gloss.

If one wishes to add more than three glossing lines, there is an additional parameter `gloss_lines` that can take a list of arbitrarily many more glossing lines, which will appear below those specified in the aforementioned parameters:

#gloss(
    header_text: [Hunzib (van den Berg 1995:46)],
    source_text: ([ождиг],[хо#super[н]хе],[мукъер]),
    transliteration: ([oʒdig],[χõχe],[muqʼer]),
    morphemes: ([ož-di-g],[xõxe],[m-uq'e-r]),
    gloss_lines: (
        ([boy-#smallcaps[obl]-#smallcaps[ad]], [tree(#smallcaps[g4])], [#smallcaps[g4]-bend-#smallcaps[pret]]),
        ([at boy], [tree], [bent]),
    ),
    translation: ["Because of the boy, the tree bent."]
)

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [```typst
#gloss(
    header_text: [Hunzib (van den Berg 1995:46)],
    source_text: ([ождиг],[хо#super[н]хе],[мукъер]),
    transliteration: ([oʒdig],[χõχe],[muqʼer]),
    morphemes: ([ož-di-g],[xõxe],[m-uq'e-r]),
    gloss_lines: (
        ([boy-#smallcaps[obl]-#smallcaps[ad]], [tree(#smallcaps[g4])], [#smallcaps[g4]-bend-#smallcaps[pret]]),
        ([at boy], [tree], [bent]),
    ),
    translation: ["Because of the boy, the tree bent."]
)
```],
)

To number gloss examples, use `#numbered_gloss` in place of `gloss`. All other parameters remain the same.

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

== Styling lines of a gloss

Each of the aforementioned text parameters has a corresponding style parameter, formed by adding `_style` to its name: `header_text_style`, `source_text_style`, `transliteration_style`, `morphemes_style`, and `translation_style`. These parameters allow you to specify formatting that should be applied to each entire line of the gloss. This is particularly useful for the aligned gloss itself, since otherwise one would have to modify each content item in the list individually.

In addition to these parameters, Typst's usual content formatting can be applied to or within any given content block in the gloss. Formatting applied in this way will override any contradictory line-level formatting.

#gloss(
  header_text: [This text is about eating your head.],
  header_text_style: text.with(weight: "bold", fill: green),
  source_text: (text(fill:black)[I'm], [eat-ing], [your], [head]),
  source_text_style: text.with(style: "italic", fill: red),
  morphemes: ([1#sg.#sbj\=to.be], text(fill:black)[eat-#prog], [2#sg.#pos], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: "bold")[I'm eating your head!],
)
#block(
    breakable: false,
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
[```typst
#gloss(
  header_text: [This text is about eating your head.],
  header_text_style: text.with(weight: "bold", fill: green),
  source_text: (text(fill:black)[I'm], [eat-ing], [your], [head]),
  source_text_style: text.with(style: "italic", fill: red),
  morphemes: ([1#sg.#sbj\=to.be], text(fill:black)[eat-#prog], [2#sg.#pos], [head]),
  morphemes_style: text.with(fill: blue),
  translation: text(weight: "bold")[I'm eating your head!],
)
```])

 To apply styles to lines in the `gloss_lines` parameter, there is a `line_styles` parameter. This parameter takes a list of styles and provides them in order to the lines provided by `gloss_lines`. If fewer styles are provided than there are lines in `gloss_lines`, the remaining lines will be displayed with whatever the default formatting is. 

#numbered_gloss(
    header_text: [Lezgian (Haspelmath 1993:207)],
    source_text: ([Gila], [abur-u-n], [ferma], [hamišaluǧ], [güǧüna], [amuq’-da-č.]),
    morphemes: ([now], [they-#obl\-#gen], [farm], [forever], [behind], [stay-#fut\-#neg]),
    gloss_lines: (
        ([now],[their],[farm],[forever],[behind],[will not stay]),
        ([τώρα],[τους],[αγρόκτημά], [για πάντα], [πίσω], [δεν θα παραμείνει]),
    ),
    line_styles: (text.with(fill:green),),
    translation: "Now their farm will not stay behind forever.",
)

#block(
    breakable: false,
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
[```typst
#numbered_gloss(
    header_text: [Lezgian (Haspelmath 1993:207)],
    source_text: ([Gila], [abur-u-n], [ferma], [hamišaluǧ], [güǧüna], [amuq’-da-č.]),
    morphemes: ([now], [they-#obl\-#gen], [farm], [forever], [behind], [stay-#fut\-#neg]),
    gloss_lines: (
        ([now],[their],[farm],[forever],[behind],[will not stay]),
        ([τώρα],[τους],[αγρόκτημά], [για πάντα], [πίσω], [δεν θα παραμείνει]),
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

== Spacing \& padding customization

This package allows you to customize the spacing used for various elements in the gloss. The relevant spacing parameters are as follows:

/ `interword_spacing`: (Default: 1em) the amount of horizontal space between each word/item in the gloss.
/ `gloss_line_spacing`: (Default: 0.5em) the amount of vertical space between lines of the gloss.
/ `post_header_space`: (Default: 0.5em) the amount of extra vertical spacing added between the header text and the gloss itself. If set to `none`, a `linebreak()` will be used.
/ `pre_translation_space`: (Default: 0.5em) the amount of extra vertical spacing added between the gloss itself and the translation text. If set to `none`, a `linebreak()` will be used.
/ `gloss_padding`: (Default: 2em) the size of the padding from the left margin for the entire gloss example. This length marks where the text itself starts for both numbered and un-numbered glosses, allowing for consistent alignment between the two.
/ `left_padding`: (Default: .5em) the size of the padding from the left margin for the number of a numbered gloss. Should be less than `gloss_padding` to avoid ugly overlaps. Is completely ignored by un-numbered glosses.

While these parameters are set to sensible defaults, feel free to customize them as needed for your use case.

#block(
    breakable: false,
stack(
    dir:ttb,
    spacing: 1em,
    [#numbered_gloss(
    header_text: [Hittite (Lehmann 1982:211)],
    source_text: ([n=an], [apedani], [mehuni],[essandu.]),
    morphemes: ([#smallcaps[conn]=him], [that.#dat.#sg], [time.#dat.#sg], [eat.they.shall]),
    translation: "They shall celebrate him on that date",
    gloss_line_spacing: 1em,
    interword_spacing: 3em,
    post_header_space: 2em,
    pre_translation_space: none,
    gloss_padding: 4em,
    left_padding: 2em,
)],
    block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
[```typst
    #numbered_gloss(
        header_text: [Hittite (Lehmann 1982:211)],
        source_text: ([n=an], [apedani], [mehuni],[essandu.]),
        morphemes: ([#smallcaps[conn]=him], [that.#dat.#sg], [time.#dat.#sg], [eat.they.shall]),
        translation: "They shall celebrate him on that date",
    )
    ```
])
)
)


== Nlevel glossing: alternate syntax

The popular `expex` package for LaTeX provides an alternate syntax to use for glosses that they call "nlevel". In this syntax, rather than writing the gloss line-by-line, one instead groups the words item-by-item, writing each word with its glosses for each line in turn. Advocates for this type of syntax argue that it makes the resulting code more readable, since each word is grouped with its gloss, as well as easier to copy/paste recurring items from one gloss to another.

Nlevel glossing is _not_ the default for this module, but those who prefer it can use it by setting the `nlevel` parameter of a gloss to `true`.

As an example, consider the following gloss: 

#block(breakable: false,
    [#numbered_gloss(
    nlevel: true,
    header_text: [French],
    gloss_lines: (
        ([aux], [/o/], [to-#art\-#pl], [to the]),
        ([chevaux], [/ʃəvo/], [horse.#pl], [horses]),
    ),
    line_styles: (emph,),
    translation: "to the horses"
)])
#block(
    breakable: false,
    fill: luma(230),
    inset: 8pt,
    radius: 4pt,
    [```typst
#numbered_gloss(
    header_text: [French],
    source_text: ([aux],[chevaux]),
    transliteration: ([/o/],[/ʃəvo/]),
    morphemes: ([to-#art\-#pl],[horse.#pl]),
    gloss_lines: (
        ([to the],[horses]),
    ),
    translation: "to the horses"
)
```
    ])

An identical gloss to that produced by the default syntax above can be produced using nlevel syntax as follows:

#block(
    fill: luma(230),
    inset: 8pt,
    radius: 4pt,
    [```typst
#numbered_gloss(
    nlevel: true,
    header_text: [French],
    gloss_lines: (
        ([aux], [/o/], [to-#art\-#pl], [to the]),
        ([chevaux], [/ʃəvo/], [horse.#pl], [horses]),
    ),
    line_styles: (emph,),
    translation: "to the horses"
)
```
    ])

Note that the nlevel example exclusively uses `gloss_lines` and `line_styles` for the aligned gloss text -- since the `source_text`, `transliteration`, and `morphemes` parameters are based on a line-by-line syntax, they and their respective style parameters may not be used with nlevel syntax. 

To avoid frustration for those not using nlevel syntax, the default behavior of italicizing the first line of the aligned gloss (corresponding to the `source_text` parameter in the default syntax) is not duplicated for nlevel glosses and must be manually specified. The behavior of all other parameters and defaults is unchanged and should be identical between both versions of the glossing syntax.
