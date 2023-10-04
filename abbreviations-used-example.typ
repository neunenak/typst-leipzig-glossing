#import "abbreviations.typ": *

#let custom-abbreviations = (
  "FMNT": "Present/Future stem formant",
)

#let fmnt = emit-abbreviation("FMNT")

// An example function that uses `with-used-abbreviations`
#let print_usage_chart = with-used-abbreviations(final-used-abbreviations => {

    show terms: t => {
      for t in t.children [
      #t.term #h(2cm) #t.description\
      ]
    }

    let print-abbrevs(abbrv_list) = {
      for abbrv in abbrv_list {
        let explanation = if abbrv in standard-abbreviations {
            standard-abbreviations.at(abbrv)
          } else {
            custom-abbreviations.at(abbrv)
          }

        terms((smallcaps(lower(abbrv)), explanation))
      }
    }
  
    heading(level: 3)[Abbreviations in order of use]
    print-abbrevs(final-used-abbreviations.keys())

    heading(level: 3)[Abbreviations in alphabetical order]
    let sorted-abbreviations = final-used-abbreviations.keys().sorted()
    print-abbrevs(sorted-abbreviations)
})

= Some linguistics paper


== Abbreviations used in this document
#print_usage_chart

== The main body of the paper


The #p1#sg pronoun in Spanish is _yo_. The #p2#sg pronoun in Spanish is _tu_.

The six cases of Latin are:
  - Nominative (#nom)
  - Genitive (#gen)
  - Dative (#dat)
  - Accusative (#acc)
  - Ablative (#abl)
  - Vocative (#voc)

The Present/Future stem formant (#fmnt) in Georgian disappears in perfective screeves.

