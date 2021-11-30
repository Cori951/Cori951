USE [ECC0]
go
INSERT INTO [dbo].[MONEDA](MONEDA,DESCRIPCION)VALUES('USD','DOLARES');
GO
INSERT INTO [dbo].[MONEDA](MONEDA,DESCRIPCION)VALUES('BOL','BOLIVIANOS');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('101','Sucre');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('201','La Paz');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('301','Cochabamba');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('401','Oruro');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('501','Potosi');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('601','Tarija');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('701','Santa Cruz');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('801','Beni');
GO
INSERT INTO [dbo].[SUCURSAL](COD_SUCURSAL,NOMBRE_SUCURSAL)VALUES('901','Pando');
GO
CREATE PROCEDURE [dbo].[ACTUALIZADO_SALDOCUENTA](@NUMERO_CUENTA nvarchar(14))
AS
update [dbo].[CUENTA] set SALDO=(select sum(A.importe) from(
select NRO_CUENTA,
CASE
                WHEN 
				TIPO='A'
                    THEN IMPORTE
                ELSE IMPORTE*(-1)
            END AS importe
from [dbo].[MOVIMIENTO] where NRO_CUENTA=@NUMERO_CUENTA
)A
GROUP BY NRO_CUENTA)
where NRO_CUENTA=@NUMERO_CUENTA
GO
INSERT [dbo].[CUENTA] ([NRO_CUENTA], [COD_SUCURSAL], [TIPO], [MONEDA], [NOMBRE], [SALDO]) VALUES (N'20210819131530', N'101', N'AHO', N'USD', N'benito guzman', CAST(9799.78 AS Decimal(12, 2)))
INSERT [dbo].[CUENTA] ([NRO_CUENTA], [COD_SUCURSAL], [TIPO], [MONEDA], [NOMBRE], [SALDO]) VALUES (N'20210819132553', N'201', N'AHO', N'USD', N'aparicia', CAST(50.00 AS Decimal(12, 2)))
INSERT [dbo].[CUENTA] ([NRO_CUENTA], [COD_SUCURSAL], [TIPO], [MONEDA], [NOMBRE], [SALDO]) VALUES (N'20210819133145', N'301', N'AHO', N'USD', N'tefi', CAST(1000.42 AS Decimal(12, 2)))
GO
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819131530', CAST(N'2021-08-19T13:16:00.000' AS DateTime), N'D', CAST(0.00 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819131530', CAST(N'2021-08-19T13:16:47.000' AS DateTime), N'A', CAST(10012.00 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819131530', CAST(N'2021-08-19T13:18:25.000' AS DateTime), N'A', CAST(50.12 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819131530', CAST(N'2021-08-19T13:18:45.000' AS DateTime), N'D', CAST(12.12 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819131530', CAST(N'2021-08-19T13:21:44.000' AS DateTime), N'D', CAST(150.22 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819132553', CAST(N'2021-08-19T13:26:07.000' AS DateTime), N'D', CAST(0.00 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819131530', CAST(N'2021-08-19T13:26:35.790' AS DateTime), N'D', CAST(50.00 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819132553', CAST(N'2021-08-19T13:26:35.797' AS DateTime), N'A', CAST(50.00 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819133145', CAST(N'2021-08-19T13:31:59.000' AS DateTime), N'D', CAST(0.00 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819133145', CAST(N'2021-08-19T13:32:18.000' AS DateTime), N'A', CAST(1000.54 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819133145', CAST(N'2021-08-19T13:32:28.000' AS DateTime), N'D', CAST(50.12 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819131530', CAST(N'2021-08-19T13:32:49.480' AS DateTime), N'D', CAST(50.00 AS Decimal(12, 2)))
INSERT [dbo].[MOVIMIENTO] ([NRO_CUENTA], [FECHA], [TIPO], [IMPORTE]) VALUES (N'20210819133145', CAST(N'2021-08-19T13:32:49.510' AS DateTime), N'A', CAST(50.00 AS Decimal(12, 2)))
GO
