import os
import pandas as pd
import json
from datetime import datetime, timedelta

class ClearData():
    def __init__(self):
        # Ruta del json
        self.json_path = r'visitas_mostrador.json'
        self.clean_registers = []
        self.load_json()
    
    def load_json(self):
        # Leer la información del json
        file = open(self.json_path,'rb')
        self.visits = json.load(file)
        file.close()
    
    def clear(self):
        self.pedidos=[]
        for id in clear_datos.visits:
            dato = clear_datos.visits[id]
            # dato['id'] = id
            keys = {k for k in dato}
            if 'pedido' in keys:
                product_name = list(set([name['producto'] for name in dato['pedido']]))
                for name in product_name:
                    products = [p for p in dato['pedido'] if p['producto'] == name]
                    products
                    new_product = {
                        'producto': name, 
                        'valor': 0, 
                        'fecha_despacho': products[0]['fecha_despacho']
                    }

                    for product in products:
                        if product['valor']:
                            new_product['valor'] += product['valor']
                            if datetime.strptime(product['fecha_despacho'], '%Y-%m-%d') < datetime.strptime(new_product['fecha_despacho'], '%Y-%m-%d'):
                                new_product['fecha_despacho'] = product['fecha_despacho']
                    
                    pp = {**dato,**new_product}
                    _=pp.pop('pedido')
                    self.pedidos.append(pp)
            else:
                self.pedidos.append(dato)


clear_datos = ClearData()
clear_datos.clear()
clear_datos.pedidos

df = pd.DataFrame(clear_datos.pedidos)
df.to_csv('visitas_aplanadas.csv',index=False)

# Valor total de los pedidos
valor_pedidos = df['valor'].sum()
# Valor promedio de los pedidos en el Huila
datos_huila = df[(df['departamento'] == 'Huila') & df['valor']]
prom = datos_huila['valor'].sum()/(datos_huila.shape[0])
# Producto más pedido en el Tolima
pedidos_tolima = df[(df['departamento'] == 'Tolima')]['producto'].value_counts()
print(f"Producto: {pedidos_tolima.head(1).index[0]} ----- Cantidad: {pedidos_tolima.head(1).values[0]}")
# Vendedor que ha hecho menos visitas en general (con y sin pedido)
visitas_x_vendedor = df['vendedor'].value_counts(ascending=True)
print(f"Vendedor con menos visitas {visitas_x_vendedor.head(1).index[0]} con {visitas_x_vendedor.head(1).values[0]} visitas")
# Tienda que tiene la mayor cantidad de pedidos
ventas_x_tienda = df['tienda'].value_counts()
print(f"La tienda {ventas_x_tienda.head(1).index[0]} tiene la mayor cantidad de pedidos {ventas_x_tienda.head(1).values[0]} ")

