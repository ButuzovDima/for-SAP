REPORT Z_TETST2_SELECT_SCREEN.

DATA: t_rbukrs type acdoca-rbukrs.
DATA: t_gjahr  type acdoca-gjahr.
*DATA: t_poper  type acdoca-poper.

DATA: begin of ls_acdoca,
      ls_rbukrs type acdoca-rbukrs,
      ls_gjahr  type acdoca-gjahr,
*      ls_poper  type acdoca-poper,
      ls_belnr  type acdoca-belnr,
  end of ls_acdoca.

DATA: lt_acdoca like table of ls_acdoca WITH HEADER LINE.

SELECT-OPTIONS: s_rbukrs FOR t_rbukrs,
                s_gjahr  FOR t_gjahr.
*                s_poper  FOR t_poper.

*INITIALIZATION.

t_rbukrs = s_rbukrs-low.
t_gjahr  = s_gjahr-low.
*t_poper  = s_poper-low.

END-OF-SELECTION.

select rbukrs gjahr
*  poper
  belnr from acdoca
  into table lt_acdoca
  where rbukrs eq t_rbukrs and
        gjahr  eq t_gjahr.
*        poper  eq t_poper.

  IF sy-subrc eq 0.
    LOOP AT lt_acdoca.
      WRITE:/ lt_acdoca-ls_rbukrs,
              lt_acdoca-ls_gjahr,
              lt_acdoca-ls_belnr.
    ENDLOOP.
  ENDIF.
