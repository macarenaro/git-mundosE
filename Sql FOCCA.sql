#BASE FOCCA POR CUIL
SELECT 
    RAPERIODO AS PERIODO, 
    RACUIT AS CUIT, 
    JAREPDESCR AS REPARTICION, 
    RADCUIL AS CUIL, 
    RADAPEYNOM AS APELLIDO_Y_NOMBRE, 
    RADACTIVID AS ACTIV, 
      SUM(Total_RADRENUM1) AS Total_SUJ, 
    SUM(
        CASE 
            WHEN Total_RADRENUM1 <= 755000 THEN ROUND(Total_RADRENUM1 * 0.02, 2)
            WHEN Total_RADRENUM1 <= 1000000 THEN ROUND(Total_RADRENUM1 * 0.03, 2)
            ELSE ROUND(Total_RADRENUM1 * 0.04, 2)
        END
    ) AS APORTE_ADIC,
    CASE 
        WHEN Total_RADRENUM1 <= 755000 THEN '2%'
        WHEN Total_RADRENUM1 <= 1000000 THEN '3%'
        ELSE '4%'
    END AS ALICUOTA
FROM (
    SELECT 
        RAPERIODO, 
        RACUIT, 
        JAREPDESCR, 
        RADCUIL, 
        RADAPEYNOM, 
        RADACTIVID, 
     
        SUM(RADRENUM1) AS Total_RADRENUM1
    FROM 
        CAJAJUBITESTUSU.RADETALL
    INNER JOIN 
        cajajubitestusu.jarepart ON JAREPCUIT = RACUIT
    WHERE 
        RAPERIODO > = 202405 
--cambiar periodo cuando cambia el mes (mes anterior al vigente)
    GROUP BY 
        RAPERIODO, RACUIT, JAREPDESCR, RADCUIL, RADAPEYNOM, RADACTIVID
) Subconsulta
GROUP BY 
    RAPERIODO, RACUIT, JAREPDESCR, RADCUIL, RADAPEYNOM, RADACTIVID, Total_RADRENUM1;