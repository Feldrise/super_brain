import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/reminder/domain/entities/summary.dart';
import 'package:super_brain/features/reminder/data/models/summary_models.dart';

class TestSummaryDataService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> populateTestSummaries() async {
    final testSummaries = [
      Summary(
        id: 'test_summary_newton',
        title: 'Les lois de Newton',
        content: '''# Les lois de Newton

## Introduction

Les trois lois de Newton forment la base de la mécanique classique. Elles décrivent la relation entre les forces appliquées à un corps et son mouvement.

## Première loi : Principe d'inertie

Un objet au repos reste au repos, et un objet en mouvement continue son mouvement en ligne droite à vitesse constante, **sauf si une force extérieure agit sur lui**.

### Exemples :
- Une balle qui roule sur une surface parfaitement lisse continuerait à rouler éternellement
- Un passager qui continue à avancer quand une voiture freine brusquement

## Deuxième loi : Principe fondamental de la dynamique

La force résultante appliquée à un objet est égale au produit de sa masse par son accélération :

**F = ma**

Où :
- F = Force (en Newtons)
- m = masse (en kilogrammes)  
- a = accélération (en m/s²)

## Troisième loi : Principe d'action-réaction

À chaque action correspond une réaction égale et opposée.

### Exemples :
- Quand vous marchez, vos pieds poussent le sol vers l'arrière, et le sol vous pousse vers l'avant
- Le recul d'un fusil quand on tire

## Applications pratiques

Ces lois s'appliquent dans de nombreux domaines :
- **Transport** : conception des véhicules
- **Sport** : analyse des mouvements
- **Ingénierie** : calcul des structures''',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        estimatedReadingTime: 8,
        keyPoints: [
          'Un objet reste dans son état de mouvement sauf si une force agit',
          'Force = masse × accélération (F = ma)',
          'Chaque action a une réaction égale et opposée',
          'Ces lois s\'appliquent à tous les objets dans l\'univers',
        ],
      ),
      Summary(
        id: 'test_summary_psychology',
        title: 'Introduction à la psychologie cognitive',
        content: '''# Introduction à la psychologie cognitive

## Qu'est-ce que la psychologie cognitive ?

La psychologie cognitive étudie les **processus mentaux** : comment nous percevons, apprenons, mémorisons et pensons.

## Les grands domaines

### 1. La perception
Comment nous interprétons les informations sensorielles :
- Vision, audition, toucher
- Reconnaissance de formes et patterns
- Illusions d'optique

### 2. L'attention
Notre capacité à nous concentrer sur certaines informations :
- **Attention sélective** : filtrer les distractions
- **Attention divisée** : faire plusieurs tâches
- **Attention soutenue** : maintenir la concentration

### 3. La mémoire
Système complexe de stockage et récupération :

#### Types de mémoire :
- **Mémoire sensorielle** (< 1 seconde)
- **Mémoire à court terme** (15-30 secondes)
- **Mémoire à long terme** (permanente)

#### Processus :
1. **Encodage** : transformation en souvenir
2. **Stockage** : conservation
3. **Récupération** : rappel

### 4. Le langage
Comment nous comprenons et produisons le langage :
- Grammaire et syntaxe
- Sémantique (sens des mots)
- Pragmatique (usage en contexte)

## Applications pratiques

- **Éducation** : méthodes d'apprentissage
- **Interface utilisateur** : design ergonomique
- **Thérapie** : troubles cognitifs
- **Intelligence artificielle** : modèles de cognition''',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        estimatedReadingTime: 12,
        keyPoints: [
          'La psychologie cognitive étudie les processus mentaux',
          'Quatre domaines principaux : perception, attention, mémoire, langage',
          'La mémoire a trois phases : encodage, stockage, récupération',
          'Applications en éducation, design et thérapie',
        ],
      ),
      Summary(
        id: 'test_summary_revolution',
        title: 'La Révolution française (1789-1799)',
        content: '''# La Révolution française (1789-1799)

## Contexte et causes

### Causes profondes
- **Crise financière** : déficit budgétaire énorme
- **Inégalités sociales** : privilèges de la noblesse et du clergé
- **Influences des Lumières** : idées de liberté et égalité
- **Crise économique** : mauvaises récoltes, famines

### Déclencheurs immédiats
- Convocation des États généraux (mai 1789)
- Serment du Jeu de paume (20 juin 1789)

## Les grandes phases

### 1. Phase modérée (1789-1792)
**Événements clés :**
- Prise de la Bastille (14 juillet 1789)
- Abolition des privilèges (4 août 1789)
- Déclaration des droits de l'homme et du citoyen

**Réformes importantes :**
- Constitution civile du clergé
- Monarchie constitutionnelle
- Départements et communes

### 2. Phase radicale (1792-1794)
**Changements majeurs :**
- Proclamation de la République (22 septembre 1792)
- Exécution de Louis XVI (21 janvier 1793)
- Terreur sous Robespierre

**Mesures révolutionnaires :**
- Calendrier révolutionnaire
- Culte de l'Être suprême
- Maximum des prix

### 3. Thermidor et Directoire (1794-1799)
- Chute de Robespierre (27 juillet 1794)
- Retour à la modération
- Instabilité politique
- Coup d'État de Bonaparte (18 brumaire an VIII)

## Conséquences

### En France
- Fin de l'Ancien Régime
- Égalité civile
- Sécularisation
- Code civil napoléonien

### En Europe
- Guerre contre les coalitions
- Diffusion des idées révolutionnaires
- Nationalism moderne

## Héritage
La Révolution française a posé les bases de la démocratie moderne et des droits de l'homme.''',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        estimatedReadingTime: 15,
        keyPoints: [
          'Causes : crise financière, inégalités sociales, idées des Lumières',
          'Trois phases : modérée (1789-1792), radicale (1792-1794), thermidor (1794-1799)',
          'Événements clés : Bastille, abolition privilèges, exécution du roi',
          'Conséquences durables : égalité civile, droits de l\'homme, sécularisation',
        ],
      ),
      Summary(
        id: 'test_summary_photosynthesis',
        title: 'La photosynthèse : processus vital',
        content: '''# La photosynthèse : processus vital

## Définition

La photosynthèse est le processus par lequel les **plantes vertes** convertissent la lumière solaire en énergie chimique.

## L'équation générale

**6CO₂ + 6H₂O + lumière → C₆H₁₂O₆ + 6O₂**

*Dioxyde de carbone + Eau + Lumière → Glucose + Oxygène*

## Les deux phases

### 1. Réactions photochimiques (phase claire)
**Lieu :** Thylakoïdes des chloroplastes

**Processus :**
- Capture de la lumière par la chlorophylle
- Photolyse de l'eau : H₂O → 2H⁺ + ½O₂ + 2e⁻
- Production d'ATP et NADPH
- Dégagement d'oxygène

### 2. Cycle de Calvin (phase sombre)
**Lieu :** Stroma des chloroplastes

**Processus :**
- Fixation du CO₂
- Utilisation d'ATP et NADPH
- Formation de glucose (C₆H₁₂O₆)

## Facteurs influençant la photosynthèse

### Facteurs limitants
1. **Intensité lumineuse**
   - Augmentation jusqu'à saturation
   - Longueurs d'onde préférées : rouge et bleu

2. **Concentration en CO₂**
   - Substrat principal
   - Augmentation possible par enrichissement

3. **Température**
   - Optimum vers 25-30°C
   - Ralentissement si trop basse ou haute

4. **Disponibilité en eau**
   - Nécessaire pour les réactions
   - Stress hydrique = diminution

## Importance écologique

### Pour les plantes
- Source d'énergie principale
- Croissance et développement

### Pour l'écosystème
- **Production d'oxygène** : 70% de l'O₂ atmosphérique
- **Base de la chaîne alimentaire** : producteurs primaires
- **Régulation du CO₂** : absorption du carbone

### Applications pratiques
- Agriculture : optimisation des rendements
- Biotechnologie : photosynthèse artificielle
- Lutte contre le changement climatique''',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        estimatedReadingTime: 10,
        keyPoints: [
          'Conversion lumière → énergie chimique par les plantes',
          'Deux phases : réactions photochimiques et cycle de Calvin',
          'Facteurs limitants : lumière, CO₂, température, eau',
          'Produit oxygène et glucose, base de la vie sur Terre',
        ],
      ),
      Summary(
        id: 'test_summary_due',
        title: 'Économie : L\'offre et la demande',
        content: '''# L'offre et la demande

## Principe fondamental

L'offre et la demande constituent le **mécanisme central** de l'économie de marché.

## La demande

### Définition
Quantité d'un bien que les consommateurs sont disposés à acheter à un prix donné.

### Loi de la demande
**Plus le prix augmente, moins la quantité demandée est importante** (toutes choses égales par ailleurs).

### Facteurs influençant la demande
- Prix du bien
- Revenus des consommateurs
- Prix des biens substituts/complémentaires
- Goûts et préférences
- Taille de la population

## L'offre

### Définition
Quantité d'un bien que les producteurs sont disposés à vendre à un prix donné.

### Loi de l'offre
**Plus le prix augmente, plus la quantité offerte est importante**.

### Facteurs influençant l'offre
- Coûts de production
- Technologie
- Prix des matières premières
- Nombre de producteurs
- Réglementation

## Équilibre du marché

### Point d'équilibre
Intersection des courbes d'offre et de demande :
- **Prix d'équilibre** : prix où offre = demande
- **Quantité d'équilibre** : quantité échangée à ce prix

### Déséquilibres
- **Excès de demande** (pénurie) → prix tend à augmenter
- **Excès d'offre** (surplus) → prix tend à diminuer

## Applications pratiques

### Élasticité de la demande
- **Élastique** : forte réaction aux prix (produits de luxe)
- **Inélastique** : faible réaction aux prix (produits de première nécessité)

### Interventions publiques
- Prix minimum (salaire minimum)
- Prix maximum (loyers)
- Taxes et subventions''',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        estimatedReadingTime: 7,
        keyPoints: [
          'Demande : quantité voulue par les consommateurs à un prix',
          'Offre : quantité proposée par les producteurs à un prix',
          'Équilibre au croisement offre/demande',
          'Élasticité mesure la sensibilité aux variations de prix',
        ],
      ),
    ];

    final batch = _firestore.batch();

    for (final summary in testSummaries) {
      final model = SummaryModel.fromDomain(summary);
      final docRef = _firestore.collection('global_summaries').doc(summary.id);
      batch.set(docRef, model.toFirestore());
    }

    await batch.commit();
    print('Successfully populated ${testSummaries.length} test summaries');
  }

  static Future<void> clearTestSummaries() async {
    final batch = _firestore.batch();

    // Clear global summaries
    final globalSummaries = await _firestore
        .collection('global_summaries')
        .where('id', whereIn: ['test_summary_newton', 'test_summary_psychology', 'test_summary_revolution', 'test_summary_photosynthesis', 'test_summary_due'])
        .get();

    for (final doc in globalSummaries.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    print('Successfully cleared test summaries');
  }
}
