--
-- *********************************************************************************************
--
--  Domaine       : RH
--  Livraison     : 
--  Adaptation    : RH_28327
--  Date cr�ation : 2020-10-19
--  Cr�� par      : Lucie C�t� 
--
--  Description :
--     Modification de la table GIR_TRANS_H660.
--
--  Environnement cible (Sch�ma) : XXGIR
--
--  Historique des modifications
--  
--  Modifi� par                Date         Description de la modification
--  __________________________ ____________ ____________________________________________________
--  Lucie C�t�                 2020-10-19   DDC 281068 : colonne DT_DEBUT_RETN
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
