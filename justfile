_default:
    just --list

# Build the leipzig-glossing documentation PDF
build-doc:
    typst compile documentation.typ

# Build the abbbreviations-used example
build-abbreviations-example:
    typst compile abbreviations-used-example.typ
