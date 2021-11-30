--a
-- mostras las cuentas asociadas a una sucursal XXX ejm 201
CREATE PROCEDURE CUENTAS_ASOCIADAS(@COD_SUCURSAL char(3))
--DECLARE @COD_SUCURSAL char(3)
--SET @COD_SUCURSAL =201

AS

select *
from [dbo].[CUENTA] C inner join [dbo].[SUCURSAL] S
on C.COD_SUCURSAL=S.COD_SUCURSAL where C.COD_SUCURSAL=@COD_SUCURSAL
GO
--b
-- mostrar por operacion total de debitos y creditos usando funciones de agregado
SELECT SUM(A.DEBITOS) DEBITOS, SUM (A.CREDITOS) CREDITOS 
FROM(
	SELECT 
	CASE 
		 WHEN TIPO = 'D' THEN IMPORTE
		 ELSE 0 END AS DEBITOS,
	CASE 
		 WHEN TIPO = 'A' THEN IMPORTE
		 ELSE 0 END AS CREDITOS
	FROM MOVIMIENTO
)A
GO
--c
-- mostrar todas las transacciones realizadas en una fecha y sucursal proporcionada
CREATE PROCEDURE TRANSACCIONES_REALIZADAS(@COD_SUCURSAL char(3),@FECHA datetime)
--DECLARE @COD_SUCURSAL char(3)
--SET @COD_SUCURSAL =101
--DECLARE @FECHA datetime
--SET @FECHA ='2021-08-19'
AS

select M.FECHA,C.COD_SUCURSAL,C.NOMBRE,M.TIPO,M.IMPORTE
from [dbo].[MOVIMIENTO] M inner join [dbo].[CUENTA] C
on M.NRO_CUENTA=C.NRO_CUENTA where C.COD_SUCURSAL=@COD_SUCURSAL and CONVERT (date,M.FECHA)=@FECHA
GO
--d
-- mostrar todas las transacciones realizadas en una fecha y sucursal proporcionada adicionando la transaccion en moneda BOB y USD
CREATE PROCEDURE TRANSACCIONES_REALIZADAS_2(@COD_SUCURSAL char(3),@FECHA datetime)
--DECLARE @COD_SUCURSAL char(3)
--SET @COD_SUCURSAL =101
--DECLARE @FECHA datetime
--SET @FECHA ='2021-08-19'
AS

select M.FECHA,C.COD_SUCURSAL,C.NOMBRE,M.TIPO,M.IMPORTE,MO.MONEDA
from [dbo].[MOVIMIENTO] M inner join [dbo].[CUENTA] C
on M.NRO_CUENTA=C.NRO_CUENTA INNER JOIN MONEDA MO ON C.MONEDA=MO.MONEDA where C.COD_SUCURSAL=@COD_SUCURSAL and CONVERT (date,M.FECHA)=@FECHA
GO
--e
-- mostrar las cuentas que tuvieron mas de 2 transacciones (movimientos) en una fecha determinada
CREATE PROCEDURE CUENTAS_2MOVIMIENTOS(@FECHA datetime)
--DECLARE @FECHA datetime
--SET @FECHA ='2021-08-19'

AS

SELECT NRO_CUENTA FROM [dbo].[MOVIMIENTO] WHERE CONVERT(date,FECHA)= @FECHA 
GROUP BY NRO_CUENTA 
HAVING COUNT(NRO_CUENTA) > 2
GO
--F
-- mostrar la sucursal , monto transaccion , cantidad de transacciones que tuvieron el total de transacciones 
--una sumatoria mayor a mil dolares o su equivalente en bolivianos 
--CREATE PROCEDURE CUENTAS_2MOVIMIENTOS(@FECHA datetime)
--AS
SELECT COD_SUCURSAL, SUM(IMPORTE),MONEDA FROM(
SELECT COD_SUCURSAL,
CASE 
		 WHEN M.TIPO = 'A' THEN M.IMPORTE
		 ELSE M.IMPORTE*(-1) END AS IMPORTE ,
C.MONEDA
from MOVIMIENTO M INNER JOIN CUENTA C ON M.NRO_CUENTA= C.NRO_CUENTA)A
GROUP BY A.COD_SUCURSAL, A.MONEDA
HAVING (MONEDA='USD' AND SUM(A.IMPORTE)>1000) OR (MONEDA='BOL' AND SUM(A.IMPORTE)>7000)