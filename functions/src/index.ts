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

interface TrouveMotWord {
  name: string;
  categorie: string;
}

interface CategoryConfig {
  id: number;
  name: string;
  frenchName: string;
  wordCount: number;
  difficulty: 'Facile' | 'Moyen' | 'Difficile';
}

// Configuration for categories from trouve-mot.fr API
const categories: CategoryConfig[] = [
  { id: 1, name: 'ÉCOLE', frenchName: 'L\'ÉCOLE – LA CLASSE – L\'INSTRUCTION', wordCount: 8, difficulty: 'Facile' },
  { id: 2, name: 'PAYSAGES', frenchName: 'PAYSAGES – CLIMAT – FORMES', wordCount: 10, difficulty: 'Moyen' },
  { id: 3, name: 'QUALITÉS', frenchName: 'QUALITÉS ET DÉFAUTS', wordCount: 12, difficulty: 'Moyen' },
  { id: 4, name: 'CALCUL', frenchName: 'CALCUL ET MESURES', wordCount: 8, difficulty: 'Difficile' },
  { id: 5, name: 'ALIMENTS', frenchName: 'LES ALIMENTS – LES BOISSONS- LES REPAS', wordCount: 12, difficulty: 'Facile' },
  { id: 6, name: 'CORPS', frenchName: 'LE CORPS HUMAIN', wordCount: 10, difficulty: 'Moyen' },
  { id: 7, name: 'SENS', frenchName: 'LES SENS – LA VOLONTE – L\'INTELLIGENCE', wordCount: 15, difficulty: 'Difficile' },
  { id: 8, name: 'MOBILIER', frenchName: 'L\'INTÉRIEUR ET LE MOBILIER', wordCount: 12, difficulty: 'Facile' },
  { id: 9, name: 'TRAVAIL', frenchName: 'L\'INDUSTRIE ET LE TRAVAIL', wordCount: 10, difficulty: 'Moyen' },
  { id: 10, name: 'ARTS', frenchName: 'LES ARTS', wordCount: 8, difficulty: 'Moyen' },
  { id: 11, name: 'AGRICULTURE', frenchName: 'L\'AGRICULTURE', wordCount: 10, difficulty: 'Moyen' },
  { id: 12, name: 'NATURE', frenchName: 'VERGER – BOIS – CHASSE - PÊCHE', wordCount: 12, difficulty: 'Moyen' },
  { id: 13, name: 'MOUVEMENTS', frenchName: 'GESTES ET MOUVEMENTS', wordCount: 10, difficulty: 'Facile' },
  { id: 14, name: 'TEMPS', frenchName: 'ÉPOQUE – TEMPS - SAISONS', wordCount: 8, difficulty: 'Facile' },
  { id: 15, name: 'VÊTEMENTS', frenchName: 'VÊTEMENTS – TOILETTE - PARURES', wordCount: 10, difficulty: 'Facile' },
  { id: 16, name: 'SPORTS', frenchName: 'SPORTS ET JEUX', wordCount: 8, difficulty: 'Facile' },
  { id: 17, name: 'MAISON', frenchName: 'LA MAISON – LE BATIMENT', wordCount: 10, difficulty: 'Moyen' },
  { id: 18, name: 'VOYAGES', frenchName: 'LES VOYAGES', wordCount: 12, difficulty: 'Moyen' },
  { id: 19, name: 'ANIMAUX', frenchName: 'LES ANIMAUX', wordCount: 12, difficulty: 'Facile' },
  { id: 20, name: 'VILLE', frenchName: 'VILLE – VILLAGE – UNIVERS - DIMENSIONS', wordCount: 15, difficulty: 'Difficile' },
  { id: 21, name: 'ÉLÉMENTS', frenchName: 'EAUX – MINÉRAUX - VÉGÉTAUX', wordCount: 10, difficulty: 'Moyen' },
  { id: 22, name: 'COMMERCE', frenchName: 'LE COMMERCE', wordCount: 10, difficulty: 'Moyen' },
  { id: 23, name: 'COMMUNICATION', frenchName: 'LA COMMUNICATION', wordCount: 8, difficulty: 'Moyen' },
  { id: 24, name: 'ÉMOTIONS', frenchName: 'JOIES ET PEINES', wordCount: 8, difficulty: 'Moyen' },
  { id: 25, name: 'GOUVERNEMENT', frenchName: 'GOUVERNEMENT ET JUSTICE', wordCount: 12, difficulty: 'Difficile' },
  { id: 26, name: 'ARMÉE', frenchName: 'L\'ARMÉE', wordCount: 10, difficulty: 'Difficile' },
  { id: 27, name: 'SANTÉ', frenchName: 'VIE HUMAINE – MALADIES - HYGIÈNE', wordCount: 12, difficulty: 'Moyen' }
];

