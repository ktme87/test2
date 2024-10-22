/***************************************************************************************************
*
*  Script        : DATAFIX_OS_CHG278428_V2.sql
*  Date création : 2020-08-06
*  Créé par      : Lucie COTE
*
*  Description :
*          Corriger la quantité non facturée de la ligne 4 du BC 30028696.
*
*  Historique des modifications
*  
*  Modifié par                Date                    Description de la modification
*  __________________________ _______________________ ______________________________
*  
*  François Lachance          2020-10-09              INC161655: Correction demandé lors des EA
***************************************************************************************************/
DECLARE
   -- Variables de définition du datafix
   vlv_nm_datfx    VARCHAR2(6)   := '278428';
   vlv_params      VARCHAR2(150) := NULL;
   vlv_remarques   VARCHAR2(150) := NULL;
   vlv_type        VARCHAR2(2)   := 'RE';
   vlv_in_actif    VARCHAR2(1)   := 'O';
   vlv_desc        VARCHAR2(240) := 'Corriger la quantité non facturée de la ligne 4 du BC 30028696';

   -- Variables de lignes d'instructions (XXGIR_DATFX_V2)
   vlv_nm_table    VARCHAR2(30);
   vlv_alias       VARCHAR2(4);
   vlv_trigr       VARCHAR2(4000);
   vlv_type_maj    VARCHAR2(6);
   vlv_claus_where VARCHAR2(4000);
   vlv_set_values  VARCHAR2(4000);

  TYPE type_liste IS TABLE OF VARCHAR2(2000); 
  vlt_liste type_liste; 
   
BEGIN
   -- Créer le datafix
   xxgir_exect_datfx_v2.p_creer_datfx( pv_nm_datfx  => vlv_nm_datfx
                                      ,pv_params    => vlv_params
                                      ,pv_remarques => vlv_remarques
                                      ,pv_type      => vlv_type
                                      ,pv_in_actif  => vlv_in_actif
                                      ,pv_desc      => vlv_desc);

   -- Ajouter une ligne d'instructions
   -------------------------------------------------------------------------------------------------
   -- Étape 1 : Annuler la quantité dans les lignes du bon de commande 

   -- Variables 
   vlv_nm_table    := 'po_lines_all';
   vlv_alias       := NULL;
   vlv_trigr       := NULL;
   vlv_type_maj    := 'UPDATE';

   vlv_claus_where := 'WHERE po_header_id = 2313744'||
                      '  AND po_line_id =  6514502'||
                      '  AND line_num = 4';

   vlv_set_values  := 'SET quantity = 80203.95,'|| 
                      '    last_update_date = SYSDATE, '||
                      '    last_updated_by = -1, ' ||
                      '    last_update_login = -1 ';
    
   -- Appel de la fonction
   xxgir_exect_datfx_v2.p_ajouter_ligne( pv_nm_datfx    => vlv_nm_datfx
                                        ,pv_nm_table    => vlv_nm_table
                                        ,pv_alias       => vlv_alias
                                        ,pv_trigr       => vlv_trigr
                                        ,pv_type_maj    => vlv_type_maj
                                        ,pv_claus_where => vlv_claus_where
                                        ,pv_set_values  => vlv_set_values);    
   
   ------------------------------------------------------------------------------------------------
   -- Étape 2 : Annuler la quantité dans les expéditions du BC 

   -- Variables 
   vlv_nm_table    := 'po_line_locations_all';
   vlv_alias       := NULL;
   vlv_trigr       := NULL;
   vlv_type_maj    := 'UPDATE';

   vlv_claus_where := 'WHERE line_location_id  = 8031034';

   vlv_set_values  := 'SET quantity_cancelled = 112285.53,'||
                      '    last_update_date = SYSDATE, '||
                      '    last_updated_by = -1, ' ||
                      '    last_update_login = -1 ';
   
   -- Appel de la fonction
   xxgir_exect_datfx_v2.p_ajouter_ligne( pv_nm_datfx    => vlv_nm_datfx
                                        ,pv_nm_table    => vlv_nm_table
                                        ,pv_alias       => vlv_alias
                                        ,pv_trigr       => vlv_trigr
                                        ,pv_type_maj    => vlv_type_maj
                                        ,pv_claus_where => vlv_claus_where
                                        ,pv_set_values  => vlv_set_values);    
   
   -------------------------------------------------------------------------------------------------
   -- Étape 3 : annuler la quantité dans les répartitions du bc 

   -- Variables 
   vlv_nm_table    := 'po_distributions_all';
   vlv_alias       := NULL;
   vlv_trigr       := NULL;
   vlv_type_maj    := 'UPDATE';

   vlv_claus_where := 'WHERE po_distribution_id = 7902846';

   vlv_set_values  := 'SET quantity_cancelled = 112285.53,'||
                      '    last_update_date = SYSDATE, '||
                      '    last_updated_by = -1, ' ||
                      '    last_update_login = -1 ';
    
   -- Appel de la fonction
   xxgir_exect_datfx_v2.p_ajouter_ligne( pv_nm_datfx    => vlv_nm_datfx
                                        ,pv_nm_table    => vlv_nm_table
                                        ,pv_alias       => vlv_alias
                                        ,pv_trigr       => vlv_trigr
                                        ,pv_type_maj    => vlv_type_maj
                                        ,pv_claus_where => vlv_claus_where
                                        ,pv_set_values  => vlv_set_values);    

   -------------------------------------------------------------------------------------------------
   
END;

/
SHOW ERRORS
