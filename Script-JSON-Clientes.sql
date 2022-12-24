


DECLARE @json nvarchar(MAX)
SET @json = N'
			[{
				"orga_codigo": 1,
				"clie_numidentificacion": "0952738508",
				"clie_nombresCompletos": "ACOSTA OLIVEROS BRYAN ERNESTO",
				"IdUserBiometrico": "15873",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 56
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0920584794",
				"clie_nombresCompletos": "AGUIRRE CHALEN JULIO CESAR",
				"IdUserBiometrico": "16163",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 117
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0955269410",
				"clie_nombresCompletos": "ASPIAZU SOTO ERICK JOSUE",
				"IdUserBiometrico": "15484",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 56
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0951635390",
				"clie_nombresCompletos": "BORBOR PISCO DOUGLAS ERNESTO",
				"IdUserBiometrico": "16042",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 117
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0941261372",
				"clie_nombresCompletos": "CABANILLA VILLAMAR ERICK RAUL",
				"IdUserBiometrico": "16151",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 56
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0929847044",
				"clie_nombresCompletos": "ESTUPIÑAN MEJIA MARCELO ISRAEL",
				"IdUserBiometrico": "16152",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 117
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0924373616",
				"clie_nombresCompletos": "FLORES CEDEÑO DAVID ORLANDO",
				"IdUserBiometrico": "16007",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 56
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0804325850",
				"clie_nombresCompletos": "GARCIA GARCIA RICHARD ALEXANDER",
				"IdUserBiometrico": "14016",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 117
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0923302558",
				"clie_nombresCompletos": "MARCILLO GORDILLO ANTHONY JOEL",
				"IdUserBiometrico": "15823",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 56
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0951733286",
				"clie_nombresCompletos": "PINCAY CASTRO KLEBER GREGORIO",
				"IdUserBiometrico": "16056",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 117
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0951810993",
				"clie_nombresCompletos": "SALAS TORRES JORGE ANDRES",
				"IdUserBiometrico": "15848",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 56
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0951577774",
				"clie_nombresCompletos": "VALDIVIEZO VALDIVIEZO JUNIOR STALIN",
				"IdUserBiometrico": "16153",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 117
			}, {
				"orga_codigo": 1,
				"clie_numidentificacion": "0950947283",
				"clie_nombresCompletos": "YELA GARCIA RICARDO ALBERTO",
				"IdUserBiometrico": "15240",
				"orga_codigo_alimentacion": "9",
				"bode_codigo_alimentacion": 56
			}]
		'




DROP TABLE IF EXISTS #TbClientesJSON

SELECT TbJSON.* INTO #TbClientesJSON
FROM OPENJSON (@json, N'$')
  WITH (
    orga_codigo int  N'$.orga_codigo',
    clie_numidentificacion varchar(20) N'$.clie_numidentificacion',
	clie_nombresCompletos VARCHAR(200) N'$.clie_nombresCompletos',
    IdUserBiometrico int N'$.IdUserBiometrico',
    orga_codigo_alimentacion int  N'$.orga_codigo_alimentacion',
	bode_codigo_alimentacion int  N'$.bode_codigo_alimentacion'
  ) AS TbJSON



UPDATE Destino	
	SET Destino.IdUserBiometrico = Origen.IdUserBiometrico,
		Destino.clie_codigoEmpleado = Origen.IdUserBiometrico,
		Destino.orga_codigo_alimentacion = Origen.orga_codigo_alimentacion,
		Destino.bode_codigo_alimentacion = 73 --Origen.bode_codigo_alimentacion
FROM
	TbClientes AS Destino
		INNER JOIN #TbClientesJSON AS Origen
			ON Destino.orga_codigo = Origen.orga_codigo  
				AND Destino.clie_numidentificacion = Origen.clie_numidentificacion

		 

SELECT Destino.orga_codigo, Destino.clie_nombres, Destino.clie_apellidos, Origen.clie_nombrescompletos, Destino.clie_codigoEmpleado, Destino.IdUserBiometrico, Destino.orga_codigo_alimentacion, Destino.bode_codigo_alimentacion 
FROM TbClientes AS Destino
		INNER JOIN #TbClientesJSON AS Origen
			ON Destino.orga_codigo = Origen.orga_codigo  
				AND Destino.clie_numidentificacion = Origen.clie_numidentificacion


SELECT Destino.orga_codigo, Origen.clie_nombrescompletos, Destino.clie_nombres, Destino.clie_apellidos, Destino.clie_codigoEmpleado, Destino.IdUserBiometrico, Destino.orga_codigo_alimentacion, Destino.bode_codigo_alimentacion 
FROM TbClientes AS Destino
		INNER JOIN #TbClientesJSON AS Origen
			ON Destino.clie_numidentificacion = Origen.clie_numidentificacion

--select * from #TbClientesJSON
select clie_nombres, orga_codigo, clie_codigoEmpleado, IdUserBiometrico from TbClientes where clie_codigoEmpleado = IdUserBiometrico AND IdUserBiometrico != 0
select clie_nombres, orga_codigo, clie_codigoEmpleado, IdUserBiometrico from TbClientes where orga_codigo = 9



select * from TbClientes where clie_codigoEmpleado = 16152 -- clie_tipidentificacion = 'P'
SELECt distinct clie_tipidentificacion FROM TbClientes WHERE clie_numidentificacion = '0990032246001' --NESTLE

SELECT * FROM TbEstado

--SELECT orga_codigo,	clie_numidentificacion,	IdUserBiometrico, orga_codigo_alimentacion,	bode_codigo_alimentacion
-- FROM TbClientes
--FOR JSON AUTO
 
 SELECT * FROM TbOrganizaciones WHERE orga_codigo = 18 --Novacocina
 SELECT * FROM TbOrganizaciones WHERE orga_codigo = 9  --Laffa

 SELECT * FROM TbBodega WHERE orga_codigo = 9 AND bode_codigo = 73

 SELECT * FROM TbClientes WHERE clie_numidentificacion = '0990032246001' --NESTLE
 SELECT * FROM TbClientes WHERE clie_numidentificacion = '0992883677001' -- VUMILATINA --> Alianza (Zona) de Novacocina. Cliente Laffa
 
 SELECT * FROM TbAlianza WHERE alia_razonsocial LIKE '%NESTLE%'
 SELECT * FROM TbBodega WHERE bode_descripcion LIKE '%NESTLÉ%'

 SELECT * FROM TbZonasBodegas
 SELECT TORG.orga_nombre, TBOD.bode_descripcion, TZON.zona_nombre FROM TbZonasBodegas TZB
	INNER JOIN TbOrganizaciones TORG
		ON TORG.orga_codigo = TZB.orga_codigo
	INNER JOIN TbZonas TZON
		ON TZON.orga_codigo = TZB.orga_codigo
		AND TZON.zona_codigo = TZB.zona_codigo
	INNER JOIN TbBodega TBOD
		ON TBOD.orga_codigo = TZB.orga_codigo
		AND TBOD.bode_codigo = TZB.bode_codigo


-- Correcciones a la estructura de la tabla clientes
  --ALTER TABLE dbo.Tbclientes DROP COLUMN orga_codigo_alimentacion;
  --ALTER TABLE dbo.Tbclientes DROP COLUMN bode_codigo_alimentacion;
  --ALTER TABLE dbo.Tbclientes ADD orga_codigo_alimentacion INT
  --ALTER TABLE dbo.Tbclientes ADD bode_codigo_alimentacion INT

select * from tbclientes where  clie_numidentificacion = '0941261372'
