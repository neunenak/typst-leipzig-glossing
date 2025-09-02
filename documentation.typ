#set document(title: "typst leipzig-glossing documentation")
#import "leipzig-gloss.typ": abbreviations, example, example-count, gloss, numbered-example 

#set heading(numbering: "1.")

#show link: x => underline[*#x*]

#let codeblock(contents, addl-bindings: (:), unevaled-first-line: none) = {
    let full-contents = if unevaled-first-line != none {
        unevaled-first-line + "\n" + contents
    } else {
        contents
    }

    block(stroke: 0.5pt + black, inset: 4pt, width: 100%, breakable: false)[
        #eval(contents, mode: "markup", scope: (gloss: gloss, example: example, numbered-example: numbered-example) + addl-bindings)
        #block(fill: luma(230), inset: 8pt, radius: 4pt, breakable: false, width: 100%, raw(full-contents, lang: "typst"))
    ]
}

// Abbreviations used in this document

#import abbreviations: poss, prog, sg, pl, sbj, obj, fut, neg, obl, gen, com, ins, all, pst, inf, indf, def, dem, pred
#import abbreviations: art, dat, du, A, P, prf

#let fmnt = abbreviations.emit-abbreviation("FMNT")

#align(center)[#text(17pt)[Typst `leipzig-glossing` Documentation]]

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
)", unevaled-first-line: "#import \"leipzig-gloss.typ\": gloss")

The function `gloss()` typesets _bare_ interlinear glosses (including styling, see @styling and @additional-lines). Normally when adding linguistic examples use the `example()` function, which calls `gloss()` internally and includes functionality that has to do with linguistic examples: numbering, labelling/referencing and sub-examples. `gloss()` is to be used when only the basic function of typesetting interlinear glosses is needed. Unlike `gloss()`, the function `example()` does not take the different parameters directly, but takes a list of dictionaries whose keys and values correspond to `gloss()`’s parameters (with added options such as `label` and `numbering`). It also indents the text even when numbering is not enabled:

