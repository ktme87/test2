 /***********************************************************************************
 *  But:
 *        Ce PL-SQL permet de :
 *        - specification de mappage des documents extractions ERF pour CAP
 *          concernant l'extraction GIR ERF - CAP Extraction Cumul du KM par employé
 *
 * Modifications:
 * Par                            Date         Description
 * ----------------------------   ----------   --------------------------------------
 * Simon Dufour                   2010-02-24   DDC-91020: Ajout du champ condt_extra_erf    
 ************************************************************************************/
DECLARE

   pln_id_type_docmn           number;
   pln_id_type_enreg           number;
   pln_id_champ_enreg          number;
   vlv_cd_docmn                varchar2(10);
   vln_id_type_docmn           number;

   CURSOR CUR_obten_id_type_docmn IS
     SELECT id_type_docmn
     FROM   girsgi_type_docmn
     WHERE  cd_docmn = vlv_cd_docmn;

BEGIN

   -- -----------------------------------------------------------------
   -- Obtenir l'identifiant du document XCAPWEBEMI.
   -- -----------------------------------------------------------------
   vlv_cd_docmn := 'XCAPWEBEMI';
   OPEN  CUR_obten_id_type_docmn;
   FETCH CUR_obten_id_type_docmn INTO vln_id_type_docmn;
   CLOSE CUR_obten_id_type_docmn;

   -- -----------------------------------------------------------------
   -- Détruire les spécifications existantes du document XCAPWEBEMI.
   -- -----------------------------------------------------------------
   DELETE FROM girsgi_coln_table_destn gctd
   WHERE  gctd.id_champ_enreg IN (SELECT gce.id_champ_enreg
                                  FROM   girsgi_champ_enreg gce,
                                         girsgi_type_enreg  gte,
                                         girsgi_type_docmn  gtd
                                  WHERE  gce.id_type_enreg = gte.id_type_enreg
                                  AND    gte.id_type_docmn = gtd.id_type_docmn
                                  AND    gtd.cd_docmn = 'XCAPWEBEMI');

   DELETE FROM girsgi_champ_enreg gce
   WHERE  gce.id_type_enreg IN (SELECT gte.id_type_enreg
                                FROM   girsgi_type_enreg  gte,
                                       girsgi_type_docmn  gtd
                                WHERE  gte.id_type_docmn = gtd.id_type_docmn
                                AND    gtd.cd_docmn = 'XCAPWEBEMI');

   DELETE FROM girsgi_type_enreg gte
   WHERE  gte.id_type_docmn IN (SELECT gtd.id_type_docmn
                                FROM   girsgi_type_docmn  gtd
                                WHERE  gtd.cd_docmn = 'XCAPWEBEMI');

   DELETE FROM girsgi_type_docmn gtd
   WHERE  gtd.cd_docmn = 'XCAPWEBEMI';

   -- -----------------------------------------------------------------
   -- Insérer les spécifications du document XCAPWEBEMI.
   -- -----------------------------------------------------------------
   INSERT INTO girsgi_type_docmn (cd_docmn,de_type_docmn,type_sourc_fichr,in_enreg_contr_stand,type_struc_enreg,ps_debut_id_type_enreg,lg_id_type_enreg,nm_table_sourc,nm_coln_id_type_enreg,condt_extra_erf)   VALUES ('XCAPWEBEMI','Extraction des données de la vue XXGIR_AP_WEB_EMPLO_INFO_V de l''envir. ERF','I','N','L',NULL,NULL,'XXGIR_AP_WEB_EMPLO_INFO_V','','WHERE last_update_date BETWEEN to_date(SUBSTR(''pv_parmt_1'',1,10) || '' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')  AND to_date(SUBSTR(''pv_parmt_2'',1,10) || '' 23:59:59'',''YYYY-MM-DD HH24:MI:SS'') AND org_id =DECODE(pv_parmt_3, 999, org_id,pv_parmt_3)') RETURNING id_type_docmn into pln_id_type_docmn;
   INSERT INTO girsgi_type_enreg (id_type_docmn,lg_enreg,in_prefx_enreg_stand,lc_type_enreg,va_id_type_enreg)   VALUES  (pln_id_type_docmn,681,'N','E','') RETURNING id_type_enreg into pln_id_type_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'IDENTIFICATION',1,1,'','','N','O','','','''0''') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'SOURCE',2,4,'','','T','O','','','CD_ENTIT') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'DATE DE CREATION',6,8,'SYSDATE','YYYYMMDD','D','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'LIBRE',14,668,'NULL','','T','N','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_type_enreg (id_type_docmn,lg_enreg,in_prefx_enreg_stand,lc_type_enreg,va_id_type_enreg)   VALUES  (pln_id_type_docmn,681,'N','D','') RETURNING id_type_enreg into pln_id_type_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'IDENTIFICATION',1,1,'','','N','O','','','''1''') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'SOURCE',2,4,'CD_ENTIT','','T','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'DATE DE CREATION',6,8,'SYSDATE','YYYYMMDD','D','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'EMPLOYEE_ID',14,15,'EMPLOYEE_ID','','N','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'VALUE_TYPE',29,30,'VALUE_TYPE','','T','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'LAST_UPDATE_DATE',59,8,'LAST_UPDATE_DATE','YYYYMMDD','D','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'LAST_UPDATED_BY',67,15,'LAST_UPDATED_BY','','N','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'VALUE',82,240,'VALUE','','T','N','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'SCHEDULE_PERIOD_NAME',322,60,'SCHEDULE_PERIOD_NAME','','T','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'CREATION_DATE',382,8,'CREATION_DATE','YYYYMMDD','D','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'CREATED_BY',390,15,'CREATED_BY','','N','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'ORG_ID',405,15,'ORG_ID','','N','N','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'NUMERIC_VALUE',420,22,'NUMERIC_VALUE','','N','N','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'NOM_EMPLOYE_CUMUL',442,240,'NOM_EMPLOYE_CUMUL','','T','N','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_type_enreg (id_type_docmn,lg_enreg,in_prefx_enreg_stand,lc_type_enreg,va_id_type_enreg)   VALUES  (pln_id_type_docmn,681,'N','P','') RETURNING id_type_enreg into pln_id_type_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'IDENTIFICATION',1,1,'','','N','O','','','''9''') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'SOURCE',2,4,'','','T','O','','','CD_ENTIT') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'DATE DE CREATION',6,8,'SYSDATE','YYYYMMDD','D','O','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'NBRE TOTAL',14,15,'','','N','O','','COUNT(*)','') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'MONTANT TOTAL',29,15,'','','N','O','','','''0''') RETURNING id_champ_enreg into pln_id_champ_enreg;
   INSERT INTO girsgi_champ_enreg (id_type_enreg,nm_champ,ps_debut_champ,lg_champ,nm_coln_table_sourc,de_masq_type_trans_champ,type_trans_champ,in_valr_oblig_champ,enonc_valdt_champ,enonc_calcl_coln_sourc,enonc_trans_coln_sourc)   VALUES  (pln_id_type_enreg,'LIBRE',44,638,'NULL','','T','N','','','') RETURNING id_champ_enreg into pln_id_champ_enreg;

   -- -----------------------------------------------------------------
   -- Mettre à jour l'identifiant pour la gestion des droits du 
   -- document XCAPWEBEMI.
   -- -----------------------------------------------------------------
   UPDATE girsgi_droit_entit_docmn
   SET    id_type_docmn = pln_id_type_docmn
   WHERE  id_type_docmn = vln_id_type_docmn;

   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, 'PROBLEME DE SYSTEME '||SQLERRM );

END;
/

