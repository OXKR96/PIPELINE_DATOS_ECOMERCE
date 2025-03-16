def query_orders_per_day_and_holidays_2017(database: Engine) -> QueryResult:
    """Get the query for orders per day and holidays in 2017."""
    query_name = QueryEnum.ORDERS_PER_DAY_AND_HOLIDAYS_2017.value

    # Leer días festivos y pedidos
    with database.connect() as connection:
        holidays = pd.read_sql("SELECT * FROM public_holidays", connection)
        orders = pd.read_sql("SELECT * FROM olist_orders", connection)

    # Convertir timestamp de pedidos a datetime
    orders["order_purchase_timestamp"] = pd.to_datetime(orders["order_purchase_timestamp"])

    # Filtrar pedidos de 2017
    filtered_dates = orders[orders["order_purchase_timestamp"].dt.year == 2017]

    # Contar pedidos por día
    order_purchase_amount_per_date = filtered_dates.groupby(
        filtered_dates["order_purchase_timestamp"].dt.date
    ).size().reset_index(name='order_count')

    # Crear DataFrame final
    result_df = order_purchase_amount_per_date.copy()
    result_df.rename(columns={'order_purchase_timestamp': 'date'}, inplace=True)
    result_df['date'] = pd.to_datetime(result_df['date'])
    result_df['holiday'] = result_df['date'].isin(pd.to_datetime(holidays['date']))
    
    # Convertir a timestamp en milisegundos (usando int64 en lugar de int)
    result_df['date'] = result_df['date'].astype('int64') // 10**6
    
    # Seleccionar solo las columnas necesarias en el orden correcto
    result_df = result_df[['order_count', 'date', 'holiday']]

    return QueryResult(query=query_name, result=result_df)