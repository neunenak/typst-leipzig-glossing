default:
    just --list


build-example:
    typst compile leipzig-gloss-examples.typ


build-abbreviations-example:
    typst compile abbreviations-used-example.typ
