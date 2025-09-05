import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

interface WordList {
  id: string;
  title: string;
  words: string[];
  difficulty: string;
  category?: string;
  isUserCreated: boolean;
  isActive: boolean;
  createdAt: Date;
  nextReviewAt?: Date;
  easiness: number;
  interval: number;
  reps: number;
}

// Sample daily word lists data
const dailyWordLists: Omit<WordList, 'createdAt' | 'nextReviewAt'>[] = [
  {
    id: 'daily_animals_1',
    title: 'Animaux sauvages - 10 mots',
    words: [
      'Éléphant', 'Girafe', 'Lion', 'Tigre', 'Rhinocéros',
      'Hippopotame', 'Crocodile', 'Zèbre', 'Antilope', 'Léopard'
    ],
    difficulty: 'Facile',
    category: 'Animaux',
    isUserCreated: false,
    isActive: true,
    easiness: 2.5,
    interval: 1,
    reps: 0
  },
  {
    id: 'daily_objects_1',
    title: 'Objets quotidiens - 12 mots',
    words: [
      'Fourchette', 'Couteau', 'Cuillère', 'Assiette', 'Verre', 'Tasse',
      'Serviette', 'Nappe', 'Bougie', 'Vase', 'Miroir', 'Peigne'
    ],
    difficulty: 'Moyen',
    category: 'Objets quotidiens',
    isUserCreated: false,
    isActive: true,
    easiness: 2.5,
    interval: 1,
    reps: 0
  },
  {
    id: 'daily_emotions_1',
    title: 'Émotions et sentiments - 8 mots',
    words: [
      'Joie', 'Tristesse', 'Colère', 'Peur',
      'Surprise', 'Dégoût', 'Amour', 'Haine'
    ],
    difficulty: 'Difficile',
    category: 'Émotions',
    isUserCreated: false,
    isActive: true,
    easiness: 2.5,
    interval: 1,
    reps: 0
  },
  {
    id: 'daily_colors_1',
    title: 'Couleurs - 15 mots',
    words: [
      'Rouge', 'Bleu', 'Vert', 'Jaune', 'Orange', 'Violet', 'Rose',
      'Noir', 'Blanc', 'Gris', 'Marron', 'Turquoise', 'Magenta', 'Cyan', 'Indigo'
    ],
    difficulty: 'Facile',
    category: 'Couleurs',
    isUserCreated: false,
    isActive: true,
    easiness: 2.5,
    interval: 1,
    reps: 0
  },
  {
    id: 'daily_nature_1',
    title: 'Éléments de la nature - 10 mots',
    words: [
      'Montagne', 'Rivière', 'Forêt', 'Océan', 'Désert',
      'Prairie', 'Volcan', 'Cascade', 'Lac', 'Colline'
    ],
    difficulty: 'Moyen',
    category: 'Nature',
    isUserCreated: false,
    isActive: true,
    easiness: 2.5,
    interval: 1,
    reps: 0
  },
  {
    id: 'daily_actions_1',
    title: 'Actions du quotidien - 12 mots',
    words: [
      'Marcher', 'Courir', 'Sauter', 'Nager', 'Voler', 'Danser',
      'Chanter', 'Lire', 'Écrire', 'Dessiner', 'Cuisiner', 'Nettoyer'
    ],
    difficulty: 'Moyen',
    category: 'Actions',
    isUserCreated: false,
    isActive: true,
    easiness: 2.5,
    interval: 1,
    reps: 0
  },
  {
    id: 'daily_food_1',
    title: 'Fruits et légumes - 14 mots',
    words: [
      'Pomme', 'Banane', 'Orange', 'Fraise', 'Raisin', 'Ananas', 'Mangue',
      'Carotte', 'Tomate', 'Salade', 'Brocoli', 'Épinard', 'Courgette', 'Aubergine'
    ],
    difficulty: 'Facile',
    category: 'Nourriture',
    isUserCreated: false,
    isActive: true,
    easiness: 2.5,
    interval: 1,
    reps: 0
  }
];

