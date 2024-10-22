CREATE OR REPLACE PACKAGE APPS.XXGIR_RH_28045 AS
   --
   /*******************************************************************************
   * But:
   *     Ce paquetage permet d'exporter � SAGIP des gains d�claratoires (H760),
   *     des d�clarations de temps (H620) et l'annulation des documents d'entr�e (H010).
   *
   * Pr�-requis  : S.O.
   *
   * Post-requis : L'adaptation 28065 est ex�cut�e ensuite pour mettre � jour les
   *               statuts de transfert des donn�es vers SAGIP.
   *
   ********************************************************************************
   * Modifications:
   * Par                            Date         Description
   * ----------------------------   ----------   ---------------------------------
   * Michel Dessureault             2012-09-24   Cr�ation CHG128106
   * Michel Dessureault             2012-10-09   Ajouter et corriger deux champs
   *                                             dans la table GIR_RH_FDT et
   *                                             correction du code pour le traitement des heures rembours�es.
   * Michel Dessureault             2012-11-09   Ajouter le traitement pour les transactions
   *                                             H010 et H620
   * Michel Dessureault             2012-12-21   Enlever l'appel � Fn_obten_tx_horr qui est maintenant dans le RH_23000.
   * Michel Dessureault             2013-01-16   Retouche 41. Ajouter le param�tre pour la date d'ex�cution.
   * Mehdi Bennani					2018-03-29   MBEN  -  Mise � niveau V12
   * Gheith Abi-Nader               2022-05-12   Remplacement du NAS par le num�ro d?employ� dans les syst�mes SAGIP-SAGIR
   *******************************************************************************/
   --
/*******************************************************************************
*                                  PROC�DURES
******************************************************************************/
   --
   -- ============================================================================
   -- P_expor_dons_H760:
   -- ============================================================================
   /****************************************************************************
   * But : Cette proc�dure permet d'exporter les donn�es des feuilles de temps
   *       de SAGIR vers SAGIP pour les gains d�claratoires de paie standard.
   *****************************************************************************
   *
   *   Param�tres entr�e    :
   *       - pv_dt_exect       : Date d'ex�cution
   *
   *   Param�tres de sortie :
   *       - errbuf            : Description erreur Oracle
   *       - retcode           : Code erreur Oracle
   *
   *
   *   Modifications :
   *   Par                  Date        Description
   *   ------------------   ----------  -------------
   *   Michel Dessureault   2012-09-24  Cr�ation
   *   Michel Dessureault   2013-01-16  Retouche 41 - Ajouter le param�tre pour la date d'ex�cution.
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
   * But : Cette proc�dure permet d'exporter les donn�es des feuilles de temps
   *       de SAGIR vers SAGIP pour les d�clarations de temps de paie variable
   *       ainsi que l'annulation des documents d'entr�e H010.
   *****************************************************************************
   *
   *   Param�tres entr�e    :
   *       - pv_dt_dern_exect  : Date de la derni�re ex�cution r�ussie de l'adaptation
   *       - pv_dt_exect       : Date d'ex�cution
   *
   *   Param�tres de sortie :
   *       - errbuf            : Description erreur Oracle
   *       - retcode           : Code erreur Oracle
   *
   *
   *   Modifications :
   *   Par                  Date        Description
   *   ------------------   ----------  -------------
   *   Michel Dessureault   2012-11-08  Cr�ation
   *   Michel Dessureault   2013-01-16  Retouche 41 - Ajouter le param�tre pour la date d'ex�cution.
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
   * But : Cette proc�dure permet de creer le fichier en sortie pour SAGIP
   *****************************************************************************
   *
   *   Param�tres entr�e    :
   *       - pv_dt_dern_exect  : Date de la derni�re ex�cution r�ussie de l'adaptation
   *       - pv_dt_exect       : Date d'ex�cution
   *
   *   Param�tres de sortie :
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
   * But : Cette proc�dure permet de creer le fichier en sortie pour SAGIP
   *****************************************************************************
   *
   *   Param�tres entr�e    :
   *       - pv_dt_exect       : Date d'ex�cution
   *
   *   Param�tres de sortie :
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
