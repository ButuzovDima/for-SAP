*&---------------------------------------------------------------------*
*& Report Z_TEST3_SELECT_SCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_TEST3_SELECT_SCREEN.

*tables: acdoca.

DATA: t_rbukrs type acdoca-rbukrs.
DATA: t_gjahr  type acdoca-gjahr.
DATA: t_poper  type acdoca-poper.
DATA: t_racct  type acdoca-racct.
DATA: t_hsl    type acdoca-hsl.

DATA: sum_hsl(10) type i.

DATA: begin of ls_acdoca,
      ls_rbukrs type acdoca-rbukrs,
      ls_gjahr  type acdoca-gjahr,
      ls_poper  type acdoca-poper,
*      ls_belnr  type acdoca-belnr,
      ls_racct  type acdoca-racct,
      ls_hsl    type acdoca-hsl,
  end of ls_acdoca.

data: lt_acdoca like table of ls_acdoca with header line.
data: p_racct(10) type c.

SELECT-OPTIONS: s_rbukrs FOR t_rbukrs,
                s_gjahr  FOR t_gjahr,
                s_poper  FOR t_poper.

END-OF-SELECTION.

select rbukrs gjahr
  poper
  racct hsl from acdoca
  into table lt_acdoca
  where rbukrs in s_rbukrs and
        gjahr  in s_gjahr  and
        poper  in s_poper.

sort lt_acdoca by ls_racct.

sum_hsl = 0.
loop at lt_acdoca.
  p_racct = lt_acdoca-ls_racct.
  exit.
endloop.

loop at lt_acdoca.
  if lt_acdoca-ls_racct ne p_racct.
    write: / t_rbukrs,
             t_gjahr,
             t_poper,
             t_racct,
             sum_hsl.

    sum_hsl = 0.
    p_racct = lt_acdoca-ls_racct.
    sum_hsl = sum_hsl + lt_acdoca-ls_hsl.
  else.
    sum_hsl = sum_hsl + lt_acdoca-ls_hsl.
  endif.

* медленно??------------------

  at last.
    t_rbukrs = lt_acdoca-ls_rbukrs.
    t_gjahr  = lt_acdoca-ls_gjahr.
    t_poper  = lt_acdoca-ls_poper.
    t_racct  = lt_acdoca-ls_racct.
  endat.
*-----------------------------
  t_rbukrs = lt_acdoca-ls_rbukrs.
  t_gjahr  = lt_acdoca-ls_gjahr.
  t_poper  = lt_acdoca-ls_poper.
  t_racct  = lt_acdoca-ls_racct.
endloop.

write: / t_rbukrs,
             t_gjahr,
             t_poper,
             t_racct,
             sum_hsl.


write: /'k'.
