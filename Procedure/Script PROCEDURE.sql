CREATE OR REPLACE PROCEDURE realizar_venda(p_produto_id INT, p_quantidade INT)

LANGUAGE plpgsql
AS $$
DECLARE
    v_preco NUMERIC(10, 2);
    v_estoque_atual INT;
    v_valor_total NUMERIC(10, 2);
BEGIN
    
    SELECT preco, estoque INTO v_preco, v_estoque_atual 
    FROM produtos 
    WHERE id = p_produto_id;

    
    IF NOT FOUND THEN
        RAISE NOTICE 'Erro: Esse produto (ID %) não existe no sistema.', p_produto_id;
        RETURN;
    END IF;

    
    IF v_estoque_atual < p_quantidade THEN
        RAISE NOTICE 'Erro: Estoque insuficiente. Só temos % unidades em estoque.', v_estoque_atual;
        RETURN;
    END IF;

    
    v_valor_total := v_preco * p_quantidade;

    
    INSERT INTO vendas (produto_id, quantidade, valor_total)
    VALUES (p_produto_id, p_quantidade, v_valor_total);

    
    UPDATE produtos 
    SET estoque = estoque - p_quantidade 
    WHERE id = p_produto_id;

    
    RAISE NOTICE 'Venda realizada! Total: R$ %', v_valor_total;
END;
$$

CALL realizar_venda(1, 2)

CALL realizar_venda(2, 60)