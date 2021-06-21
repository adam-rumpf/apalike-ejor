# apalike-ejor

<a href="https://www.ctan.org/pkg/apalike-ejor"><img src="https://img.shields.io/ctan/v/apalike-ejor"/></a> <a href="https://github.com/adam-rumpf/apalike-ejor/releases"><img src="https://img.shields.io/github/v/release/adam-rumpf/apalike-ejor"/></a> <a href="https://www.ctan.org/license/lppl1.3c"><img src="https://img.shields.io/github/license/adam-rumpf/apalike-ejor"/></a>

This is a BibTeX `apalike-ejor` bibliography style, forked from [`apalike`](https://www.bibtex.com/s/bibliography-style-base-apalike/) version 0.99a by Oren Patashnik. The original copyright and documentation are included in the file.

This file is also available from [CTAN](https://www.ctan.org/) as the [`apalike-ejor`](https://www.ctan.org/pkg/apalike-ejor) package.

## Description

This is a lightly modified APA-like bibliography style made in accordance with the European Journal of Operational Research [reference style guidelines](https://www.elsevier.com/journals/european-journal-of-operational-research/0377-2217/guide-for-authors).

Specific deviations from the original `apalike` settings include the following:
 * Changed "and" to "&" in lists of multiple authors.
 * Changed ":" to ", " between volume number and page numbers.
 * Added a hyperlinked URL field (requires `hyperref`).
 * Added a hyperlinked DOI field (requires `hyperref`).
 * Removed address information from publisher names.
 * Removed editor information, publisher information, and the words "In" and "pages" from conference proceedings.
 * Removed "Thesis" label and address from theses.
 * Changed book edition to follow the title in parentheses, and abbreviated "edition".
 * Added chapter and page number support for books.
 * Added a new dataset field for misc references. If it contains any value besides "0" or "false", the string "[dataset]" is prepended to the reference.
 * Moved the note field to the end of references (except for unpublished).

## Installation and Usage

To install this style file, download `apalike-ejor.bst` and place it somewhere where your LaTeX compiler can find it. The easiest way to do this is to place it in the same directory as your main TeX file, but depending on your system and distribution it is also possible to place it in a directory visible to your compiler. This requires careful consideration of your directory structure.

In my case, as a user of [MiKTeX](https://miktex.org/), I created a `LocalTeXMF/` directory and saved the file as `/LocalTeXMF/bibtex/bst/bibtex/apalike-ejor.bst`. I then opened the MiKTeX console and added `LocalTeXMF/` to my list of TEXMF root directories.

After the style file is installed, it can be applied to a TeX file by using `\bibliographystyle{apalike-ejor}` before generating the bibliography. The included `example.pdf` shows an example of how to generate a document with `apalike-ejor` as its BibTeX style.

## Project Maintenance

I (Adam Rumpf) wrote this modification for my own personal use in submitting a paper to EJOR. I've made it publicly available just in case anyone is interested, but if I'm being honest I am unlikely to perform much maintenance on it unless I come across a bug during my own usage. For this reason I encourage anyone to use or modify it however they wish to suit their own purposes.
