--
-- ****************************************************************************************************************
--
--  Domaine       : RH
--  Livraison     : R_8072_DMPGI_V12
--  Adaptation    : RH-28025
--  Date création : 2018-06-04
--  Créé par      : Julie Goulet
--
--  Description   : Création du script qui permet le refresh de la VM lors Custover adop.
--
--  Environnement cible (Schéma) : APPS
--
--  Historique des modifications
--
--  Modifié par                 Date                    Description de la modification
--  __________________________ _______________________ __________________________________
--  Julie Goulet               2018-06-04              Mise à niveau V12
-- ****************************************************************************************************************

exec ad_zd.load_ddl('CUTOVER','drop materialized view XXGIR_RH_AFECT_HORR_TRAVL_VM');

exec ad_zd.load_ddl('CUTOVER', 'BEGIN EXECUTE IMMEDIATE ''CREATE MATERIALIZED VIEW xxgir_rh_afect_horr_travl_vm build deferred refresh on demand using trusted constraints evaluate using CURRENT EDITION as SELECT css.schedule_id id_horr,paaf.person_id id_persn,paaf.assignment_id id_afect,sso.start_template_detail_id id_debut_modl,paaf.effective_start_date dt_debut_efect_afect,paaf.effective_end_date dt_fin_efect_afect,sso.start_date_active dt_debut_efect_objet,sso.end_date_active dt_fin_efect_objet,cssl.schedule_name nm_horr_travl,cstt.template_id id_modl,cstt.template_name nm_modl,cstb.template_length_days nb_jj_cycle,css.start_date_active dt_debut_horr_activ,css.end_date_active dt_fin_horr_activ,cstb.template_type type_modl,cstt.template_desc de_modl,flv.meaning texte_type_modl,flv.lookup_type type_horr_travl,flv.lookup_code cd_horr_travl,flv.start_date_active dt_debut_autor_horr,flv.end_date_active dt_fin_autor_horr,flv.attribute1 id_calnd_atach,flv.attribute2 no_horr_travl_sagip,flv.attribute3 no_cedl_travl,flv.attribute4 nb_hh_moyen_formt_decml,flv.attribute5 enten_ferie,flv.attribute6 dt_hh_creat,flv.attribute7 horr_subst FROM cac_sr_schedules_b css,cac_sr_templates_tl cstt,cac_sr_templates_b cstb,cac_sr_schedules_tl cssl,cac_sr_schdl_objects sso,fnd_lookup_values_vl flv,per_all_assignments_f paaf WHERE paaf.assignment_id = sso.object_id AND sso.object_type = ''''PERSON_ASSIGNMENT'''' AND sso.schedule_id = css.schedule_id AND css.template_id = cstt.template_id AND cstb.template_id = cstt.template_id AND cssl.schedule_id = css.schedule_id AND cssl.language = SYS_CONTEXT(''''USERENV'''',''''LANG'''') AND cstt.language = SYS_CONTEXT(''''USERENV'''',''''LANG'''') AND cstb.deleted_date IS NULL AND paaf.primary_flag  = ''''Y'''' AND flv.lookup_type = ''''GIR_RH_HORR_TRAVL'''' AND flv.attribute1 = css.schedule_id AND flv.enabled_flag = ''''Y'''' '';	EXECUTE IMMEDIATE ''CREATE INDEX apps.idx_xxgir_rh_horr_travl_n1 ON apps.xxgir_rh_afect_horr_travl_vm (id_horr)'';EXECUTE IMMEDIATE ''CREATE INDEX apps.idx_xxgir_rh_horr_travl_n2 ON apps.xxgir_rh_afect_horr_travl_vm (id_afect)'';EXECUTE IMMEDIATE ''CREATE INDEX apps.idx_xxgir_rh_horr_travl_n3 ON apps.xxgir_rh_afect_horr_travl_vm (id_debut_modl)'';EXECUTE IMMEDIATE ''CREATE INDEX apps.idx_xxgir_rh_horr_travl_n4 ON apps.xxgir_rh_afect_horr_travl_vm (id_modl)'';EXECUTE IMMEDIATE ''CREATE INDEX apps.idx_xxgir_rh_horr_travl_n5 ON apps.xxgir_rh_afect_horr_travl_vm (dt_debut_efect_objet)'';END;');

SHOW ERROR
