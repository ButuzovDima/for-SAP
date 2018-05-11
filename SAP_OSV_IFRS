METHOD zif_ms_d0019_dataset~get_data.
    FIELD-SYMBOLS:
      <fs_data>   TYPE ts_intdata,
*------------------Butuzov 28.04.2018----------------------------------------
*      <fs_totals> TYPE faglflext,
*      <fs_value>  TYPE faglflext-hsl01.

      <fs_totals> TYPE acdoca,
      <fs_value>  TYPE acdoca-hsl.
*------------------Butuzov 28.04.2018 end------------------------------------

    DATA:
      l_ld_ml   TYPE fagl_rldnr,
      ls_tn_ac  TYPE fagl_tabnames,
      ls_tn_ml  TYPE fagl_tabnames,
      lt_aw_ml  TYPE tax_awtyp_sel_tab,
      lt_aw_ac  TYPE tax_awtyp_sel_tab,

      l_period  TYPE poper,
      lt_poper  TYPE fagl_range_t_poper,

      l_periods TYPE sy-index,
      l_index   TYPE sy-index,
      ls_data   TYPE ts_intdata,
*-----------------Butuzov 03.05.2018------------------------------------------
*     lt_totals TYPE fagl_t_glflext.
      lt_totals TYPE finst_acdoca.
*-----------------Butuzov 03.05.2018 end--------------------------------------

*-----------------Butuzov 03.05.2018------------------------------------------
    DATA:
      lt_balanc TYPE TABLE OF acdoca WITH KEY rbukrs racct racct_ias raudit drcrk.
    DATA:
      ls_balanc TYPE acdoca.
*-----------------Butuzov 03.05.2018 end--------------------------------------

    REFRESH et_messages[].
    GET REFERENCE OF mt_data[] INTO e_data.
    CHECK mt_data[] IS INITIAL.
    CHECK mt_bukrs[] IS NOT INITIAL.

    ls_data-ryear = m_gjahr.
    ls_data-poper = m_poper.

    get_poper_range( IMPORTING et_poper = lt_poper ).
    get_dbsel(
      IMPORTING
        e_ld_ml = l_ld_ml
        et_aw_ml = lt_aw_ml et_aw_ac = lt_aw_ac
        es_tn_ml = ls_tn_ml es_tn_ac = ls_tn_ac
      EXCEPTIONS
        OTHERS = 1 ).
    IF sy-subrc IS NOT INITIAL.
      RAISE e_data_error.
    ENDIF.


*------------------Butuzov 28.04.2018----------------------------------------

    SELECT rbukrs racct racct_ias raudit drcrk
      SUM( hsl ) AS hsl
      INTO CORRESPONDING FIELDS OF TABLE lt_balanc
      FROM acdoca
      WHERE rldnr = m_rldnr
        AND rbukrs IN mt_bukrs
        AND ryear = m_gjahr
        AND awtyp IN lt_aw_ac
        AND racct IN mt_real_acct
        AND racct_ias IN MT_REAL_ACCT_IAS
        AND poper < m_poper
      GROUP BY rbukrs racct racct_ias raudit drcrk.

    SELECT rbukrs racct racct_ias raudit drcrk
      SUM( hsl ) AS hsl
      APPENDING CORRESPONDING FIELDS OF TABLE lt_balanc
      FROM acdoca
      WHERE rldnr = l_ld_ml
        AND rbukrs IN mt_bukrs
        AND ryear = m_gjahr
        AND awtyp IN lt_aw_ml
        AND racct IN mt_real_acct
        AND racct_ias IN MT_REAL_ACCT_IAS
        AND poper < m_poper
      GROUP BY rbukrs racct racct_ias raudit drcrk.

    SORT lt_balanc BY rbukrs racct racct_ias raudit drcrk.
*------------------Butuzov 28.04.2018 end----------------------------------------

*------------------Butuzov 28.04.2018----------------------------------------
*    SELECT rbukrs racct racct_ias raudit drcrk
*      SUM( kslvt ) AS hslvt
*      SUM( ksl01 ) AS hsl01 SUM( ksl02 ) AS hsl02 SUM( ksl03 ) AS hsl03 SUM( ksl04 ) AS hsl04
*      SUM( ksl05 ) AS hsl05 SUM( ksl06 ) AS hsl06 SUM( ksl07 ) AS hsl07 SUM( ksl08 ) AS hsl08
*      SUM( ksl09 ) AS hsl09 SUM( ksl10 ) AS hsl10 SUM( ksl11 ) AS hsl11 SUM( ksl12 ) AS hsl12
*      SUM( ksl13 ) AS hsl13 SUM( ksl14 ) AS hsl14 SUM( ksl15 ) AS hsl15 SUM( ksl16 ) AS hsl16
*      INTO CORRESPONDING FIELDS OF TABLE lt_totals
*      FROM (ls_tn_ac-tot_table)
*      WHERE rldnr = m_rldnr AND rbukrs IN mt_bukrs AND ryear = m_gjahr
*        AND awtyp IN lt_aw_ac AND racct IN mt_real_acct and racct_ias in MT_REAL_ACCT_IAS
*      GROUP BY rbukrs racct racct_ias raudit drcrk.

    SELECT rbukrs racct racct_ias raudit drcrk
      SUM( hsl ) AS hsl
      INTO CORRESPONDING FIELDS OF TABLE lt_totals
      FROM acdoca
      WHERE rldnr = m_rldnr
        AND rbukrs IN mt_bukrs
        AND ryear = m_gjahr
        AND awtyp IN lt_aw_ac
        AND racct IN mt_real_acct
        AND racct_ias IN MT_REAL_ACCT_IAS
        AND poper EQ m_poper
      GROUP BY rbukrs racct racct_ias raudit drcrk.

