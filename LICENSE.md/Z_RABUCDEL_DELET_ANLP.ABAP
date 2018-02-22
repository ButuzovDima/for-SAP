*&---------------------------------------------------------------------*
*& Report Z_RABUCDEL_DELET_ANLP
*&---------------------------------------------------------------------*
*& Удаление из прозрачной таблицы записей, с помощью внутренней таблицы с ограниченным количеством строк
*& ZTESTFI1_KEY(MANDT ID ID2 ID3)
*&---------------------------------------------------------------------*
REPORT Z_RABUCDEL_DELET_ANLP.

TABLES: ZTESTFI1.

DATA i TYPE i.

DATA: BEGIN OF XZTEST OCCURS 0.
  INCLUDE STRUCTURE ZTESTFI1_KEY.
DATA: END OF XZTEST.

i = 0.
WHILE i = 0.
    i = 8.

    SELECT MANDT ID ID2 ID3
           FROM ZTESTFI1 INTO TABLE XZTEST PACKAGE SIZE 2
           WHERE ID3 = '1'.
      i = 0.
      EXIT.
    ENDSELECT.

    DELETE ZTESTFI1 FROM TABLE XZTEST.

    REFRESH XZTEST. CLEAR XZTEST.
    COMMIT WORK.

ENDWHILE.


WRITE: /'OK'.
