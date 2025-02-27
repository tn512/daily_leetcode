-- 2253. Dynamic Unpivoting of a Table

-- Main Solution
CREATE FUNCTION UnpivotProducts
RETURN SYS_REFCURSOR IS result SYS_REFCURSOR;
store_list VARCHAR2(4000);
dynamic_sql VARCHAR2(8000);
BEGIN
    /* Write your PL/SQL query statement below */
    SELECT LISTAGG(
        '"' || store || '"',
        ', '
    ) WITHIN GROUP (ORDER BY store)
    INTO store_list
    FROM (
        SELECT column_name AS store
        FROM user_tab_columns
        WHERE table_name = 'PRODUCTS'
        AND column_name <> 'product_id'
    );

    dynamic_sql := '
        SELECT * 
        FROM Products
        UNPIVOT(
            price
            FOR store --  unpivot_for_clause
            IN (
                ' || store_list || '
            ))';

    OPEN result FOR dynamic_sql;

    RETURN result;
END;