*------------------Butuzov 28.04.2018 end----------------------------------------

*------------------Butuzov 28.04.2018----------------------------------------
*    SELECT rbukrs racct racct_ias raudit drcrk
*      SUM( kslvt ) AS hslvt
*      SUM( ksl01 ) AS hsl01 SUM( ksl02 ) AS hsl02 SUM( ksl03 ) AS hsl03 SUM( ksl04 ) AS hsl04
*      SUM( ksl05 ) AS hsl05 SUM( ksl06 ) AS hsl06 SUM( ksl07 ) AS hsl07 SUM( ksl08 ) AS hsl08
*      SUM( ksl09 ) AS hsl09 SUM( ksl10 ) AS hsl10 SUM( ksl11 ) AS hsl11 SUM( ksl12 ) AS hsl12
*      SUM( ksl13 ) AS hsl13 SUM( ksl14 ) AS hsl14 SUM( ksl15 ) AS hsl15 SUM( ksl16 ) AS hsl16
*      APPENDING CORRESPONDING FIELDS OF TABLE lt_totals
*      FROM (ls_tn_ml-tot_table)
*      WHERE rldnr = l_ld_ml AND rbukrs IN mt_bukrs AND ryear = m_gjahr
*        AND awtyp IN lt_aw_ml AND racct IN mt_real_acct and racct_ias in MT_REAL_ACCT_IAS
*      GROUP BY rbukrs racct racct_ias raudit drcrk.

    SELECT rbukrs racct racct_ias raudit drcrk
      SUM( hsl ) AS hsl
      APPENDING CORRESPONDING FIELDS OF TABLE lt_totals
      FROM acdoca
      WHERE rldnr = l_ld_ml
        AND rbukrs IN mt_bukrs
        AND ryear = m_gjahr
        AND awtyp IN lt_aw_ml
        AND racct IN mt_real_acct
        AND racct_ias IN MT_REAL_ACCT_IAS
        AND poper EQ m_poper
      GROUP BY rbukrs racct racct_ias raudit drcrk.


*------------------Butuzov 28.04.2018 end----------------------------------------

    LOOP AT lt_totals ASSIGNING <fs_totals>.
      CLEAR ls_data.
      MOVE-CORRESPONDING <fs_totals> TO ls_data.

*----------------------------------Butuzov 03.05.2018--------------------------
      CLEAR: ls_balanc.
      READ TABLE lt_balanc  WITH KEY rbukrs    = ls_data-rbukrs
                                     racct     = ls_data-racct
                                     racct_ias = ls_data-racct_ias
                                     raudit    = ls_data-raudit
                                     drcrk     = ls_data-drcrk
                                     INTO ls_balanc
                                     BINARY SEARCH.

*----------------------------------Butuzov 03.05.2018 end----------------------

      ls_data-amount = <fs_totals>-hsl.
      ls_data-balnc_in = ls_balanc-hsl.

      IF ls_data-racct_ias IS INITIAL.
        ls_data-racct_ias = 'UNCLASS'.
      ENDIF.
      IF m_fake_unclass = abap_on AND ls_data-racct_ias = 'UNCLASS'.
        ls_data-racct_ias = get_fake_racct_ias( <fs_totals>-racct ).
      ENDIF.

      ls_data-ryear = m_gjahr.
      ls_data-poper = m_poper.

*----------------------------------Butuzov 03.05.2018--------------------------
*      ls_data-balnc_in = <fs_totals>-hslvt.
*      DO m_poper TIMES.
*        l_period = sy-index.
*        ASSIGN <fs_totals>-hslvt INCREMENT sy-index TO <fs_value> RANGE <fs_totals>.
*        IF l_period IN lt_poper.
*          ADD <fs_value> TO ls_data-amount.
*        ELSE.
*          ADD <fs_value> TO ls_data-balnc_in.
*        ENDIF.
*      ENDDO.


*----------------------------------Butuzov 03.05.2018 end------------------------

      IF ls_data-amount IS NOT INITIAL.
        COLLECT ls_data INTO mt_data ASSIGNING <fs_data>.
        SUBTRACT ls_data-balnc_in FROM <fs_data>-balnc_in.
      ENDIF.
      IF ls_data-balnc_in IS NOT INITIAL.
        CLEAR: ls_data-amount, ls_data-drcrk.
        COLLECT ls_data INTO mt_data.
      ENDIF.
    ENDLOOP.

    LOOP AT mt_data INTO ls_data WHERE drcrk IS INITIAL.
      DELETE mt_data INDEX sy-tabix.
      CHECK ls_data-balnc_in IS NOT INITIAL.
      IF ls_data-balnc_in < 0.
        ls_data-drcrk = 'H'.
      ELSE.
        ls_data-drcrk = 'S'.
      ENDIF.
      READ TABLE mt_data ASSIGNING <fs_data> FROM ls_data.
      IF sy-subrc IS NOT INITIAL.
        APPEND ls_data TO mt_data ASSIGNING <fs_data>.
      ENDIF.
      <fs_data>-balnc_in = ls_data-balnc_in.
    ENDLOOP.

  ENDMETHOD.
