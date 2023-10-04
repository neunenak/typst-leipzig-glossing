default:
    just --list


# Build the leipzig-glossing documentation PDF
build-doc:
    typst compile documentation.typ


build-abbreviations-example:
    typst compile abbreviations-used-example.typ
