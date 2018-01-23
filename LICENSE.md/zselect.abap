
REPORT Z_TEST1.

data: begin of ls_acdoca,
         bukrs type acdoca-rbukrs,
         gjahr type acdoca-gjahr,
         belnr type acdoca-belnr,
      end of ls_acdoca.
data: lt_acdoca like table of ls_acdoca.


" выбираем данные из таблицы acdoca и помещаем их во внутреннюю таблицу lt_acdoca

select
  rbukrs gjahr belnr
from
  acdoca
into table
  lt_acdoca
where
  rbukrs eq 3013.
  
  
*******************************************************
REPORT Z_TEST2.

TABLES: bkpf.
DATA: t_bkpf like bkpf occurs 100 with header line.

select
  *
from
  bkpf
into table
  t_bkpf
where
  bukrs eq 3013.

loop at t_bkpf.
  write:/ t_bkpf-belnr.
endloop.