#codeblock(
"#example(
  (
    header: [from \"Georgian and the Unaccusative Hypothesis\", Alice Harris, 1982],
    source: ([ბავშვ-ი], [ატირდა]),
    transliteration: ([bavšv-i], [aṭirda]),
    morphemes: ([child-#smallcaps[nom]], [3S/cry/#smallcaps[incho]/II]),
    translation: [The child burst out crying],
  )
)")

== Styling <styling>

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
"#example(
  (
    header: [This text is about eating your head.],
    header-style: text.with(weight: \"bold\", fill: green),
    source: (text(fill:black)[I'm], [eat-ing], [your], [head]),
    source-style: text.with(style: \"italic\", fill: red),
    morphemes: ([1#sg.#sbj\=to.be], text(fill:black)[eat-#prog], [2#sg.#poss], [head]),
    morphemes-style: text.with(fill: blue),
    translation: text(weight: \"bold\")[I'm eating your head!],
  )
)", addl-bindings: (prog: prog, sbj: sbj, poss: poss, sg: sg))

//TODO add `line-styles` param

An example for English which exhibits some additional styling, and uses imports from another file
for common glossing abbreviations:

#codeblock(
"#example(
  (
    source: ([I'm], [eat-ing], [your], [head]),
    source-style: (item) => text(fill: red)[#item],
    morphemes: ([1#sg.#sbj\=to.be], [eat-#prog], [2#sg.#poss], [head]),
    morphemes-style: text.with(size: 10pt, fill: blue),
    translation: text(weight: \"semibold\")[I'm eating your head!],
    translation-style: (item) => [\"#item\"],
  )
)
", addl-bindings: (poss: poss, prog: prog, sg: sg, sbj: sbj))


The `gloss()` function has three pre-defined parameters for glossing levels:
`source`, `transliteration`, and `morphemes`. It also has two parameters
for unaligned text: `header` for text that precedes the gloss, and
`translation` for text that follows the gloss.


The `morphemes` param can be skipped, if you just want to provide a source
text and translation, without a gloss:

#codeblock(
"#example(
  (
    source: ([Trato de entender, debo comprender, qué es lo que ha hecho conmigo],),
    source-style: emph,
    translation: [I try to understand, I must comprehend, what she has done with me],
  )
)
")


Note that it is still necessary to wrap the `source` argument in an array of length one.

Here is an example of a lengthy gloss that forces a line break:

// adapted from https://brill.com/fileasset/downloads_static/static_publishingbooks_formatting_glosses_linguistic_examples.pdf
#codeblock(
"#example(
  (
    source:    ([Ich],[arbeite],[ein],[Jahr],[um],[das],[Geld], [zu],[verdienen,],[das], [dein],[Bruder], [an],[einem],[Wochenende],[ausgibt.]),
    source-style: text.with(weight: \"bold\"),
    morphemes: ([I],  [work],[  one], [year],[to],[the],[money],[to],[earn,],     [that],[your],[brother],[on],[one],  [weekend],   [spends.]),
    translation: [\"I work one year to earn the money that your brother spends in one weekend\"]
  )
)", addl-bindings: (poss: poss, prog: prog, sg: sg, sbj: sbj))

== Additional lines <additional-lines>

To add more than three glossing lines, there is an additional parameter
`additional-lines` that can take a list of arbitrarily many more glossing
lines, which will appear below those specified in the aforementioned
parameters:

#codeblock(
"#example(
  (
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
)
")

== Sub-examples

Sub-examples can be achieved by adding more dictionaries of glossing fields, separated by commas.
A global `header` field for the set can be added.

#codeblock(
"#example(
  header: [Coptic; transliterated and glossed based on _Coptic in 20 lessons_ (2007) by Layton Bently (§~28)],
  (
    header: [Indefinite articles],
    source: ([hen-maein], [mn-hen-špêre]),
    morphemes: ([#indf.#pl\-sign], [with-#indf.#pl\-wonder]),
    translation: [signs and wonders]
  ),
  (
    header: [Definite articles],
    source: ([m-maein], [mn-ne-špêre]),
    morphemes: ([#def.#pl\-sign], [with-#def.#pl\-wonder]),
    translation: [the signs and the wonders]
  ),
  (
    header: [Definite pronouns],
    source: ([nei-maein], [mn-nei-špêre]),
    morphemes: ([#dem.#pl\-sign], [with-#dem.#pl\-wonder]),
    translation: [these signs and these wonders]
  ),
)
", addl-bindings: (indf: indf, pl: pl, sg: sg, def: def, dem: dem))


The parameter `sub-num-pattern` can be provided to `example`, which accepts 
#link("https://typst.app/docs/reference/model/numbering/")[Typst numbering syntax]
to format sub-examples.


//TODO add a custom numbering system that can handle example 18a-c of Kartvelian Morphosyntax and Number Agreement
== Numbering Glosses

The `example()` function takes a boolean parameter `numbering` which will add an incrementing
count to each gloss. A function `numbered-example` is exported for convenience; this is
defined as simply `#let numbered-example = example.with(numbering: true)`, and is called with the
same arguments as `example()`:


#codeblock(
"#example(
  (
    source: ([გვ-ფრცქვნ-ი],),
    transliteration: ([gv-prtskvn-i],),
    morphemes: ([1#pl.#obj\-peel-#fmnt],),
    translation: \"You peeled us\",
  ),
  numbering: true,
)

#numbered-example(
  (
    source: ([მ-ფრცქვნ-ი],),
    transliteration: ([m-prtskvn-i],),
    morphemes: ([1#sg.#obj\-peel-#fmnt],),
    translation: \"You peeled me\",
  )
)

", addl-bindings: (pl: pl, obj: obj, sg: sg, fmnt: fmnt))

The displayed number for numbered glosses is iterated for each numbered gloss
that appears throughout the document. Unnumbered glosses do not increment the
counter for the numbered glosses.

The gloss count is controlled by the Typst counter variable `example-count`. This
variable can be imported from the `leipzig-gloss` package and manipulated using the
standard Typst counter functions to control gloss numbering:

#codeblock(
"#example-count.update(20)

#numbered-example(
  (
    header: [from _Standard Basque: A Progressive Grammar_ by Rudolf de Rijk, quoting P. Charriton],
    source: ([Bada beti guregan zorion handi baten nahia.],),
    translation: [There always is in us a will for a great happiness.],
  )
)", addl-bindings: (example-count: example-count))

References to individual examples can be achieved using the `label` argument and the referencing mechanism of Typst:

#codeblock(
"See @sorcerers:

#numbered-example(
  (
    header: [Middle Welsh; modified from _Grammatical number in Welsh_ (1999) by Silva Nurmio (§~2.1.1)],
    source: ([ac], [ny], [allvs], [y], [dewinyon], [atteb], [idav]),
    morphemes: ([and], [#neg], [be_able.#smallcaps[pret].3#sg], [#smallcaps[def]], [sorcerer.#pl], [answer.#smallcaps[inf]], [to.3#sg.#smallcaps[m]]),
    translation: [and the sorcerers could not answer him],
  ),
  label: \"sorcerers\",
  label-supplement: [Example]
)

As we have seen in @sorcerers, […].", addl-bindings: (neg: neg, sg: sg, pl: pl))

Labelling uses the Typst #link("https://typst.app/docs/reference/model/figure/")[figure] document element. The `label-supplement`
parameter fills in the `suppliment` parameter of a `figure`, which is `[example]` by default.
Note that `label` and `label-supplement` are top-level arguments of `example()` and `numbered-example()`, not of the interlinear glosses surrounded by `(` and `)`.

Labelling of sub-examples is possible as well, using the same `label` and `label-supplement` fields but within the parentheses surrounding the sub-example in question.

#codeblock(
"#numbered-example(
    header: [Hausa; from _Toward a functional typology of adpositions_ (2022) by Zygmunt Frajzyngier (§~3.2)],
    label: \"hausa\",
    (
        source: ([àkwai], [mutā̀nè], [dà], [yawā̀], [a], [kanṑ]),
        morphemes: ([exist], [People], [#smallcaps[assc]], [many], [#pred], [Kano]),
        translation: [There are a lot of people in Kano.],
        label: \"people\"
    ),
    (
        source: ([àkwai], [makar̃antā], [a], [nan], [gàrin]),
        morphemes: ([exist], [school], [#pred], [#dem], [town]),
        translation: [There is a school in this town.],
        label: \"school\",
    ),
)

In @hausa there are two sub-examples: @people deals with people and @school with a school.
", addl-bindings: (pred: pred, dem: dem))

The parameter `num-pattern` can be provided to `example`, which accepts 
#link("https://typst.app/docs/reference/model/numbering/")[Typst numbering syntax]
to format examples.

= Standard Abbreviations

The Leipzig Glossing Rules define a commonly-used set of short abbreviations
for grammatical terms used in glosses, such as #abbreviations.acc for
"accusative (case)", or #abbreviations.ptcp for "participle" (see "Appendix:
List of Standard Abbreviations in the Leipzig Glossing Rules document)


By convention, these are typeset using #smallcaps[smallcaps]. This package
contains a module value `abbreviations`. Individual abbreviations may be
accessed either with Typst field access notation or by importing them from
`abbreviations`:


#codeblock(
"#import abbreviations: obl, sg, prf

#example(
  (
    header: [(from _Why Caucasian Languages?_, by Bernard Comrie, in _Endangered Languages of the Caucasus and Beyond_)],
    source: ([\[qálɐ-m], [∅-kw’-á\]], [ɬ’ə́-r]),
    morphemes: ([city-#obl], [3#sg\-go-#prf], [man-#abbreviations.abs]),
    translation: \"The man who went to the city.\"
  )
)", addl-bindings: (abbreviations: abbreviations), unevaled-first-line: "#import \"leipzig-gloss.typ\": abbreviations")


The full list of abbreviations is as follows:

== Full list of abbreviations

#{
for (abbreviation, description) in abbreviations.standard-abbreviations {
        [#abbreviations.render-abbreviation(abbreviation) - #raw(lower(abbreviation)) - #description ]
        linebreak()
    }
}

== Custom abbreviations

Custom abbreviations may be defined using the `abbreviations.emit-abbreviation` function:

#codeblock(
"#import abbreviations: obl, sg, prf, fut, emit-abbreviation

#let ts = emit-abbreviation(\"TS\")

#example(
  (
    header: [(from _Georgian: A Structural Reference Grammar_, by George Hewitt)],
    source: ([g-nax-av-en],),
    morphemes: ([you#sub[2]-see(#fut)#sub[4]-#ts#sub[7]-they#sub[11]],),
    translation: \"they will see you\",
  )
)", addl-bindings: (abbreviations: abbreviations), unevaled-first-line: "#import \"leipzig-gloss.typ\": abbreviations")

== Building used-abbreviations pages

A user of `leipzig-glossing` might wish to generate an introductory page
displaying which abbreviations were actually used in the document. The
`abbreviations.with-used-abbreviations` function may be used for this purpose;
see the `abbreviations-used-example.typ` file in `leipzig-glossing` source for an example.

= Further Example Glosses

These are the first twelve example glosses given in #link("https://www.eva.mpg.de/lingua/pdf/Glossing-Rules.pdf").
along with the Typst markup needed to generate them:

#{
    example-count.update(0)
}

#codeblock(
"#numbered-example(
  (
    header: [Indonesian (Sneddon 1996:237)],
    source: ([Mereka], [di], [Jakarta], [sekarang.]),
    morphemes: ([they], [in], [Jakarta], [now]),
    translation: \"They are in Jakarta now\",
  )
)")

#codeblock(
"#numbered-example(
  (
    header: [Lezgian (Haspelmath 1993:207)],
    source: ([Gila], [abur-u-n], [ferma], [hamišaluǧ], [güǧüna], [amuq’-da-č.]),
    morphemes: ([now], [they-#obl\-#gen], [farm], [forever], [behind], [stay-#fut\-#neg]),
    translation: \"Now their farm will not stay behind forever.\",
  )
)", addl-bindings: (fut: fut, neg: neg, obl: obl, gen:gen))

#codeblock(
"#numbered-example(
  (
    header: [West Greenlandic (Fortescue 1984:127)],
    source: ([palasi=lu], [niuirtur=lu]),
    morphemes: ([priest=and], [shopkeeper=and]),
    translation: \"both the priest and the shopkeeper\",
  )
)")

#codeblock(
"#numbered-example(
  (
    header: [Hakha Lai],
    source: ([a-nii -láay],),
    morphemes: ([3#sg\-laugh-#fut],),
    translation: [s/he will laugh],
  )
)", addl-bindings: (sg: sg, fut: fut))

#codeblock(
"#numbered-example(
  (
    header: [Russian],
    source: ([My], [s], [Marko], [poexa-l-i], [avtobus-om], [v], [Peredelkino]),
    morphemes: ([1#pl], [#com], [Marko], [go-#pst\-#pl], [bus-#ins], [#all], [Peredelkino]),
    additional-lines: (([we], [with], [Marko], [go-#pst\-#pl], [bus-by], [to], [Peredelkino]),),
    translation: \"Marko and I went to Perdelkino by bus\",
  )
)", addl-bindings: (com: com, pl: pl, ins: ins, all: all, pst:pst))

#codeblock(
"#numbered-example(
  (
    header: [Turkish],
    source: ([çık-mak],),
    morphemes: ([come.out-#inf],),
    translation: \"to come out\",
  )
)", addl-bindings: (inf: inf))

#codeblock(
"#numbered-example(
  (
    header: [Latin],
    source: ([insul-arum],),
    morphemes: ([island-#gen\-#pl],),
    translation: \"of the islands\",
  )
)", addl-bindings: (gen:gen, pl: pl))

#codeblock(
"#numbered-example(
  (
    header: [French],
    source: ([aux], [chevaux]),
    morphemes: ([to-#art\-#pl],[horse.#pl]),
    translation: \"to the horses\",
  )
)",addl-bindings: (art:art, pl:pl))

#codeblock(
"#numbered-example(
  (
    header: [German],
    source: ([unser-n], [Väter-n]),
    morphemes: ([our-#dat\-#pl],[father.#pl\-#dat.#pl]),
    translation: \"to our fathers\",
  )
)", addl-bindings: (dat:dat, pl:pl))

#codeblock(
"#numbered-example(
  (
    header: [Hittite (Lehmann 1982:211)],
    source: ([n=an], [apedani], [mehuni],[essandu.]),
    morphemes: ([#smallcaps[conn]=him], [that.#dat.#sg], [time.#dat.#sg], [eat.they.shall]),
    translation: \"They shall celebrate him on that date\",
  )
)", addl-bindings: (pl:pl, sg:sg, dat:dat))

#codeblock(
"#numbered-example(
  (
    header: [Jaminjung (Schultze-Berndt 2000:92)],
    source: ([nanggayan], [guny-bi-yarluga?]),
    morphemes: ([who], [2#du.#A.3#sg.#P\-#fut\-poke]),
    translation: \"Who do you two want to spear?\",
  )
)", addl-bindings: (du:du, sg:sg, fut:fut, A:A, P:P))


#codeblock("
#numbered-example(
  (
    header: [Turkish (cf. 6)],
    source: ([çık-mak],),
    morphemes: ([come_out-#inf],),
    translation: ['to come out'],
  )
)", addl-bindings: (inf: inf))
