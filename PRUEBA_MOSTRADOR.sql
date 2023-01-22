DROP TABLE IF EXISTS `PRUEBA_MOSTRADOR`;

CREATE TABLE `PRUEBA_MOSTRADOR` (
  `nombre` varchar(100) DEFAULT '',
  `tipo` varchar(100) DEFAULT '',
  `municipio` varchar(100) DEFAULT '',
  `municipio_id` varchar(100) DEFAULT '',
  `direccion` varchar(100) DEFAULT '',
  `nit` varchar(100) DEFAULT '',
  `categoria` varchar(100) DEFAULT '',
  `categoria_id` varchar(100) DEFAULT '',
  `numero_empleados` bigint(20) DEFAULT 0,
  `fechaCreacionprt` datetime DEFAULT NULL,
  `fechaModificacionprt` datetime DEFAULT NULL,
  `cuentaAsociadaprt` varchar(100) DEFAULT '',
  `fb_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `fecha` date DEFAULT NULL,
  `tienda` varchar(100) DEFAULT '',
  `tienda_id` varchar(100) DEFAULT '',
  `objetivo` varchar(100) DEFAULT '',
  `objetivo_id` varchar(100) DEFAULT '',
  `duracion` decimal(20,3) DEFAULT 0.000,
  `modalidad` varchar(100) DEFAULT '',
  `observacion` text DEFAULT NULL,
  `venta_teorica_valor_total` varchar(100) DEFAULT '',
  `venta_teorica_unidad` varchar(100) DEFAULT '',
  `venta_teorica_unidad_id` varchar(100) DEFAULT '',
  `venta_teorica_precio_unitario` bigint(20) DEFAULT 0,
  `venta_teorica_producto` varchar(100) DEFAULT '',
  `venta_teorica_producto_id` varchar(100) DEFAULT '',
  `venta_teorica_cantidad` decimal(20,3) DEFAULT 0.000,
  `fechaCreacion` datetime DEFAULT NULL,
  `fechaModificacion` datetime DEFAULT NULL,
  `cuentaAsociada` varchar(100) DEFAULT '',
  `fb_idprme` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  KEY `fb_id_idx` (`fb_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO test.prueba_mostrador (nombre,tipo, municipio,municipio_id,direccion,nit,categoria,categoria_id,numero_empleados,fechaCreacionprt,fechaModificacionprt,cuentaAsociadaprt,fb_id ,  fecha ,  tienda ,  tienda_id ,  objetivo ,  objetivo_id ,  duracion ,  modalidad ,  observacion ,  venta_teorica_valor_total,  venta_teorica_unidad,  venta_teorica_unidad_id,  venta_teorica_precio_unitario,  venta_teorica_producto,  venta_teorica_producto_id,  venta_teorica_cantidad,  fechaCreacion,  fechaModificacion,  cuentaAsociada,fb_idprme) 
SELECT * FROM test.prueba_raw_tiendasclientes as prt
inner join test.prueba_raw_mostrador_ex as prme
ON prt.fb_id = prme.tienda_id;
# Numero de registros
SELECT count(venta_teorica_producto) From test.prueba_mostrador;
# registros desde la fecha '2022-01-01'
SELECT * FROM test.prueba_mostrador
where fechaCreacion > '2022-01-01';
#producto más vendido
SELECT venta_teorica_producto, count(venta_teorica_producto) From test.prueba_mostrador
group by venta_teorica_producto order by count(venta_teorica_producto) desc;
# promedio de ventas (Valor total)
SELECT AVG(ALL venta_teorica_valor_total) FROM test.prueba_mostrador;
#Ranking de las 3 tiendas con más ventas (Valor total)
SELECT  tienda, SUM(venta_teorica_valor_total) venta_teorica_valor_total From test.prueba_mostrador
group by tienda order by SUM(venta_teorica_valor_total) desc;

