--
-- *********************************************************************************************
--
--  Domaine       : RH
--  Livraison     : 
--  Adaptation    : RH_28327
--  Date création : 2020-10-19
--  Créé par      : Lucie Côté 
--
--  Description :
--     Modification de la table GIR_TRANS_H660.
--
--  Environnement cible (Schéma) : XXGIR
--
--  Historique des modifications
--  
--  Modifié par                Date         Description de la modification
--  __________________________ ____________ ____________________________________________________
--  Lucie Côté                 2020-10-19   DDC 281068 : colonne DT_DEBUT_RETN
--                                                       permettre la valeur NULL
-- 
-- *********************************************************************************************
--
WHENEVER SQLERROR CONTINUE
--
-- Modification de la TABLE
--
PROMPT
PROMPT Alter colonne DT_DEBUT_RETN de la table GIR_TRANS_H660
PROMPT
ALTER TABLE GIR_TRANS_H660 MODIFY DT_DEBUT_RETN VARCHAR2(8) NULL;
--

SHOW ERRORS
