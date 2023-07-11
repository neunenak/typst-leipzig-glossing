// See https://www.eva.mpg.de/lingua/resources/glossing-rules.php
#let standard_abbreviations = (
  "1": "first person",
  "2": "second person",
  "3": "third person",
  "A": "agent-like argument of canonical transitive verb",
  "ABL": "ablative",
  "ABS": "absolutive",
  "ACC": "accusative",
  "ADJ": "adjective",
  "ADV": "adverb(ial)",
  "AGR": "agreement",
  "ALL": "allative",
  "ANTIP": "antipassive",
  "APPL": "applicative",
  "ART": "article",
  "AUX": "auxiliary",
  "BEN": "benefactive",
  "CAUS": "causative",
  "CLF": "classifier",
  "COM": "comitative",
  "COMP": "complementizer",
  "COMPL": "completive",
  "COND": "conditional",
  "COP": "copula",
  "CVB": "converb",
  "DAT": "dative",
  "DECL": "declarative",
  "DEF": "definite",
  "DEM": "demonstrative",
  "DET": "determiner",
  "DIST": "distal",
  "DISTR": "distributive",
  "DU": "dual",
  "DUR": "durative",
  "ERG": "ergative",
  "EXCL": "exclusive",
  "F": "feminine",
  "FOC": "focus",
  "FUT": "future",
  "GEN": "genitive",
  "IMP": "imperative",
  "INCL": "inclusive",
  "IND": "indicative",
  "INDF": "indefinite",
  "INF": "infinitive",
  "INS": "instrumental",
  "INTR": "intransitive",
  "IPFV": "imperfective",
  "IRR": "irrealis",
  "LOC": "locative",
  "M": "masculine",
  "N": "neuter",
  "N-": [non- (e.g. #smallcaps[nsg] nonsingular, #smallcaps[npst] nonpast)],
  "NEG": "negation, negative",
  "NMLZ": "nominalizer/nominalization",
  "NOM": "nominative",
  "OBJ": "object",
  "OBL": "oblique",
  "P": "patient-like argument of canonical transitive verb",
  "PASS": "passive",
  "PFV": "perfective",
  "PL": "plural",
  "POSS": "possessive",
  "PRED": "predicative",
  "PRF": "perfect",
  "PRS": "present",
  "PROG": "progressive",
  "PROH": "prohibitive",
  "PROX": "proximal/proximate",
  "PST": "past",
  "PTCP": "participle",
  "PURP": "purposive",
  "Q": "question particle/marker",
  "QUOT": "quotative",
  "RECP": "reciprocal",
  "REFL": "reflexive",
  "REL": "relative",
  "RES": "resultative",
  "S": "single argument of canonical intransitive verb",
  "SBJ": "subject",
  "SBJV": "subjunctive",
  "SG": "singular",
  "TOP": "topic",
  "TR": "transitive",
  "VOC": "vocative",
)


#let used_abbreviations = state("used-abbreviations", (:))

#let print_usage_chart = {
  locate(loc => {
    let final_used_abbreviations = used_abbreviations.final(loc)

    //TODO this is debugging get rid of soon
    for (key, value) in final_used_abbreviations {
      [#key was used: #value]
      linebreak()
    }

    linebreak()
    //TODO requires standard_abbreviations to be sorted alphabetically, can this be enforced?
    for (abbrv, explanation) in standard_abbreviations {
      if abbrv in final_used_abbreviations {
        [#smallcaps(lower(abbrv)) #h(2em) #explanation]
        linebreak()
      }
    }
  })
}


#let fmnt = smallcaps([fmnt])

#let emit_abbreviation(symbol) = {
  let mark_used(symbol) = {
    used_abbreviations.update(cur => {
      cur.insert(symbol, true)
      cur
    })
  }

  mark_used(symbol)
  smallcaps(lower(symbol))
}


#let p1 = emit_abbreviation("1")
#let p2 = emit_abbreviation("2")
#let p3 = emit_abbreviation("3")
#let A = emit_abbreviation("A")
#let abl = emit_abbreviation("ABL")
#let abs = emit_abbreviation("ABS")
#let acc = emit_abbreviation("ACC")
#let adj = emit_abbreviation("ADJ")
#let adv = emit_abbreviation("ADV")
#let agr = emit_abbreviation("AGR")
#let all = emit_abbreviation("ALL")
#let antip = emit_abbreviation("ANTIP")
#let appl = emit_abbreviation("APPL")
#let art = emit_abbreviation("ART")
#let aux = emit_abbreviation("AUX")
#let ben = emit_abbreviation("BEN")
#let caus = emit_abbreviation("CAUS")
#let clf = emit_abbreviation("CLF")
#let com = emit_abbreviation("COM")
#let comp = emit_abbreviation("COMP")
#let compl = emit_abbreviation("COMPL")
#let cond = emit_abbreviation("COND")
#let cop = emit_abbreviation("COP")
#let cvb = emit_abbreviation("CVB")
#let dat = emit_abbreviation("DAT")
#let decl = emit_abbreviation("DECL")
#let def = emit_abbreviation("DEF")
#let dem = emit_abbreviation("DEM")
#let det = emit_abbreviation("DET")
#let dist = emit_abbreviation("DIST")
#let distr = emit_abbreviation("DISTR")
#let du = emit_abbreviation("DU")
#let dur = emit_abbreviation("DUR")
#let erg = emit_abbreviation("ERG")
#let excl = emit_abbreviation("EXCL")
#let f = emit_abbreviation("F")
#let foc = emit_abbreviation("FOC")
#let fut = emit_abbreviation("FUT")
#let gen = emit_abbreviation("GEN")
#let imp = emit_abbreviation("IMP")
#let incl = emit_abbreviation("INCL")
#let ind = emit_abbreviation("IND")
#let indf = emit_abbreviation("INDF")
#let inf = emit_abbreviation("INF")
#let ins = emit_abbreviation("INS")
#let intr = emit_abbreviation("INTR")
#let ipfv = emit_abbreviation("IPFV")
#let irr = emit_abbreviation("IRR")
#let loc = emit_abbreviation("LOC")
#let m = emit_abbreviation("M")
#let n = emit_abbreviation("N")
#let non = emit_abbreviation("N-")
#let neg = emit_abbreviation("NEG")
#let nmlz = emit_abbreviation("NMLZ")
#let nom = emit_abbreviation("NOM")
#let obj = emit_abbreviation("OBJ")
#let obl = emit_abbreviation("OBL")
#let P = emit_abbreviation("P")
#let pass = emit_abbreviation("PASS")
#let pfv = emit_abbreviation("PFV")
#let pl = emit_abbreviation("PL")
#let poss = emit_abbreviation("POSS")
#let pred = emit_abbreviation("PRED")
#let prf = emit_abbreviation("PRF")
#let prs = emit_abbreviation("PRS")
#let prog = emit_abbreviation("PROG")
#let proh = emit_abbreviation("PROH")
#let prox = emit_abbreviation("PROX")
#let pst = emit_abbreviation("PST")
#let ptcp = emit_abbreviation("PTCP")
#let purp = emit_abbreviation("PURP")
#let q = emit_abbreviation("Q")
#let quot = emit_abbreviation("QUOT")
#let recp = emit_abbreviation("RECP")
#let refl = emit_abbreviation("REFL")
#let rel = emit_abbreviation("REL")
#let res = emit_abbreviation("RES")
#let s = emit_abbreviation("S")
#let sbj = emit_abbreviation("SBJ")
#let sbjv = emit_abbreviation("SBJV")
#let sg = emit_abbreviation("SG")
#let top = emit_abbreviation("TOP")
#let tr = emit_abbreviation("TR")
#let voc = emit_abbreviation("VOC")

