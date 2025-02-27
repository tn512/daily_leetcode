-- 2252. Dynamic Pivoting of a Table

-- Main Solution
CREATE FUNCTION PivotProducts
RETURN SYS_REFCURSOR IS result SYS_REFCURSOR;
store_list VARCHAR2(4000);
dynamic_sql VARCHAR2(4000);
BEGIN
    /* Write your PL/SQL query statement below */
    SELECT LISTAGG(
        'MAX(CASE WHEN store = ''' || store || ''' THEN price END) AS "' || store || '"',
        ', '
    ) WITHIN GROUP (ORDER BY store)
    INTO store_list
    FROM (
        SELECT DISTINCT store 
        FROM Products
    );

    dynamic_sql := 'SELECT product_id, ' || store_list || '
                   FROM Products
                   GROUP BY product_id';

    OPEN result FOR dynamic_sql;

    RETURN result;
END;

