#!/bin/bash
# +=====================================================================================================+
# |  S.A.G.I.R                                                                						    |
# +=====================================================================================================+
# |
# | FICHIER
# |   XXGIR_RH_OLM_25019_REPRT.sh
# |
# | DESCRIPTION
# |   Script de creation du repertoire $APPLCSF/$APPLOUT/XXGIR_RH_OLM_25019_REPRT
# |
# |
# | PLAN DE TRAVAIL : Exécution sous UNIX
# |
# | Séquence	Activité																	Fait par
# | --------	--------																	-------
# | 1-			Connexion dans UNIX															DBA
# | 2-			Accéder à $XXGIR_TOP/bin 													DBA 
# | 4-			Exécuter: ./XXGIR_RH_OLM_25019_REPRT.sh										DBA
# |
# | HISTORIQUE
# | Auteur          		Date                		Description
# | --------------  		------------------  		-----------------------------------------
# | Francis Tshimbombo      2021/12/16          		Création Initiale
# |
# +=====================================================================================================+
# 

## 
#
mkdir $APPLCSF/$APPLOUT/GIR_RH_OLM_25019_REPRT
#
##
#On donne tous les droit sur le contenu de ce repertoire
chmod -R 777 $APPLCSF/$APPLOUT/GIR_RH_OLM_25019_REPRT
#
#

