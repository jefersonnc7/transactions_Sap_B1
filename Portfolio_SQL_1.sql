--As transactions abaixo, estão codificadas para uso em ambiente SQL.
--Coloquei a primeira (0990) com a conversão para o ambiente Hana, como exemplo ao final
--do código em SQL.

--Abaixo as diferenças entre o uso dos códigos SQL no ambiente Hana:

-- Usar "os dois pontos (:)" antes dos nomes das variáveis. 
-- Por exemplo: ":object_type, :transaction_type, e :list_of_cols_val_tab_del".

-- Encerrar com "ponto e vírgula (;)" após todas as instruções SQL, inclusive dentro daa condições "IF".

-- Uso das "Aspas (' ') e (" "): usar aspas simples ao redor de qualquer string no SAP HANA, por exemplo nas 
-- mensagens de erro: 'Não é permitido um valor igual ou ...'.

-- Nos nomes das colunas como: "Price" , "DocEntry" , etc. Devem estar entre "aspas duplas (" ")".


/*--------------------------------------------------------------------------------------------------------------*/
/*--------Não colocar a data de vencimento menor que a data do dia corrente, na NF de entrada-------------------*/
/*--------Desenvolvido por Jeferson Nonato de Carvalho----------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/

-- IF @object_type = '18' AND @transaction_type IN ('A')
-- BEGIN
    -- IF (
        -- SELECT COUNT(*)
        -- FROM OPCH
        -- WHERE DocDueDate < ADD_DAYS(CURRENT_DATE, -1)
              -- AND DocEntry = @list_of_cols_val_tab_del
    -- ) > 0
    -- BEGIN
	
--Trocar o "0990" pelo número desejado	
        -- SET @error = 0990
        -- SET @error_message = 'Não é permitido colocar a data de vencimento menor que a data do dia corrente'
    -- END
-- END

-- Abaixo está a mesma transaction para o ambiente Hana
-- IF (:object_type = 15) AND (:transaction_type IN ('A', 'U')) 
-- BEGIN

    -- IF (SELECT COUNT(*) 
        -- FROM DLN1 X 
        -- JOIN ODLN A ON A."DocEntry" = X."DocEntry"
        -- WHERE X."Price" <= 10 
        -- AND A."DocEntry" = :list_of_cols_val_tab_del) > 0 
    -- THEN
        -- SELECT :error = 990;
        -- SELECT :error_message = 'Não é permitido um valor igual ou menor que 10';
    -- END IF;

-- END;



/*--------------------------------------------------------------------------------------------------------------*/
/*-------------Fim da trava 0990--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/


/*--------------------------------------------------------------------------------------------------------------*/
/*-------------Parceiros de negócios que são obrigados a usar a opção "Gratuíto para o PN"----------------------*/
/*-------------Desenvolvido por Jeferson Nonato de Carvalho-----------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/

-- Selecionar a tabela que será usada no cabeçalho e nas linhas
-- IF('TRUE' = (Select Top 1 'TRUE' from OINV T0 inner join INV1 T1 on T0.Docentry = T1.Docentry
-- Where 

--Entre os parênteses colocar os códigos dos PNs
	-- T0.Cardcode in ('C15084', 'C0040001', 'F175248', 'F86820')
	-- and T1.FreeChrgBP <> 'Y'
	-- and T0.DocEntry = @list_of_cols_val_tab_del))
-- Begin
--Trocar o "0990" pelo número desejado
	-- SELECT @error = 0991
	-- SELECT @error_message = 'Esse PN não pode ser inserido sem o Flag GRATUITO!'
-- End
/*--------------------------------------------------------------------------------------------------------------*/
/*-------------Fim da trava 0991--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/

	
/*--------------------------------------------------------------------------------------------------------------*/
/*-------------Item inválido para o modelo de nota fiscal-------------------------------------------------------*/
/*-------------Desenvolvido por Jeferson Nonato de Carvalho-----------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/
	
	-- if (@transaction_type in ('A')  and 'TRUE' =	(
					-- Select top 1 
						-- 'TRUE'
					-- from 
						-- OINV a inner join 
						-- ONFM b on a.Model = b.AbsEntry

					-- where 
					--Trocar o "XX" pelo modelo que desejar
						-- b.NfmName like '%XX%' and
						-- a.DocEntry = @list_of_cols_val_tab_del
				-- ))
-- Begin
	-- if ('TRUE' = (Select top 1 
						-- 'TRUE'
					-- from 
						-- INV1
					-- where
						-- docentry = @list_of_cols_val_tab_del and
						-- itemcode not in	(	
											-- 'PROD00101',
											-- 'SERV00102',
											-- 'IMP000105',
											
										-- )))
	-- Begin
	--Trocar o "0992" pelo número desejado
		-- SELECT @error = 0992
		-- SELECT @error_message = 'Nota com Item invalido para NF MODELO XX!'
	-- End
/*--------------------------------------------------------------------------------------------------------------*/
/*-------------Fim da trava 0992--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------------------------------------------*/
/*-------------Bloquear notas de entradas com o vencimento no mesmo dia da emissão, após às XX:XX a.m ----------*/
/*-------------Desenvolvido por Jeferson Nonato de Carvalho-----------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/

-- IF @object_type = '18' and @transaction_type in ('A','U')

-- BEGIN
 
   -- IF(

                 -- (

                     -- SELECT COUNT(*)

                     -- FROM OPCH 

                     -- WHERE DATEADD (HOUR, + 10, DocDueDate) < GETDATE()
-- AND DocEntry = @list_of_cols_val_tab_del)

                 

                 -- ) > 0

                     -- BEGIN
--Trocar o "0992" pelo número desejado
                         -- SELECT @error = 0993

                         -- SELECT @error_message = 'Não é permitido a inserção c/ a data de vencto. Menor que a data do dia corrente, e nem após as XX:XX hrs. a.m'

                     -- END;

-- END;

/*--------------------------------------------------------------------------------------------------------------*/
/*-------------Fim da trava 0993--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------------------------------------*/
/*--------Valor mínimo para emissão-------------------------------------------------------------------------------*/
/*--------Desenvolvido por Jeferson Nonato de Carvalho------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------*/


-- Colocar o código do "object_type" da tabela do documento de marketing desejado no lugar do "15"
-- IF (@object_type) = 15 and (@transaction_type in ('A','U'))
	-- BEGIN

-- Colocar as tabelas do documento de marketing desejado 
		-- IF (SELECT COUNT(*) FROM DLN1 X JOIN ODLN A ON A."DocEntry" = X."DocEntry"
		
--Colocar o valor desejado no lugar do "XX"		
			-- WHERE X.Price <= 'XX' and A.DocEntry = @list_of_cols_val_tab_del) > 0
 
-- BEGIN

--Trocar o "0993" pelo número desejado
		-- SELECT @error = 0994
		-- SELECT @error_message = 'Não é permitido um valor igual ou menor que "XX"'
-- END
-- END

/*--------------------------------------------------------------------------------------------------------------*/
/*-------------Fim da trava 099--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------*/

