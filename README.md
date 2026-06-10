# Economy Core

Esta base de datos guarda datos de los jugadores como la transacciones, los items de los jugadores y sus cuentas, para simular la economía de un mundo virtual.

## Cómo levantarlo 
Con `docker compose up -d` se arranca en base a la imagen, luego hay que ejecutar schema.sql primero (crea las tablas) y seed.sql después (inserta los datos), desde tu cliente SQL.

## Decisiones de diseño
## **¿Por qué accounts separada de players?**
Accounts esta separada de players para evitar que cada vez se cree multiples registro con datos repetidos y redundante, de esta forma es mas organizado usando relaciones lo mismo para player_items.

## **¿Por qué transactions guarda from_account_id y to_account_id?**
De esta forma evitamos crea un campo donde se guarde el amount total de usuario teniendo que actualizar a cada rato ademas nos sirve como auditoria exacta saber a quien se le envia y recibe el dinero, gracias a ellos resolvemos 2 problemas en uno, calculamos el amount total de cada usuario y evitamos dinero falso o fantasma por medio de hackeos.

## **¿Por qué DECIMAL(15,2) para amount y no FLOAT?**
Por que asi evitamos que el valor se guarde en binario y sea una valor puro y exacto, con FLOAT los céntimos se pierden por redondeo

## Queries

01_saldo_por_cuenta: Como lo dice su nombre me calcula el saldo por cada jugador, sumando la transacciones que vas a su cuenta y restando la que van a otras cuentas.
02_transacciones_recientes: Me trae la 5 transacciones mas recientes ordenadas por fecha descendente
03_inventario_de_un_player: Muestra los item del jugador especificado por id