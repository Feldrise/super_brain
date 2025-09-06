import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/reminder/domain/entities/summary.dart';
import 'package:super_brain/features/reminder/data/models/summary_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/reminder/domain/entities/summary.dart';
import 'package:super_brain/features/reminder/data/models/summary_models.dart';

class PopulateSummaryDataService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> populateSummaries() async {
    final courseSummaries = [
      Summary(
        id: 'superbrain_mindset',
        title: 'Mindset d’Apprentissage Accéléré',
        content: '''# Mindset d’Apprentissage Accéléré

## Idées clés
Un cerveau apprend mieux lorsque la **croyance**, la **motivation** et les **méthodes** sont alignées (les “3M”). Écarter les croyances limitantes (“je n’ai pas de mémoire”) ouvre la voie à des stratégies efficaces.

## Piliers
- **Croyances** : reformuler l’autoperception (“je deviens meilleur chaque jour”).
- **Motivation** : clarifier *pourquoi* apprendre, fixer une intention par session.
- **Méthodes** : appliquer des techniques éprouvées (spaced repetition, associations, loci).

## Rituels
- Intention + micro-objectif (25–45 min).
- Revue de fin de session (2–3 min).
- Journal de progression.

## Application rapide
1. Écrire 3 croyances limitantes → les reformuler.
2. Définir un objectif concret d’apprentissage pour la semaine.
3. Planifier deux sessions focalisées (Pomodoro).''',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        estimatedReadingTime: 7,
        keyPoints: ['Aligner Croyances, Motivation, Méthodes (3M)', 'Fixer une intention par session', 'Rituels courts pour consolider les progrès'],
      ),
      Summary(
        id: 'superbrain_focus',
        title: 'Focus & Gestion de l’Attention',
        content: '''# Focus & Gestion de l’Attention

## Problème
Le multitâche fragmente l’attention et augmente le temps de reprise après interruption.

## Protocoles
- **Blocage du temps** (25–45 min) + pause active.
- **Environnement** : notifications coupées, espace rangé, casque.
- **Priming** : 60 s de respiration nasale, intention écrite.
- **Single-tasking** : une tâche, un contexte, un objectif.

## Réglages personnels
- *Chronotype* : caler le travail profond sur son pic d’énergie.
- *Charge cognitive* : fractionner en étapes visibles.

## Outils
- Liste “interférences → parking lot”.
- Règle des 2 minutes (traiter ou planifier).''',
        createdAt: DateTime.now().subtract(const Duration(days: 9)),
        estimatedReadingTime: 6,
        keyPoints: ['Multitâche = perte d’efficacité', 'Bloquer des sessions profondes', 'Rituel d’ouverture/fermeture de session'],
      ),
      Summary(
        id: 'superbrain_brain_care',
        title: 'Hygiène du Cerveau (Sommeil, Mouvement, Nutrition)',
        content: '''# Hygiène du Cerveau

## Sommeil
- 7–9 h, heure fixe de lever.
- Dernière lumière bleue > 60–90 min avant dodo.
- Revue “3 grands points appris” avant sommeil.

## Mouvement
- 2–5 min de mobilité toutes les 45–60 min.
- Marche après repas pour glycémie.
- Coordination (croisés) pour activer les deux hémisphères.

## Nutrition (repères généraux)
- Hydratation régulière.
- Protéines + fibres au petit-déj pour la vigilance.
- Oméga-3, légumes verts, baies (si compatibles).''',
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
        estimatedReadingTime: 6,
        keyPoints: ['Sommeil régulier → consolidation', 'Mouvement alimente la neuroplasticité', 'Alimentation & hydratation soutiennent l’attention'],
      ),
      Summary(
        id: 'superbrain_memory_basics',
        title: 'Bases de la Mémoire : Encodage, Stockage, Rappel',
        content: '''# Bases de la Mémoire

## Processus
1. **Encodage** : faire *signifier* l’info (imagerie, émotion, histoire).
2. **Stockage** : répétition espacée, variations de contexte.
3. **Rappel** : tests fréquents, récupération active.

## Principes
- **VIVRE** : Vivid, Imagé, Vécu, Relié, Émotion.
- **Chunking** : regrouper en unités plus grandes.
- **Récupération** > relecture passive.''',
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
        estimatedReadingTime: 5,
        keyPoints: ['Encodage riche > relecture', 'Spaced repetition', 'Récupération active'],
      ),
      Summary(
        id: 'superbrain_loci',
        title: 'Méthode des Lieux (Palais de Mémoire)',
        content: '''# Méthode des Lieux

## Principe
Associer chaque idée à un **lieu** familier sur un parcours mental (salon, cuisine, etc.).

## Étapes
1. Choisir 10–20 points de repère stables.
2. Transformer chaque item en image vivante.
3. **Déposer** l’image sur chaque lieu (interaction drôle/exagérée).
4. Parcourir pour rappeler dans l’ordre.

## Variantes
- Plusieurs parcours par thème.
- Ordre inversé en repassant à rebours.

## Pratique
- Commencer avec des listes courtes (courses, pitch).''',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        estimatedReadingTime: 6,
        keyPoints: ['Cartographier des lieux familiers', 'Associer images vives aux repères', 'Rappel séquentiel fiable'],
      ),
      Summary(
        id: 'superbrain_names',
        title: 'Retenir les Prénoms',
        content: '''# Retenir les Prénoms

## Stratégie “S.A.V.E.”
- **S**: *See* — regarder vraiment la personne.
- **A**: *Ask* — faire répéter/épeler, poser une question.
- **V**: *Visualize* — transformer le prénom en image.
- **E**: *Etiquette* — redire le prénom 2–3 fois naturellement.

## Plus
- Associer un trait distinctif (cheveux, lunettes) + image du prénom.
- Lier au contexte (lieu, métier).

## Entraînement
- 5 prénoms/jour, revue en J1/J3/J7.''',
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        estimatedReadingTime: 5,
        keyPoints: ['Regarder, questionner, visualiser, répéter', 'Associer visage + image du prénom', 'Répétition espacée courte'],
      ),
      Summary(
        id: 'superbrain_numbers',
        title: 'Chiffres & Listes (Systèmes d’Association)',
        content: '''# Chiffres & Listes

## Techniques
- **Peg System** : accrocher chaque numéro à une image “crochet”.
- **Histoire en chaîne** : relier les items dans une mini-narration.
- **Chunking** : 12-24-36 plutôt que 122436.

## Usage
- Bullet points d’une présentation.
- Codes non sensibles (à éviter pour mots de passe).
- Étapes de procédure (qualité, SAV).''',
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        estimatedReadingTime: 5,
        keyPoints: ['Systèmes “peg” pour l’ordre', 'Histoire en chaîne', 'Regrouper en blocs'],
      ),
      Summary(
        id: 'superbrain_speed_reading',
        title: 'Lecture Rapide & Compréhension',
        content: '''# Lecture Rapide

## Freins
- Subvocalisation excessive, retours en arrière, manque de repères.

## Protocoles
- **Guide visuel** (doigt/stylet) pour le balayage.
- Aperçu (titre, sous-titres, questions) avant lecture.
- Intervalles de 2–5 pages en tempo rapide, puis normaliser.

## Compréhension
- Pause de synthèse toutes les sections.
- Flashcards “question → réponse” issues du texte.''',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        estimatedReadingTime: 7,
        keyPoints: ['Réduire la subvocalisation', 'Utiliser un guide visuel', 'Synthèses fréquentes'],
      ),
      Summary(
        id: 'superbrain_notetaking',
        title: 'Prise de Notes Efficace (Cornell & Mappe Mentale)',
        content: '''# Prise de Notes Efficace

## Cornell
- Colonne mots-clés/questions + zone de notes + résumé.
- Relecture active par questions.

## Mind Mapping
- Idée centrale → branches → sous-branches (mots-clés + images).
- Utile pour brainstorm, révision, présentation.

## Boucle de consolidation
- Reprise 10 min après, 24 h plus tard, puis hebdomadaire.''',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        estimatedReadingTime: 6,
        keyPoints: ['Cornell pour interroger le contenu', 'Mind map pour structurer visuellement', 'Répétitions programmées'],
      ),
      Summary(
        id: 'superbrain_languages',
        title: 'Apprentissage des Langues',
        content: '''# Apprentissage des Langues

## Cadre
- Fréquence > durée (sessions courtes quotidiennes).
- Input compréhensible + sortie guidée (micro-paroles).

## Techniques
- SRS pour vocabulaire thématique.
- Images + contexte d’usage.
- Ancrages kinesthésiques (gestes) pour verbes.

## Mini-défis
- 5 phrases utiles/jour.
- 1 micro-conversation scénarisée/48 h.''',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        estimatedReadingTime: 5,
        keyPoints: ['Régularité quotidienne', 'SRS + contexte + gestes', 'Micro-conversations'],
      ),
      Summary(
        id: 'superbrain_habits',
        title: 'Habitudes Cognitives & Anti-Procrastination',
        content: '''# Habitudes Cognitives & Anti-Procrastination

## Bâtir l’habitude
- Déclencheur → Action minuscule → Récompense immédiate.
- Empiler sur une routine existante.

## Anti-procrastination
- Règle des 5 minutes : démarrer micro-tâche.
- Clarifier le *pourquoi*, planifier le *quand* et *où*.
- Éliminer friction (préparer matériel/onglets).

## Suivi
- Chaîne d’habitude (ne pas “casser la chaîne”).''',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        estimatedReadingTime: 5,
        keyPoints: ['Tiny habits sur déclencheurs existants', 'Démarrer en 5 minutes', 'Réduire la friction'],
      ),
      Summary(
        id: 'superbrain_digital_wellbeing',
        title: 'Détox Digitale & Mémoire',
        content: '''# Détox Digitale & Mémoire

## Risques
- Surcharge d’inputs, zapping, baisse du rappel indépendant.

## Contre-mesures
- Fenêtres sans écran (matin/soir).
- Notifications en mode résumé; batch emails.
- “Sprints hors ligne” pour apprendre/produire.

## Mémoire
- Rappels espacés *sans* dépendance à l’app.
- Journal papier des idées maîtresses.''',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        estimatedReadingTime: 4,
        keyPoints: ['Limiter le zapping numérique', 'Plages off-screen', 'Récupération sans béquille'],
      ),
      Summary(
        id: 'superbrain_review_system',
        title: 'Système de Révision & Maîtrise à Long Terme',
        content: '''# Système de Révision

## Plan type
- J0 encodage riche (images, liens, test).
- Revues : J1, J3, J7, J14, J30.
- Quiz courts + enseignement fictif (“expliquer à…”).

## Mesure
- Score de rappel, niveau de confiance, temps écoulé.
- Ajuster l’intervalle selon la difficulté.''',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        estimatedReadingTime: 4,
        keyPoints: ['Calendrier J1/J3/J7/J14/J30', 'Quiz + effet d’enseignement', 'Adapter l’intervalle'],
      ),
    ];

