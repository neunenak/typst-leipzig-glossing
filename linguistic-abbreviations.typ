// See https://www.eva.mpg.de/lingua/resources/glossing-rules.php
#let standard_abbreviations = (
  "1": "first person",
  "2": "second person",
  "3": "third person",
  "A": "agent-like argument of canonical transitive verb",
  "ABL": "ablative",
  "ABS": "absolutive",
  "ACC": "accusative",
)

#let used_abbreviations_table = (:)
#let used_abbreviations = state("used-abbreviations", used_abbreviations_table)

#let print_usage_chart = {
  locate(loc => {
    let final_used_abbreviations = used_abbreviations.final(loc)
    for (key, value) in final_used_abbreviations {
      [#key was used: #value]
      linebreak()
    }

    linebreak()
    for (key, value) in final_used_abbreviations {
      if value {
        let desc = standard_abbreviations.at(key)
        [#smallcaps(lower(key)) #h(2em) #desc]
        linebreak()
      }
    }
  })
}


#let fmnt = smallcaps([fmnt])


//Appendix: List of Standard Abbreviations

#let mark_used(symbol) = {
  used_abbreviations.update(cur => {
    cur.insert(symbol, true)
    cur
  })
}

#let p1 = { mark_used("1"); smallcaps[1] }
#let p2 = { mark_used("2"); smallcaps[2] }
#let p3 = { mark_used("3"); smallcaps[3] }
#let A = { mark_used("A"); smallcaps[a] }
#let ABL = { mark_used("ABL"); smallcaps[abl] }
#let ABS = { mark_used("ABS");smallcaps[abs] }
#let ACC = { mark_used("ACC");smallcaps[acc] }


/*
ABL ablative
ABS absolutive
ACC accusative
ADJ adjective
ADV adverb(ial)
AGR agreement
ALL allative
ANTIP antipassive
APPL applicative
ART article
AUX auxiliary
BEN benefactive
*/

#let all = smallcaps([all])
#let art = smallcaps([art])

/*
CAUS causative
CLF classifier
COM comitative
COMP complementizer
COMPL completive
COND conditional
COP copula
CVB converb
DAT dative
DECL declarative
DEF definite
DEM demonstrative
DET determiner
DIST distal
*/
#let com = smallcaps([com])
#let dat = smallcaps([dat])

/*
DISTR distributive
DU dual
DUR durative
ERG ergative
EXCL exclusive
F feminine
FOC focus
FUT future
GEN genitive
IMP imperative
INCL inclusive
IND indicative
INDF indefinite
INF infinitive
INS instrumental
INTR intransitive
IPFV imperfective
*/

#let du = smallcaps([du])
#let fut = smallcaps([fut])
#let gen = smallcaps([gen])
#let inf = smallcaps([inf])
#let ins = smallcaps([ins])

/*
IRR irrealis
LOC locative
M masculine
N neuter
N- non- (e.g. NSG nonsingular, NPST nonpast)
NEG negation, negative
NMLZ nominalizer/nominalization
NOM nominative
OBJ object
OBL oblique
P patient-like argument of canonical transitive verb
PASS passive
PFV perfective
PL plural
*/

#let obl = smallcaps([obl])
#let neg = smallcaps([neg])
#let obj = smallcaps([obj])
#let pl = smallcaps([pl])
/*
POSS possessive
PRED predicative
PRF perfect
PRS present
PROG progressive
PROH prohibitive
PROX proximal/proximate
PST past
PTCP participle
PURP purposive
Q question particle/marker
QUOT quotative
RECP reciprocal
REFL reflexive
*/
#let P = smallcaps([p])
#let pos = smallcaps([pos])
#let prog = smallcaps([prog])
#let pst = smallcaps([pst])

/*
REL relative
RES resultative
S single argument of canonical intransitive verb
SBJ subject
SBJV subjunctive
SG singular
TOP topic
TR transitive
VOC vocative
*/

#let sg = smallcaps([sg])
#let sbj = smallcaps([sbj])