// Function to fetch words from trouve-mot.fr API
async function fetchWordsFromAPI(categoryId: number, count: number): Promise<string[]> {
  try {
    const response = await fetch(`https://trouve-mot.fr/api/categorie/${categoryId}/${count}`);
    
    if (!response.ok) {
      throw new Error(`API request failed with status ${response.status}`);
    }
    
    const data = await response.json() as TrouveMotWord[];
    return data.map(word => {
      // Capitalize first letter for consistency
      return word.name.charAt(0).toUpperCase() + word.name.slice(1).toLowerCase();
    });
  } catch (error) {
    console.error(`Error fetching words for category ${categoryId}:`, error);
    // Return fallback words if API fails
    return [`Mot${categoryId}-1`, `Mot${categoryId}-2`, `Mot${categoryId}-3`];
  }
}

// Function to generate a random selection of categories for daily lists
function getRandomCategories(count: number = 3): CategoryConfig[] {
  const shuffled = [...categories].sort(() => Math.random() - 0.5);
  return shuffled.slice(0, count);
}

// HTTP function to populate daily word lists using trouve-mot.fr API
export const populateDailyWordLists = functions.https.onRequest(async (req, res) => {
  try {
    const firestore = admin.firestore();
    const batch = firestore.batch();
    
    const now = new Date();
    
    // First, deactivate ALL current active daily word lists to reset them
    const currentActiveListsQuery = await firestore
      .collection('daily_word_lists')
      .where('isActive', '==', true)
      .get();
    
    console.log(`Deactivating ${currentActiveListsQuery.docs.length} existing active daily word lists`);
    
    currentActiveListsQuery.docs.forEach(doc => {
      batch.update(doc.ref, { isActive: false });
    });
    
    const selectedCategories = getRandomCategories(5); // Generate 5 different lists
    
    const wordLists: WordList[] = [];
    
    for (const category of selectedCategories) {
      try {
        const words = await fetchWordsFromAPI(category.id, category.wordCount);
        
        const wordList: WordList = {
          id: `daily_${category.name.toLowerCase()}_${now.getTime()}_${Math.random().toString(36).substr(2, 5)}`,
          title: `${category.frenchName} - ${words.length} mots`,
          words: words,
          difficulty: category.difficulty,
          category: category.name,
          isUserCreated: false,
          isActive: true,
          createdAt: now,
          nextReviewAt: new Date(now.getTime() + Math.random() * 24 * 60 * 60 * 1000), // Random time within 24h
          easiness: 2.5,
          interval: 1,
          reps: 0
        };
        
        wordLists.push(wordList);
        
        const docRef = firestore.collection('daily_word_lists').doc(wordList.id);
        batch.set(docRef, {
          ...wordList,
          createdAt: admin.firestore.Timestamp.fromDate(wordList.createdAt),
          nextReviewAt: admin.firestore.Timestamp.fromDate(wordList.nextReviewAt!)
        });
      } catch (error) {
        console.error(`Failed to create word list for category ${category.name}:`, error);
        // Continue with other categories even if one fails
      }
    }
    
    await batch.commit();
    
    res.json({ 
      success: true, 
      message: `Successfully reset and populated ${wordLists.length} daily word lists (deactivated ${currentActiveListsQuery.docs.length} existing lists)`,
      lists: wordLists.map(list => ({
        id: list.id,
        title: list.title,
        category: list.category,
        wordCount: list.words.length,
        difficulty: list.difficulty
      }))
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
      
      // Deactivate ALL current active daily word lists to reset them completely
      const currentActiveListsQuery = await firestore
        .collection('daily_word_lists')
        .where('isActive', '==', true)
        .get();
      
      const batch = firestore.batch();
      
      console.log(`Deactivating ${currentActiveListsQuery.docs.length} existing active daily word lists`);
      
      currentActiveListsQuery.docs.forEach(doc => {
        batch.update(doc.ref, { isActive: false });
      });
      
      // Generate new daily word lists using the API
      const today = new Date();
      
      // Select 3-4 different categories for variety
      const selectedCategories = getRandomCategories(4);
      
      const createdLists: string[] = [];
      
      for (const category of selectedCategories) {
        try {
          const words = await fetchWordsFromAPI(category.id, category.wordCount);
          
          const wordList: WordList = {
            id: `daily_${category.name.toLowerCase()}_${today.getTime()}_${Math.random().toString(36).substr(2, 5)}`,
            title: `${category.frenchName} - ${words.length} mots`,
            words: words,
            difficulty: category.difficulty,
            category: category.name,
            isUserCreated: false,
            isActive: true,
            createdAt: today,
            nextReviewAt: new Date(today.getTime() + Math.random() * 12 * 60 * 60 * 1000), // Random time within 12h
            easiness: 2.5,
            interval: 1,
            reps: 0
          };
          
          const docRef = firestore.collection('daily_word_lists').doc(wordList.id);
          batch.set(docRef, {
            ...wordList,
            createdAt: admin.firestore.Timestamp.fromDate(wordList.createdAt),
            nextReviewAt: admin.firestore.Timestamp.fromDate(wordList.nextReviewAt!)
          });
          
          createdLists.push(`${category.name} (${words.length} mots)`);
        } catch (error) {
          console.error(`Failed to create word list for category ${category.name}:`, error);
          // Continue with other categories even if one fails
        }
      }
      
      await batch.commit();
      
      console.log(`Successfully refreshed daily word lists. Deactivated ${currentActiveListsQuery.docs.length} existing lists. Created ${createdLists.length} new lists: ${createdLists.join(', ')}`);
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
    
    let selectedCategories: CategoryConfig[] = [];
    
    // Filter categories based on request
    if (category) {
      selectedCategories = categories.filter(cat => 
        cat.name.toLowerCase().includes(category.toLowerCase()) ||
        cat.frenchName.toLowerCase().includes(category.toLowerCase())
      );
    }
    
    if (difficulty) {
      selectedCategories = selectedCategories.length > 0 
        ? selectedCategories.filter(cat => cat.difficulty === difficulty)
        : categories.filter(cat => cat.difficulty === difficulty);
    }
    
    // If no filters applied or no matches, use random selection
    if (selectedCategories.length === 0) {
      selectedCategories = getRandomCategories(count || 5);
    } else {
      // Limit to requested count
      selectedCategories = selectedCategories.slice(0, count || 5);
    }
    
    const generatedWordLists: Partial<WordList>[] = [];
    
    for (const categoryConfig of selectedCategories) {
      try {
        const words = await fetchWordsFromAPI(categoryConfig.id, categoryConfig.wordCount);
        
        const wordList: Partial<WordList> = {
          id: `generated_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
          title: `${categoryConfig.frenchName} - ${words.length} mots`,
          words: words,
          difficulty: categoryConfig.difficulty,
          category: categoryConfig.name,
          isUserCreated: false,
          isActive: true,
          easiness: 2.5,
          interval: 1,
          reps: 0
        };
        
        generatedWordLists.push(wordList);
      } catch (error) {
        console.error(`Failed to generate word list for category ${categoryConfig.name}:`, error);
        // Continue with other categories even if one fails
      }
    }
    
    return { 
      success: true, 
      wordLists: generatedWordLists,
      message: `Generated ${generatedWordLists.length} word lists`
    };
  } catch (error) {
    console.error('Error generating word lists:', error);
    throw new functions.https.HttpsError('internal', 'Failed to generate word lists');
  }
});

// Additional function to get available categories
export const getAvailableCategories = functions.https.onCall(async (data, context) => {
  try {
    return {
      success: true,
      categories: categories.map(cat => ({
        id: cat.id,
        name: cat.name,
        frenchName: cat.frenchName,
        difficulty: cat.difficulty,
        wordCount: cat.wordCount
      }))
    };
  } catch (error) {
    console.error('Error getting categories:', error);
    throw new functions.https.HttpsError('internal', 'Failed to get categories');
  }
});

// Function to test the API connection
export const testTrouveMotAPI = functions.https.onRequest(async (req, res) => {
  try {
    const categoryId = parseInt(req.query.categoryId as string) || 19; // Default to animals
    const count = parseInt(req.query.count as string) || 5;
    
    const words = await fetchWordsFromAPI(categoryId, count);
    const category = categories.find(cat => cat.id === categoryId);
    
    res.json({
      success: true,
      category: category?.frenchName || 'Unknown',
      requestedCount: count,
      actualCount: words.length,
      words: words
    });
  } catch (error) {
    console.error('Error testing API:', error);
    res.status(500).json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Function to clear all daily word lists
export const clearAllDailyWordLists = functions.https.onRequest(async (req, res) => {
  try {
    const firestore = admin.firestore();
    
    // Get all active daily word lists
    const activeListsQuery = await firestore
      .collection('daily_word_lists')
      .where('isActive', '==', true)
      .get();
    
    if (activeListsQuery.empty) {
      res.json({
        success: true,
        message: 'No active daily word lists to clear',
        clearedCount: 0
      });
      return;
    }
    
    const batch = firestore.batch();
    
    activeListsQuery.docs.forEach(doc => {
      batch.update(doc.ref, { isActive: false });
    });
    
    await batch.commit();
    
    res.json({
      success: true,
      message: `Successfully cleared ${activeListsQuery.docs.length} daily word lists`,
      clearedCount: activeListsQuery.docs.length
    });
  } catch (error) {
    console.error('Error clearing daily word lists:', error);
    res.status(500).json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});
