# cards
Essa consulta SQL está fazendo uma contagem agregada do status dos agendamentos com base em diferentes critérios. Vamos analisar a estrutura da consulta:

1. **Alias para a Coluna Status:**
   ```sql
   'Total' AS Status,
   ```
   - Cria uma coluna chamada `Status` com o valor 'Total'.

2. **Contagem Total:**
   ```sql
   COUNT(*) AS Total,
   ```
   - Conta o número total de registros na tabela `AGENDAMENTO_STATUS` e atribui à coluna `Total`.

3. **Contagens Condicionais para Cada Status:**
   ```sql
   SUM(CASE WHEN C.STATUS = 1 THEN 1 ELSE 0 END) AS Não_Atendido,
   SUM(CASE WHEN C.STATUS = 2 THEN 1 ELSE 0 END) AS Em_Negociação,
   SUM(CASE WHEN C.STATUS = 3 THEN 1 ELSE 0 END) AS Venda_Realizada,
   SUM(CASE WHEN C.STATUS = 4 THEN 1 ELSE 0 END) AS Desistiu
   ```
   - Utiliza a função `SUM` em combinação com `CASE` para contar o número de registros condicionalmente com base no valor da coluna `STATUS`.
   - Cada linha representa um status diferente (Não Atendido, Em Negociação, Venda Realizada, Desistiu).

4. **Cláusula FROM e LEFT JOIN:**
   ```sql
   FROM AGENDAMENTO_STATUS C
   LEFT JOIN CLIENTE_AGENDAMENTO A ON A.ID_VENDEDOR = C.ID_CLIENTE_AGENDAMENTO
   ```
   - Seleciona dados das tabelas `AGENDAMENTO_STATUS` (como `C`) e `CLIENTE_AGENDAMENTO` (como `A`) usando um LEFT JOIN.

5. **Condições WHERE:**
   ```sql
   WHERE 
       ATIVE = 1
       AND (
           ID_VENDEDOR = (SELECT ID FROM APEX_APPL_ACL_USERS WHERE USER_NAME = :APP_USER)
           OR 'ADMIN' = (SELECT ROLE_NAMES FROM APEX_APPL_ACL_USERS WHERE USER_NAME = :APP_USER)
       )
   ```
   - Filtra os resultados com base nas condições especificadas:
      - `ATIVE` deve ser igual a 1.
      - O `ID_VENDEDOR` deve corresponder ao `ID` do usuário atual (obtido por meio de uma subconsulta) ou o usuário deve ter a função 'ADMIN'.

Essa consulta retorna um conjunto de resultados agregados com informações sobre o status dos agendamentos.
