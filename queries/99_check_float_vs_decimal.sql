-- 99_check_float_vs_decimal.sql — comprobacion del mecanismo de schema-eco-01 (DECIMAL vs FLOAT)
-- Fuera de la secuencia del proyecto a proposito: no construye la economia, comprueba un porque.
-- Autoria: SQL escrito por el tutor como worked example. La PREDICCION (abajo) es del alumno,
-- escrita el 2026-08-13 ANTES de ejecutar.
--
-- Criterio producido por el alumno en la sesion:
--   un valor cabe exacto en base 2 solo si su fraccion SIMPLIFICADA tiene denominador potencia de 2.
--   0.5 = 1/2 si · 0.75 = 3/4 si · 0.1 = 1/10 no (le sobra el 5) · 0.3 = 3/10 no
--
-- PREDICCION del alumno: lo_dice_el_float = 0, lo_dice_el_decimal = 1.
--   Causa predicha: en binario 0.1 + 0.2 no da 0.3 clavado, sino algo como 0.30000000000000004,
--   asi que la comparacion falla. En DECIMAL la suma es exacta y da verdadero.

-- 1) El mismo calculo, dos tipos. Un literal como 0.1 en MariaDB ya es DECIMAL;
--    el CAST es lo que lo mete en binario (coma flotante).
SELECT
  CAST(0.1 AS DOUBLE) + CAST(0.2 AS DOUBLE) = CAST(0.3 AS DOUBLE) AS lo_dice_el_float,
  0.1 + 0.2 = 0.3                                                 AS lo_dice_el_decimal;

-- 2) El residuo que causa el desacuerdo, sacado a la luz.
--    FORMAT con 20 decimales para que no lo esconda el redondeo de pantalla.
SELECT FORMAT(CAST(0.1 AS DOUBLE) + CAST(0.2 AS DOUBLE) - CAST(0.3 AS DOUBLE), 20) AS sobra_esto;

-- 3) Por que le importa a un ledger: el residuo no se queda quieto, se acumula al sumar movimientos.
--    Diez movimientos de 0.10 deberian dar 1.00 exacto en las dos columnas.
SELECT
  SUM(CAST(0.1 AS DOUBLE))  AS suma_float,
  SUM(CAST(0.1 AS DECIMAL(10,2))) AS suma_decimal,
  SUM(CAST(0.1 AS DOUBLE)) = 1.0  AS el_float_cuadra
FROM (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
      UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
      UNION ALL SELECT 10) AS diez_movimientos;