// HTTP function to populate daily word lists
export const populateDailyWordLists = functions.https.onRequest(async (req, res) => {
  try {
    const firestore = admin.firestore();
    const batch = firestore.batch();
    
    const now = new Date();
    
    for (const wordListData of dailyWordLists) {
      const wordList: WordList = {
        ...wordListData,
        createdAt: now,
        nextReviewAt: new Date(now.getTime() + Math.random() * 24 * 60 * 60 * 1000) // Random time within 24h
      };
      
      const docRef = firestore.collection('daily_word_lists').doc(wordList.id);
      batch.set(docRef, {
        ...wordList,
        createdAt: admin.firestore.Timestamp.fromDate(wordList.createdAt),
        nextReviewAt: admin.firestore.Timestamp.fromDate(wordList.nextReviewAt!)
      });
    }
    
    await batch.commit();
    
    res.json({ 
      success: true, 
      message: `Successfully populated ${dailyWordLists.length} daily word lists` 
    });
  } catch (error) {
    console.error('Error populating daily word lists:', error);
    res.status(500).json({ 
      success: false, 
      error: error instanceof Error ? error.message : 'Unknown error' 
    });
  }
});

// Scheduled function to refresh daily word lists (runs daily at 6 AM UTC)
export const refreshDailyWordLists = functions.pubsub.schedule('0 6 * * *')
  .timeZone('UTC')
  .onRun(async (context) => {
    try {
      const firestore = admin.firestore();
      
      // Deactivate old daily word lists
      const oldListsQuery = await firestore
        .collection('daily_word_lists')
        .where('isActive', '==', true)
        .where('createdAt', '<', admin.firestore.Timestamp.fromDate(
          new Date(Date.now() - 7 * 24 * 60 * 60 * 1000) // 7 days ago
        ))
        .get();
      
      const batch = firestore.batch();
      
      oldListsQuery.docs.forEach(doc => {
        batch.update(doc.ref, { isActive: false });
      });
      
      // Add new daily word lists (rotate or add new content)
      const today = new Date();
      const dayOfYear = Math.floor((today.getTime() - new Date(today.getFullYear(), 0, 0).getTime()) / (1000 * 60 * 60 * 24));
      
      // Select a subset of word lists based on day of year for rotation
      const selectedLists = dailyWordLists.filter((_, index) => 
        (index + dayOfYear) % dailyWordLists.length < 3 // Show 3 lists per day
      );
      
      for (const wordListData of selectedLists) {
        const wordList: WordList = {
          ...wordListData,
          id: `${wordListData.id}_${today.getTime()}`, // Make unique
          createdAt: today,
          nextReviewAt: new Date(today.getTime() + Math.random() * 12 * 60 * 60 * 1000) // Random time within 12h
        };
        
        const docRef = firestore.collection('daily_word_lists').doc(wordList.id);
        batch.set(docRef, {
          ...wordList,
          createdAt: admin.firestore.Timestamp.fromDate(wordList.createdAt),
          nextReviewAt: admin.firestore.Timestamp.fromDate(wordList.nextReviewAt!)
        });
      }
      
      await batch.commit();
      
      console.log(`Successfully refreshed daily word lists. Added ${selectedLists.length} new lists.`);
    } catch (error) {
      console.error('Error refreshing daily word lists:', error);
      throw error;
    }
  });

// Function to generate new word list combinations
export const generateDailyWordLists = functions.https.onCall(async (data, context) => {
  // Verify admin authentication (optional)
  if (!context.auth || !context.auth.token.admin) {
    throw new functions.https.HttpsError('permission-denied', 'Must be an admin to generate word lists');
  }
  
  try {
    const { category, difficulty, count } = data;
    
    // This would contain logic to generate new word lists
    // For now, return the existing ones
    const wordLists = dailyWordLists
      .filter(list => !category || list.category === category)
      .filter(list => !difficulty || list.difficulty === difficulty)
      .slice(0, count || 5);
    
    return { 
      success: true, 
      wordLists: wordLists.map(list => ({
        ...list,
        id: `generated_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`
      }))
    };
  } catch (error) {
    console.error('Error generating word lists:', error);
    throw new functions.https.HttpsError('internal', 'Failed to generate word lists');
  }
});
