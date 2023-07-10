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
  "N-": "non- (e.g. NSG nonsingular, NPST nonpast)",
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
#let abl = { mark_used("ABL"); smallcaps[abl] }
#let abs = { mark_used("ABS");smallcaps[abs] }
#let acc = { mark_used("ACC");smallcaps[acc] }
#let adj = { mark_used("ADJ"); smallcaps[adj] }
#let adv = { mark_used("ADV"); smallcaps[adv] }
#let agr = { mark_used("AGR"); smallcaps[agr] }
#let all = { mark_used("ALL"); smallcaps[all] }
#let antip = { mark_used("ANTIP"); smallcaps[antip] }
#let appl = { mark_used("APPL"); smallcaps[appl] }
#let art = { mark_used("ART"); smallcaps[art] }
#let aux = { mark_used("AUX"); smallcaps[aux] }
#let ben = { mark_used("BEN"); smallcaps[ben] }
#let caus = { mark_used("CAUS"); smallcaps[caus] }
#let clf = { mark_used("CLF"); smallcaps[clf] }
#let com = { mark_used("COM"); smallcaps[com] }
#let comp = { mark_used("COMP"); smallcaps[comp] }
#let compl = { mark_used("COMPL"); smallcaps[compl] }
#let cond = { mark_used("COND"); smallcaps[cond] }
#let cop = { mark_used("COP"); smallcaps[cop] }
#let cvb = { mark_used("CVB"); smallcaps[cvb] }
#let dat = { mark_used("DAT"); smallcaps[dat] }
#let decl = { mark_used("DECL"); smallcaps[decl] }
#let def = { mark_used("DEF"); smallcaps[def] }
#let dem = { mark_used("DEM"); smallcaps[dem] }
#let det = { mark_used("DET"); smallcaps[det] }
#let dist = { mark_used("DIST"); smallcaps[dist] }
#let distr = { mark_used("DISTR"); smallcaps[distr] }
#let du = { mark_used("DU"); smallcaps[du] }
#let dur = { mark_used("DUR"); smallcaps[dur] }
#let erg = { mark_used("ERG"); smallcaps[erg] }
#let excl = { mark_used("EXCL"); smallcaps[excl] }
#let f = { mark_used("F"); smallcaps[f] }
#let foc = { mark_used("FOC"); smallcaps[foc] }
#let fut = { mark_used("FUT"); smallcaps[fut] }
#let gen = { mark_used("GEN"); smallcaps[gen] }
#let imp = { mark_used("IMP"); smallcaps[imp] }
#let incl = { mark_used("INCL"); smallcaps[incl] }
#let ind = { mark_used("IND"); smallcaps[ind] }
#let indf = { mark_used("INDF"); smallcaps[indf] }
#let inf = { mark_used("INF"); smallcaps[inf] }
#let ins = { mark_used("INS"); smallcaps[ins] }
#let intr = { mark_used("INTR"); smallcaps[intr] }
#let ipfv = { mark_used("IPFV"); smallcaps[ipfv] }
#let irr = { mark_used("IRR"); smallcaps[irr] }
#let loc = { mark_used("LOC"); smallcaps[loc] }
#let m = { mark_used("M"); smallcaps[m] }
#let n = { mark_used("N"); smallcaps[n] }
//TODO special handling?
//#let n- = { mark_used("N-"); smallcaps[n-] }
#let neg = { mark_used("NEG"); smallcaps[neg] }
#let nmlz = { mark_used("NMLZ"); smallcaps[nmlz] }
#let nom = { mark_used("NOM"); smallcaps[nom] }
#let obj = { mark_used("OBJ"); smallcaps[obj] }
#let obl = { mark_used("OBL"); smallcaps[obl] }
#let P = { mark_used("P"); smallcaps[p] }
#let pass = { mark_used("PASS"); smallcaps[pass] }
#let pfv = { mark_used("PFV"); smallcaps[pfv] }
#let pl = { mark_used("PL"); smallcaps[pl] }
#let poss = { mark_used("POSS"); smallcaps[poss] }
#let pred = { mark_used("PRED"); smallcaps[pred] }
#let prf = { mark_used("PRF"); smallcaps[prf] }
#let prs = { mark_used("PRS"); smallcaps[prs] }
#let prog = { mark_used("PROG"); smallcaps[prog] }
#let proh = { mark_used("PROH"); smallcaps[proh] }
#let prox = { mark_used("PROX"); smallcaps[prox] }
#let pst = { mark_used("PST"); smallcaps[pst] }
#let ptcp = { mark_used("PTCP"); smallcaps[ptcp] }
#let purp = { mark_used("PURP"); smallcaps[purp] }
#let q = { mark_used("Q"); smallcaps[q] }
#let quot = { mark_used("QUOT"); smallcaps[quot] }
#let recp = { mark_used("RECP"); smallcaps[recp] }
#let refl = { mark_used("REFL"); smallcaps[refl] }
#let rel = { mark_used("REL"); smallcaps[rel] }
#let res = { mark_used("RES"); smallcaps[res] }
#let s = { mark_used("S"); smallcaps[s] }
#let sbj = { mark_used("SBJ"); smallcaps[sbj] }
#let sbjv = { mark_used("SBJV"); smallcaps[sbjv] }
#let sg = { mark_used("SG"); smallcaps[sg] }
#let top = { mark_used("TOP"); smallcaps[top] }
#let tr = { mark_used("TR"); smallcaps[tr] }
#let voc = { mark_used("VOC"); smallcaps[voc] }