    final batch = _firestore.batch();

    for (final summary in courseSummaries) {
      final model = SummaryModel.fromDomain(summary);
      final docRef = _firestore.collection('global_summaries').doc(summary.id);
      batch.set(docRef, model.toFirestore());
    }

    await batch.commit();
    print('Successfully populated ${courseSummaries.length} SuperBrain-inspired summaries');
  }

  static Future<void> clearSummaries() async {
    final ids = [
      'superbrain_mindset',
      'superbrain_focus',
      'superbrain_brain_care',
      'superbrain_memory_basics',
      'superbrain_loci',
      'superbrain_names',
      'superbrain_numbers',
      'superbrain_speed_reading',
      'superbrain_notetaking',
      'superbrain_languages',
      'superbrain_habits',
      'superbrain_digital_wellbeing',
      'superbrain_review_system',
    ];

    // Firestore whereIn max is 10 per query → split if needed
    final chunks = <List<String>>[];
    for (var i = 0; i < ids.length; i += 10) {
      chunks.add(ids.sublist(i, i + 10 > ids.length ? ids.length : i + 10));
    }

    final batch = _firestore.batch();
    for (final chunk in chunks) {
      final snap = await _firestore.collection('global_summaries').where('id', whereIn: chunk).get();
      for (final doc in snap.docs) {
        batch.delete(doc.reference);
      }
    }

    await batch.commit();
    print('Successfully cleared SuperBrain-inspired summaries');
  }
}
