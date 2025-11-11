-- stylua: ignore start
-- stylua: ignore start
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("wup", fmt([[
---
title: "{}"
challenge: "{}"
difficulty: "{}"
platform: "{}"
date: "{}"
tags: [{}]
author: "Ryan Bouchou"
status: "in-progress"
---

# {}

**Résumé (1-2 lignes)**
{}

---

## Contexte

- Source : {}
- Environnement testé : {}
- Fichiers fournis : {}

---

## Objectif

{}

---

## Outils

- gdb + gef / pwndbg
- pwntools (python3)
- readelf / objdump / strings / file

---

## Analyse

### 1) Reconnaissance statique

{}

### 2) Analyse dynamique

{}

### 3) Exploit

Stratégie : {}

Payload (extrait) :
```py
from pwn import *
context.update(arch='amd64', timeout=2)
p = process('./build/a.out')
{}
p.interactive()
```

---

## Résultat

{}

## Root cause

{}

## Mitigation

{}

## Leçons apprises / next steps

{}

## Commandes & références

{}

## Artefacts

{}
]], {
    i(1, "Titre du challenge"),
    i(2, "root-me/picoCTF"),
    i(3, "Easy"),
    i(4, "amd64/remote"),
    i(5, "YYYY-MM-DD"),
    i(6, "binary,overflow"),
    i(7, "Titre lisible"),
    i(8, "Résumé court..."),
    i(9, "root-me / cours / picoCTF"),
    i(10, "Ubuntu 22.04, amd64, glibc 2.35"),
    i(11, "vuln, main.c, libc.so"),
    i(12, "Récupérer la flag / obtenir un shell"),
    i(13, "- commandes & observations"),
    i(14, "- breakpoints, comportement runtime"),
    i(15, "ret2libc / overflow / format-string"),
    i(16, "p.sendline(b'...')"),
    i(17, "- Flag : CTF{...}"),
    i(18, "Explication courte du bug"),
    i(19, "- corrections proposées"),
    i(20, "- pistes d'amélioration"),
    i(21, "- readelf -a binary"),
    i(22, "- exploit.py, build/"),
  }))
}
