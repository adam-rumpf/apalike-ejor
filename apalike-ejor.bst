% apalike-ejor v1.2.0
% Copyright (C) 2021 Adam Rumpf
%
% BibTeX `apalike-ejor' bibliography style, forked from the `apalike' style,
% version 0.99a, by Oren Patashnik. The original copyright and documentation
% are included below.
%
% This is a lightly modified APA-like bibliography style made in accordance
% with the European Journal of Operational Research reference style guidelines
% <https://www.elsevier.com/journals/european-journal-of-operational-research/
%  0377-2217/guide-for-authors>
%
% Specific deviations from the original apalike settings include the following:
%  - Changed `and' to `\&' in lists of multiple authors.
%  - Changed `:' to `, ' between volume number and page numbers.
%  - Added a hyperlinked URL field (requires hyperref).
%  - Added a hyperlinked DOI field (requires hyperref). If both the DOI and
%      URL fields are present, the DOI is preferred.
%  - Removed address information from publisher names.
%  - Removed editor information, publisher information, and the words "In" and
%      "pages" from conference proceedings.
%  - Removed thesis label and address from theses.
%  - Book edition numbers are in parentheses following the title, and
%    abbreviated "edition" to "ed.".
%  - Added an optional chapter number for books.
%  - Added a new dataset field for misc references. If it contains any value
%      besides "0" or "false", the string "[dataset]" is prepended to the
%      reference.
%  - Moved the note field to the end of references (except for unpublished).
%
% =============================================================================
%
% BibTeX `apalike' bibliography style (version 0.99a, 8-Dec-10), adapted from
% the `alpha' style, version 0.99a; for BibTeX version 0.99a.
%
% Copyright (C) 1988, 2010 Oren Patashnik.
% Unlimited copying and redistribution of this file are permitted as long as
% it is unmodified.  Modifications (and redistribution of modified versions)
% are also permitted, but only if the resulting file is renamed.
%
% Differences between this style and `alpha' are generally heralded by a `%'.
% The file btxbst.doc has the documentation for alpha.bst.
%
% This style should be used with the `apalike' LaTeX style (apalike.sty).
% \cite's come out like "(Jones, 1986)" in the text but there are no labels
% in the bibliography, and something like "(1986)" comes out immediately
% after the author.  Author (and editor) names appear as last name, comma,
% initials.  A `year' field is required for every entry, and so is either
% an author (or in some cases, an editor) field or a key field.
%
% Editorial note:
% Many journals require a style like `apalike', but I strongly, strongly,
% strongly recommend that you not use it if you have a choice---use something
% like `plain' instead.  Mary-Claire van Leunen (A Handbook for Scholars,
% Knopf, 1979) argues convincingly that a style like `plain' encourages better
% writing than one like `apalike'.  Furthermore the strongest arguments for
% using an author-date style like `apalike'---that it's "the most practical"
% (The Chicago Manual of Style, University of Chicago Press, thirteenth
% edition, 1982, pages 400--401)---fall flat on their face with the new
% computer-typesetting technology.  For instance page 401 anachronistically
% states "The chief disadvantage of [a style like `plain'] is that additions
% or deletions cannot be made after the manuscript is typed without changing
% numbers in both text references and list."  LaTeX sidesteps the disadvantage.
%
% History:
%   15-sep-86  (OP)  Original version by Oren Patashnik, ideas from Susan King.
%   10-nov-86  (OP)  Truncated the sort.key$ string to the correct length
%                    in bib.sort.order to eliminate error message.
%   24-jan-88  (OP)  Updated for BibTeX version 0.99a, from alpha.bst 0.99a;
%                    apalike now sorts by author, then year, then title;
%                    THIS `apalike' VERSION DOES NOT WORK WITH BIBTEX 0.98i.
%    8-dec-10  (OP)  Still version 0.99a, as the code itself was unchanged;
%                    this release clarified the license.
%   18-jun-21  (AR)  Modifications made by Adam Rumpf to comply with the EJOR
%                    bibliography style guide.
%   21-jun-21  (AR)  Modified misc formatting and added dataset field support.

ENTRY
  { address
    author
    booktitle
    chapter
    dataset                % unique field added for apalike-ejor
    doi              % added for apalike-ejor
    edition
    editor
    howpublished
    institution
    journal
    key
%    month              not used in apalike
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url              % added for apalike-ejor
    volume
    year
  }
  {}
  { label extra.label sort.label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

%                                       apalike needs this function because
%                                       the year has special punctuation;
%                                       apalike ignores the month
FUNCTION {output.year.check}
{ year empty$
    { "empty year in " cite$ * warning$ }
    { write$
      " (" year * extra.label * ")" *
      mid.sentence 'output.state :=
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {fin.npentry}    % no-period final entry for apalike-ejor
{ write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {format.doi}   % doi field for apalike-ejor
{ doi empty$
    { "" }
    { "\url{https://doi.org/" doi * "}" * }
  if$
}


FUNCTION {format.url}    % url field for apalike-ejor
{ url empty$
    { "" }
    { "\url{" url * "}" * }
  if$
}

FUNCTION {format.urlending}    % formats ending for doi and/or url fields
{
  doi missing$
    { 
      url missing$
        { note output
          fin.entry
        }
        { new.block                % use url if no doi
          format.url output
          note missing$
            { fin.npentry }
            { new.block
              note output
              fin.npentry
            }
          if$
        }
      if$
    }
    { new.block              % use doi if present
      format.doi output
      note missing$
        { fin.npentry }
        { new.block
          note output
          fin.npentry
        }
      if$
    }
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{vv~}{ll}{, jj}{, f.}" format.name$ 't :=   % last name first
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { numnames #2 >
                { "," * }
                'skip$
              if$
              t "others" =
                { " et~al." * }
                { " \& " * t * }   % ampersand for apalike-ejor
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.key}                   % this function is just for apalike
{ empty$
    { key field.or.null }
    { "" }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { ", editors" * }
        { ", editor" * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
      series empty$
        'skip$
        { " of " * series emphasize * }
      if$
      "volume \& number" number either.or.check   % ampersand for apalike-ejor
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { "number" }
            { "Number" }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { " in " * series * }
          if$
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { "(" edition * "l" change.case$ " ed.)" * } % changed for apalike-ejor
        { "(" edition * "t" change.case$ " ed.)" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { pages n.dashify }    %removed "page" and "pages" for apalike-ejor
        { pages }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ", " * pages n.dashify * } % replaced : with , for apalike-ejor
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "(Chapter" }                % capitalizing for apalike-ejor
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        { ")" * }
        { ", " * format.pages * ")" * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}    % removed editor names for apalike-ejor
{ %booktitle empty$
%    { "" }
%    { editor empty$
%        { "In " booktitle emphasize * }
%        { "In " format.editors * ", " * booktitle emphasize * }
%      if$
%    }
%  if$
  booktitle emphasize
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ "In"                                                  % this is for apalike
  " \cite{" * crossref * "}" *
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  "\cite{" * crossref * "}" *                           % this is for apalike
}

FUNCTION {format.incoll.inproc.crossref}
{ "In"                                                  % this is for apalike
  " \cite{" * crossref * "}" *
}

FUNCTION {format.dataset}                % unique "dataset" field for apalike
{ dataset empty$      % prints "[dataset]" for any value besides "0" or "false"
    { "" }
    { dataset "0" = dataset "l" change.case$ "false" = or
      { "" }
      { "[dataset]" }
      if$
    }
  if$
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.pages output
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author \& editor" output.check   % & for apalike-ejor
      editor format.key output
    }
    { format.authors output.nonnull
      crossref missing$
        { "author \& editor" editor either.or.check }   % & for apalike-ejor
        'skip$
      if$
    }
  if$
  output.year.check                             % special for apalike
  new.block
  edition missing$              % moved and reformatted ed. for apalike-ejor
    { format.btitle output
    }
    { format.btitle " " * format.edition * output
    }
  if$
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      chapter missing$                % adding chapter number for apalike-ejor
        { publisher output
        }
        { publisher " " * format.chapter.pages * output
        }
      if$
%      address output               removing publisher address for apalike-ejor
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.title "title" output.check
  new.block
  howpublished output
  address output
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author \& editor" output.check   % & for apalike-ejor
      editor format.key output
    }
    { format.authors output.nonnull
      crossref missing$
        { "author \& editor" editor either.or.check }   % & for apalike-ejor
        'skip$
      if$
    }
  if$
  output.year.check                             % special for apalike
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter \& pages" output.check % & for apalike-ejor
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
%      address output                removing publisher address for apalike-ejor
    }
    { format.chapter.pages "chapter \& pages" output.check % & for apalike-ejor
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
%      address output               removing publisher address for apalike-ejor
      format.edition output
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
%      address output                  % for apalike % removed for apalike-ejor
%      new.sentence                                      % there's no year
%      organization output                               % here so things
%      publisher output                                  % are simpler
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  format.authors output
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.btitle "title" output.check
  organization address new.block.checkb
  organization output
  address output
  format.edition output
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.title "title" output.check
  new.block
%  "Master's thesis" format.thesis.type output.nonnull  remove for apalike-ejor
  school "school" output.check
%  address output                % removing address for apalike-ejor
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {misc}
{ output.bibitem
  format.dataset "" =                 % unique "dataset" field for apalike-ejor
    { skip$ }
    { format.dataset " " * write$ }
  if$
  format.authors output
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.title emphasize output
  new.block
  howpublished output
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.btitle "title" output.check
  new.block
%  "PhD thesis" format.thesis.type output.nonnull       remove for apalike-ejor
  school "school" output.check
%  address output                % removing address for apalike-ejor
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {proceedings}
{ output.bibitem
%  format.editors output                removing editors for apalike-ejor
%  editor format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
%  address output                      % for apalike % removed for apalike-ejor
  new.sentence                                  % we always output
  organization output                           % a nonempty organization
  publisher output                              % here
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  new.block
%  note output                % note handled in urlending
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  new.block
  format.title "title" output.check
  new.block
  note "note" output.check
  format.urlending              % auto-formatted doi/url ending
}

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

%                       There are three apalike cases: one person (Jones),
%                       two (Jones and de~Bruijn), and more (Jones et~al.).
%                       This function is much like format.crossref.editors.
%
FUNCTION {format.lab.names}
{ 's :=
  s #1 "{vv~}{ll}" format.name$
  s num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
        'skip$
        { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            { " et~al." * }
            { " \& " * s #2 "{vv~}{ll}" format.name$ * }   % & for apalike-ejor
          if$
        }
      if$
    }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key                                    % apalike uses the whole key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key                                % apalike uses the whole key
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.label}
{ editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key                    % apalike uses the whole key, no organization
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.label                       % apalike ignores organization
        'author.key.label                       % for labeling and sorting
      if$
    }
  if$
  ", "                                                  % these three lines are
  *                                                     % for apalike, which
  year field.or.null purify$ #-1 #4 substring$          % uses all four digits
  *
  'label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$                                               % apalike uses initials
      s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't := % <= here
      nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.sort}
{ editor empty$
    { key empty$
        { "to sort, need editor or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

%                       apalike uses two sorting passes; the first one sets the
%                       labels so that the `a's, `b's, etc. can be computed;
%                       the second pass puts the references in "correct" order.
%                       The presort function is for the first pass. It computes
%                       label, sort.label, and title, and then concatenates.
FUNCTION {presort}
{ calc.label
  label sortify
  "    "
  *
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.sort
        'author.sort
      if$
    }
  if$
  #1 entry.max$ substring$      % for
  'sort.label :=                % apalike
  sort.label                    % style
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT            % by label, sort.label, title---for final label calculation

STRINGS { last.label next.extra }       % apalike labels are only for the text;

INTEGERS { last.extra.num }             % there are none in the bibliography

FUNCTION {initialize.extra.label.stuff} % and hence there is no `longest.label'
{ #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  label extra.label * 'label :=
  extra.label 'next.extra :=
}

EXECUTE {initialize.extra.label.stuff}

ITERATE {forward.pass}

REVERSE {reverse.pass}

%                               Now that the label is right we sort for real,
%                               on sort.label then year then title.  This is
%                               for the second sorting pass.
FUNCTION {bib.sort.order}
{ sort.label
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {bib.sort.order}

SORT            % by sort.label, year, title---giving final bibliography order

FUNCTION {begin.bib}
{ preamble$ empty$                              % no \etalchar in apalike
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{}" write$ newline$           % no labels in apalike
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
