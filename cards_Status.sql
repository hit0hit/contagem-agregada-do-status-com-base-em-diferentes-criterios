SELECT
    'Total' AS Status,
    COUNT(*) AS Total,
    SUM(CASE WHEN C.STATUS = 1 THEN 1 ELSE 0 END) AS Não_Atendido,
    SUM(CASE WHEN C.STATUS = 2 THEN 1 ELSE 0 END) AS Em_Negociação,
    SUM(CASE WHEN C.STATUS = 3 THEN 1 ELSE 0 END) AS Venda_Realizada,
    SUM(CASE WHEN C.STATUS = 4 THEN 1 ELSE 0 END) AS Desistiu
FROM J7_AGENDAMENTO_STATUS C
LEFT JOIN J7_CLIENTE_AGENDAMENTO A ON A.ID_VENDEDOR = C.ID_CLIENTE_AGENDAMENTO
where 
    ATIVE = 1
    and (
        ID_VENDEDOR = (SELECT ID FROM APEX_APPL_ACL_USERS WHERE USER_NAME = :APP_USER)
        OR 'ADMIN' = (SELECT ROLE_NAMES FROM APEX_APPL_ACL_USERS WHERE USER_NAME = :APP_USER)
    )