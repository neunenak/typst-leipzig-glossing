#let gloss_count = counter("gloss_count")

#let build_gloss(
    interword_spacing,
    formatters,
    gloss_line_lists,
    nlevel
) = {
    assert(gloss_line_lists.len() > 0, message: "Gloss line lists cannot be empty")

    let item_list = if nlevel == true{
        gloss_line_lists
    } else {
        gloss_line_lists.at(0)
    }

    let line_list = if nlevel == true {
        gloss_line_lists.at(0)
    } else {
        gloss_line_lists
    }

    let line_len = item_list.len()
    let n_lines = line_list.len()

    assert(formatters.len() == n_lines, message: "The number of formatters and the number of gloss lines should be equal")

    let make_item_box(..args) = {
        box(stack(dir: ttb, spacing: 0.5em, ..args))
    }

    for (item_idx,_) in item_list.enumerate() {
        let args = ()
        for (line_idx, formatter) in formatters.enumerate() {
            let formatter_fn = if formatter == none {
                (x) => x
            } else {
                formatter
            }

            let first_idx = if nlevel {
                item_idx
            } else {
                line_idx
            }
            let second_idx =  if nlevel {
                line_idx
            } else {
                item_idx
            }
            let item_group = gloss_line_lists.at(first_idx)
            let item = item_group.at(second_idx)
            args.push(formatter_fn(item))
        }
        make_item_box(..args)
        if item_idx < line_len - 1 {
            h(interword_spacing)
        }
    }
}


#let gloss(
    header_text: none,
    header_text_style: none,
    post_header_space: .5em,
    source_text: none,
    source_text_style: emph,
    transliteration: none,
    transliteration_style: none,
    morphemes: none,
    morphemes_style: none,
    gloss_lines: (), // List of lists of content,
    line_styles: (),
    translation: none,
    translation_style: none,
    pre_translation_space: .5em,
    interword_spacing: 1em,
    left_padding: .5em,
    gloss_padding: 2em,
    numbering: false,
    nlevel: false,
    breakable: false,
) = {
    if source_text != none {
        assert(type(source_text)=="array", message: "source_text needs to be an array; perhaps you forgot to type `(` and `)`, or a trailing comma?")
    }
    if morphemes != none {
        assert(type(morphemes)=="array", message: "morphemes needs to be an array; perhaps you forgot to type `(` and `)`, or a trailing comma?")
    }
    if transliteration != none {
        assert(type(transliteration)=="array", message: "transliteration needs to be an array; perhaps you forgot to type `(` and `)`, or a trailing comma?")
    }

    let gloss_items = {

        if header_text != none {
            if header_text_style != none{
                header_text_style(header_text)
            }
            else {
                header_text
            }
            v(post_header_space)
        }

        let formatters = ()
        let gloss_lists = ()

        if source_text != none {
            formatters.push(source_text_style)
            gloss_lists.push(source_text)
        }
        if transliteration != none {
            formatters.push(transliteration_style)
            gloss_lists.push(transliteration)
        }
        if morphemes != none {
            formatters.push(morphemes_style)
            gloss_lists.push(morphemes)
        }

        let n_lines = if nlevel {
            gloss_lines.at(0).len()
        } else {
            gloss_lines.len()
        }
        let n_styles = line_styles.len()
        for idx in range(0,n_lines) {
            if idx < n_styles {
                formatters.push(line_styles.at(idx))
            } else {
                formatters.push(none)
            }
        }
        
        for gloss_group in gloss_lines {
            assert(type(gloss_group)=="array", message: "gloss_lines must consist of nested lists")
            gloss_lists.push(gloss_group)
        }

        build_gloss(interword_spacing,formatters,gloss_lists,nlevel)

        if translation != none {
            v(pre_translation_space)
            if translation_style != none{
                translation_style(translation)
            }
            else {
                translation
            }
        }
    }

    if numbering {
        gloss_count.step()
    }
    
    let gloss_number = if numbering {
        [(#gloss_count.display())]
    } else {
        none
    }

    style(styles => {
        block(breakable: breakable)[
            #stack(
            dir:ltr,
            left_padding,
            [#gloss_number],
            gloss_padding - left_padding - measure([#gloss_number],styles).width,
            [#gloss_items]
            )
        ]
    }
    )
}

#let numbered_gloss = gloss.with(numbering:true)

#let nogloss = " "
