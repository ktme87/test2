CREATE OR REPLACE PACKAGE APPS.XXGIR_RH_28045 AS
   --
   /*******************************************************************************
   * But:
   *     Ce paquetage permet d'exporter à SAGIP des gains déclaratoires (H760),
   *     des déclarations de temps (H620) et l'annulation des documents d'entrée (H010).
   *
   * Pré-requis  : S.O.
   *
   * Post-requis : L'adaptation 28065 est exécutée ensuite pour mettre à jour les
   *               statuts de transfert des données vers SAGIP.
   *
   ********************************************************************************
   * Modifications:
   * Par                            Date         Description
   * ----------------------------   ----------   ---------------------------------
   * Michel Dessureault             2012-09-24   Création CHG128106
   * Michel Dessureault             2012-10-09   Ajouter et corriger deux champs
   *                                             dans la table GIR_RH_FDT et
   *                                             correction du code pour le traitement des heures remboursées.
   * Michel Dessureault             2012-11-09   Ajouter le traitement pour les transactions
   *                                             H010 et H620
   * Michel Dessureault             2012-12-21   Enlever l'appel à Fn_obten_tx_horr qui est maintenant dans le RH_23000.
   * Michel Dessureault             2013-01-16   Retouche 41. Ajouter le paramètre pour la date d'exécution.
   * Mehdi Bennani					2018-03-29   MBEN  -  Mise à niveau V12
   * Gheith Abi-Nader               2022-05-12   Remplacement du NAS par le numéro d?employé dans les systèmes SAGIP-SAGIR
   *******************************************************************************/
   --
/*******************************************************************************
*                                  PROCÉDURES
******************************************************************************/
   --
   -- ============================================================================
   -- P_expor_dons_H760:
   -- ============================================================================
   /****************************************************************************
   * But : Cette procédure permet d'exporter les données des feuilles de temps
   *       de SAGIR vers SAGIP pour les gains déclaratoires de paie standard.
   *****************************************************************************
   *
   *   Paramètres entrée    :
   *       - pv_dt_exect       : Date d'exécution
   *
   *   Paramètres de sortie :
   *       - errbuf            : Description erreur Oracle
   *       - retcode           : Code erreur Oracle
   *
   *
   *   Modifications :
   *   Par                  Date        Description
   *   ------------------   ----------  -------------
   *   Michel Dessureault   2012-09-24  Création
   *   Michel Dessureault   2013-01-16  Retouche 41 - Ajouter le paramètre pour la date d'exécution.
   *   Edgar  Doiron        2016-07-08  DDC 209235 Split pour rouler la H760 en PAralele
   *************************************************************************/
PROCEDURE P_expor_dons_H760 ( errbuf         OUT VARCHAR2
                             ,retcode        OUT VARCHAR2
                             ,pv_dt_exect IN     VARCHAR2
                             --DDC 209235
                             ,pn_person_id_debut IN NUMBER
                             ,pn_person_id_fin   IN NUMBER);
   --
   -- ============================================================================
   -- P_expor_dons_H620:
   -- ============================================================================
   /****************************************************************************
   * But : Cette procédure permet d'exporter les données des feuilles de temps
   *       de SAGIR vers SAGIP pour les déclarations de temps de paie variable
   *       ainsi que l'annulation des documents d'entrée H010.
   *****************************************************************************
   *
   *   Paramètres entrée    :
   *       - pv_dt_dern_exect  : Date de la dernière exécution réussie de l'adaptation
   *       - pv_dt_exect       : Date d'exécution
   *
   *   Paramètres de sortie :
   *       - errbuf            : Description erreur Oracle
   *       - retcode           : Code erreur Oracle
   *
   *
   *   Modifications :
   *   Par                  Date        Description
   *   ------------------   ----------  -------------
   *   Michel Dessureault   2012-11-08  Création
   *   Michel Dessureault   2013-01-16  Retouche 41 - Ajouter le paramètre pour la date d'exécution.
   *
   *************************************************************************/
PROCEDURE P_expor_dons_H620 ( errbuf               OUT VARCHAR2
                             ,retcode              OUT VARCHAR2
                             ,pv_dt_dernr_exect IN     VARCHAR2
                             ,pv_dt_exect       IN     VARCHAR2
                             --DS-CHG00182096
                             ,pn_person_id_debut IN NUMBER
                             ,pn_person_id_fin   IN NUMBER);
/****************************************************************************
   * But : Cette procédure permet de creer le fichier en sortie pour SAGIP
   *****************************************************************************
   *
   *   Paramètres entrée    :
   *       - pv_dt_dern_exect  : Date de la dernière exécution réussie de l'adaptation
   *       - pv_dt_exect       : Date d'exécution
   *
   *   Paramètres de sortie :
   *       - errbuf            : Description erreur Oracle
   *       - retcode           : Code erreur Oracle
   *
   *
   *   Modifications :
   *   Par                  Date        Description
   *   ------------------   ----------  -------------
   *   Edgar doirn          2014-09-26  Creation
   *
   *************************************************************************/
PROCEDURE P_sgi_H620_H010   ( errbuf               OUT VARCHAR2
                             ,retcode              OUT VARCHAR2
                             ,pv_dt_dernr_exect IN     VARCHAR2
                             ,pv_dt_exect       IN     VARCHAR2   );
/****************************************************************************
   * But : Cette procédure permet de creer le fichier en sortie pour SAGIP
   *****************************************************************************
   *
   *   Paramètres entrée    :
   *       - pv_dt_exect       : Date d'exécution
   *
   *   Paramètres de sortie :
   *       - errbuf            : Description erreur Oracle
   *       - retcode           : Code erreur Oracle
   *
   *
   *   Modifications :
   *   Par                  Date        Description
   *   ------------------   ----------  ------------- 
   *   Edgar doirn          2016-07-12  Creation
   *
   *************************************************************************/
PROCEDURE p_sgi_h760        (errbuf            OUT VARCHAR2,
                             retcode           OUT VARCHAR2,
                             pv_dt_exect       IN VARCHAR2);
-- Pour test
PROCEDURE p_creer_erreur(pv_code_erreur_gir   IN VARCHAR2,
                            pv_token_value       IN VARCHAR2,
                            pn_id_demnd          IN NUMBER,
                            pd_dt_ereur_rejet    IN DATE DEFAULT SYSDATE,
                            pv_nm_abreg_progr    IN VARCHAR2,
                            pv_nm_procd          IN VARCHAR2,
                            pv_de_mesg_techn     IN VARCHAR2
                            );

END XXGIR_RH_28045;
/
