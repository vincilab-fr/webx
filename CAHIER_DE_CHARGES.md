# CAHIER_DE_CHARGES.md

## Introduction
Le projet WebX est un fork du projet KDX (KodPix) de Yug Merabtene, visant à créer un langage de programmation compilé capable de générer du code pour le backend et le frontend à partir d'une seule syntaxe. Le compilateur WebX est conçu pour produire un code natif x86-64 ELF pour le backend et du code HTML/CSS/JS pour le frontend.

## Historique des Changements
- 2023-02-20 : Début du projet WebX, fork de KDX
- 2023-03-01 : Mise en place de l'infrastructure de qualité et de l'architecture du compilateur
- 2023-04-15 : Début de la phase 1 : Core compiler — lexer, parser, AST, codegen, tests, CI
- 2024-07-19 : Ajout de passes d'optimisation supplémentaires avant la génération du frontend, suite à des problèmes de performances constatés lors des tests. Les pipelines CI nécessitent désormais des timeouts plus généreux pour les projets en assembly.

## Problèmes Encounterés
Lors de la phase 1, nous avons rencontré des problèmes de performances qui nécessitaient plus de passes d'optimisation dans le compilateur avant de procéder à la génération du frontend. De plus, les pipelines CI ont nécessité des ajustements pour éviter les timeouts lors de la compilation de projets en assembly.

## Leçons Apprises
- Les pipelines CI doivent être configurés avec des timeouts suffisamment longs pour accommoder la compilation de code assembleur, qui peut être plus longue que prévu.
- L'optimisation du code est cruciale avant la génération du frontend pour assurer des performances satisfaisantes.

## Phases du Projet
1. **Phase 1 : Core compiler** — Développement du compilateur de base, incluant le lexer, le parser, l'AST, la génération de code, les tests et l'intégration continue.
   - **Priorité :** Élevée
   - **Statut :** En cours, avec ajout de passes d'optimisation supplémentaires
2. **Phase 2 : Frontend generation** — Génération du code HTML/CSS/JS pour le frontend à partir du code WebX.
   - **Priorité :** Moyenne, en attente de la finalisation de la phase 1 avec les optimisations nécessaires
   - **Statut :** Planifiée
3. **Phase 3 : Écosystème** — Développement d'un ORM, d'une bibliothèque standard pour le web, d'un gestionnaire de packages et d'un Language Server Protocol (LSP).
   - **Priorité :** Faible, en attente des phases précédentes
   - **Statut :** Planifiée
4. **Phase 4 : Production** — Mise à niveau de la performance, audit de sécurité et préparation pour la communauté.
   - **Priorité :** Faible, en attente des phases précédentes
   - **Statut :** Planifiée

## Conclusion
Le projet WebX est en constante évolution, avec des ajustements réguliers basés sur les leçons apprises et les défis rencontrés. La communauté est invitée à contribuer et à suivre les progrès du projet. Les crédits pour les origines du projet vont à Yug Merabtene et au projet KDX.