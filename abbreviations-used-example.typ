#import "linguistic-abbreviations.typ": *

#let custom_abbreviations = (
  "FMNT": "Present/Future stem formant",
)

#let fmnt = emit_abbreviation("FMNT")

// An example function that uses `with_used_abbreviations`
#let print_usage_chart = with_used_abbreviations.with(debug: false)(final_used_abbreviations => {

    let print_abbrevs(abbrv_list) = {
      for abbrv in abbrv_list {
        let explanation = if abbrv in standard_abbreviations {
            standard_abbreviations.at(abbrv)
          } else {
            custom_abbreviations.at(abbrv)
          }

        [#smallcaps(lower(abbrv)) #h(2em) #explanation]
        linebreak()
      }
    }
  
    heading(level: 3)[Abbreviations in order of use]
    print_abbrevs(final_used_abbreviations.keys())

    heading(level: 3)[Abbreviations in alphabetical order]
    let sorted_abbreviations = final_used_abbreviations.keys().sorted()
    print_abbrevs(sorted_abbreviations)
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

