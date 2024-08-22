#import "abbreviations.typ"

#let gloss-count = counter("gloss_count")

#let build-gloss(item-spacing, formatters, gloss-line-lists) = {
    assert(gloss-line-lists.len() > 0, message: "Gloss line lists cannot be empty")

    let len = gloss-line-lists.at(0).len()

    for line in gloss-line-lists {
        assert(line.len() == len)
    }

    assert(formatters.len() == gloss-line-lists.len(), message: "The number of formatters and the number of gloss line lists should be equal")

    let make_item_box(..args) = {
        box(stack(dir: ttb, spacing: 0.5em, ..args))
    }

    for item_index in range(0, len) {
        let args = ()
        for (line_idx, formatter) in formatters.enumerate() {
            let formatter_fn = if formatter == none {
                (x) => x
            } else {
                formatter
            }

            let item = gloss-line-lists.at(line_idx).at(item_index)
            args.push(formatter_fn(item))
        }
        make_item_box(..args)
        h(item-spacing)
    }
}

// a workround so we can use `label` as a variable name where it is shadowed by the function param `label`
// Once typst version 0.12 with https://github.com/typst/typst/pull/4038 is released we should be able
// to replace this workaround with `std.label`
#let cmdlabel = label 

#let gloss(
    label: none,
    label-supplement: [example],
    gloss-padding: 2.0em, //TODO document these
    left-padding: 0.5em,
    numbering: false,
    breakable: false,
    ..args
) = {
    // Typesets the internal part of the interlinear glosses. This function does not deal with the external matters of numbering and labelling.
    let typeset_gloss(
        header: none,
        header-style: none,
        source: (),
        source-style: none,
        transliteration: none,
        transliteration-style: none,
        morphemes: none,
        morphemes-style: none,
        additional-lines: (), //List of list of content
        translation: none,
        translation-style: none,
        item-spacing: 1em,
    ) = {
        assert(type(source) == "array", message: "source needs to be an array; perhaps you forgot to type `(` and `)`, or a trailing comma?")

        if morphemes != none {
            assert(type(morphemes) == "array", message: "morphemes needs to be an array; perhaps you forgot to type `(` and `)`, or a trailing comma?")
            assert(source.len() == morphemes.len(), message: "source and morphemes have different lengths")
        }

        if transliteration != none {
            assert(transliteration.len() == source.len(), message: "source and transliteration have different lengths")
        }

        let gloss_items = {

            if header != none {
                if header-style != none {
                    header-style(header)
                } else {
                    header
                }
                linebreak()
            }

            let formatters = (source-style,)
            let gloss-line-lists = (source,)

            if transliteration != none {
                formatters.push(transliteration-style)
                gloss-line-lists.push(transliteration)
            }

            if morphemes != none {
                formatters.push(morphemes-style)
                gloss-line-lists.push(morphemes)
            }

            for additional in additional-lines {
                formatters.push(none) //TODO fix this
                gloss-line-lists.push(additional)
            }


            build-gloss(item-spacing, formatters, gloss-line-lists)

            if translation != none {
                linebreak()

                if translation-style == none {
                    translation
                } else {
                    translation-style(translation)
                }
            }
        }

        align(left)[#gloss_items]
    }

    let add_subexample(subgloss, count) = {
        // Remove parameters which are not used in the `typeset_gloss`.
        // TODO Make this functional, if (or when) it’s possible in Typst: filter out `label` and `label-supplement` when they are passed below.
        let subgloss-internal = subgloss
        if "label" in subgloss-internal {
            let _ = subgloss-internal.remove("label")
        }
        if "label-supplement" in subgloss-internal {
            let _ = subgloss-internal.remove("label-supplement")
        }
        par()[
            #box()[
                #figure(
                    kind: "subgloss",
                    numbering: it => [#gloss-count.display()#count.display("a")],
                    outlined: false,
                    supplement: it => {if "label-supplement" in subgloss {return subgloss.label-supplement} else {return "example"}},
                    stack(
                        dir: ltr, //TODO this needs to be more flexible
                        [(#context count.display("a"))],
                        left-padding,
                        typeset_gloss(..subgloss-internal)
                    )
                ) #if "label" in subgloss {cmdlabel(subgloss.label)}
            ]
        ]
    }

    if numbering {
        gloss-count.step()
    }

    let gloss_number = if numbering {
        [(#context gloss-count.display())]
    } else {
        none
    }

    style(styles => {
        block(breakable: breakable)[
            #figure(
                kind: "gloss",
                numbering: it => [#gloss-count.display()],
                outlined: false,
                supplement: label-supplement,
                stack(
                    dir: ltr, //TODO this needs to be more flexible
                    left-padding,
                    [#gloss_number],
                    gloss-padding - left-padding - measure([#gloss_number],styles).width,
                    {
                        if args.pos().len() == 0 { // a single example, no sub-examples
                            typeset_gloss(..arguments(..args.named()))
                        }
                        else { // containing sub-examples
                            let subgloss-count = counter("subgloss_count")
                            subgloss-count.update(0)
                            set align(left)
                            if "header" in args.named() {
                                par[#args.named().header]
                            }
                            for subgloss in args.pos() {
                                subgloss-count.step()
                                add_subexample(subgloss, subgloss-count)
                            }
                        }
                    }
                ),
            ) #if label != none {cmdlabel(label)}
        ]
    }
    )
}

#let numbered-gloss = gloss.with(numbering: true)
