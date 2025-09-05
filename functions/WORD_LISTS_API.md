# Firebase Functions for Dynamic Word Lists

This document describes the improved Firebase functions that use the trouve-mot.fr API to dynamically generate daily word lists.

## Features

### 1. Dynamic Word Generation

- Fetches words from trouve-mot.fr API instead of using static lists
- 27 different categories available
- Automatic word count adjustment based on category
- Proper French capitalization

### 2. Available Functions

#### `populateDailyWordLists` (HTTP)

**URL:** `https://your-project.cloudfunctions.net/populateDailyWordLists`
**Method:** GET/POST
**Description:** Manually populate daily word lists with fresh content from the API. **RESETS ALL EXISTING** active daily lists before creating new ones.

**Response:**

```json
{
  "success": true,
  "message": "Successfully reset and populated 5 daily word lists (deactivated 3 existing lists)",
  "lists": [
    {
      "id": "daily_animaux_1693980123456",
      "title": "LES ANIMAUX - 12 mots",
      "category": "ANIMAUX",
      "wordCount": 12,
      "difficulty": "Facile"
    }
  ]
}
```

#### `refreshDailyWordLists` (Scheduled)

**Schedule:** Daily at 6 AM UTC
**Description:** Automatically refreshes daily word lists by **DEACTIVATING ALL** current active lists and creating fresh ones. Ensures no accumulation of old lists.

#### `clearAllDailyWordLists` (HTTP)

**URL:** `https://your-project.cloudfunctions.net/clearAllDailyWordLists`
**Method:** GET/POST
**Description:** Manually clear/deactivate all active daily word lists without creating new ones

**Response:**

```json
{
  "success": true,
  "message": "Successfully cleared 5 daily word lists",
  "clearedCount": 5
}
```

#### `generateDailyWordLists` (Callable)

**Authentication:** Requires admin token
**Description:** Generate custom word lists with filters

**Parameters:**

```typescript
{
  category?: string,     // Filter by category name (e.g., "ANIMAUX", "ALIMENTS")
  difficulty?: string,   // Filter by difficulty ("Facile", "Moyen", "Difficile")
  count?: number        // Number of lists to generate (default: 5)
}
```

**Usage:**

```typescript
const functions = getFunctions();
const generateLists = httpsCallable(functions, "generateDailyWordLists");

const result = await generateLists({
  difficulty: "Facile",
  count: 3,
});
```

#### `getAvailableCategories` (Callable)

**Description:** Get all available categories with their metadata

**Response:**

```json
{
  "success": true,
  "categories": [
    {
      "id": 1,
      "name": "ÉCOLE",
      "frenchName": "L'ÉCOLE – LA CLASSE – L'INSTRUCTION",
      "difficulty": "Facile",
      "wordCount": 8
    }
  ]
}
```

#### `testTrouveMotAPI` (HTTP)

**URL:** `https://your-project.cloudfunctions.net/testTrouveMotAPI?categoryId=19&count=5`
**Description:** Test the API connection and see sample words

### 3. Categories Available

| ID  | Category      | French Name                            | Difficulty | Word Count |
| --- | ------------- | -------------------------------------- | ---------- | ---------- |
| 1   | ÉCOLE         | L'ÉCOLE – LA CLASSE – L'INSTRUCTION    | Facile     | 8          |
| 2   | PAYSAGES      | PAYSAGES – CLIMAT – FORMES             | Moyen      | 10         |
| 3   | QUALITÉS      | QUALITÉS ET DÉFAUTS                    | Moyen      | 12         |
| 4   | CALCUL        | CALCUL ET MESURES                      | Difficile  | 8          |
| 5   | ALIMENTS      | LES ALIMENTS – LES BOISSONS- LES REPAS | Facile     | 12         |
| 6   | CORPS         | LE CORPS HUMAIN                        | Moyen      | 10         |
| 7   | SENS          | LES SENS – LA VOLONTE – L'INTELLIGENCE | Difficile  | 15         |
| 8   | MOBILIER      | L'INTÉRIEUR ET LE MOBILIER             | Facile     | 12         |
| 9   | TRAVAIL       | L'INDUSTRIE ET LE TRAVAIL              | Moyen      | 10         |
| 10  | ARTS          | LES ARTS                               | Moyen      | 8          |
| 11  | AGRICULTURE   | L'AGRICULTURE                          | Moyen      | 10         |
| 12  | NATURE        | VERGER – BOIS – CHASSE - PÊCHE         | Moyen      | 12         |
| 13  | MOUVEMENTS    | GESTES ET MOUVEMENTS                   | Facile     | 10         |
| 14  | TEMPS         | ÉPOQUE – TEMPS - SAISONS               | Facile     | 8          |
| 15  | VÊTEMENTS     | VÊTEMENTS – TOILETTE - PARURES         | Facile     | 10         |
| 16  | SPORTS        | SPORTS ET JEUX                         | Facile     | 8          |
| 17  | MAISON        | LA MAISON – LE BATIMENT                | Moyen      | 10         |
| 18  | VOYAGES       | LES VOYAGES                            | Moyen      | 12         |
| 19  | ANIMAUX       | LES ANIMAUX                            | Facile     | 12         |
| 20  | VILLE         | VILLE – VILLAGE – UNIVERS - DIMENSIONS | Difficile  | 15         |
| 21  | ÉLÉMENTS      | EAUX – MINÉRAUX - VÉGÉTAUX             | Moyen      | 10         |
| 22  | COMMERCE      | LE COMMERCE                            | Moyen      | 10         |
| 23  | COMMUNICATION | LA COMMUNICATION                       | Moyen      | 8          |
| 24  | ÉMOTIONS      | JOIES ET PEINES                        | Moyen      | 8          |
| 25  | GOUVERNEMENT  | GOUVERNEMENT ET JUSTICE                | Difficile  | 12         |
| 26  | ARMÉE         | L'ARMÉE                                | Difficile  | 10         |
| 27  | SANTÉ         | VIE HUMAINE – MALADIES - HYGIÈNE       | Moyen      | 12         |

### 4. Error Handling

- API failures fallback to sample words (`Mot{categoryId}-1`, etc.)
- Individual category failures don't stop the entire process
- Comprehensive logging for debugging

### 5. Deployment

```bash
# Build the functions
npm run build

# Deploy to Firebase
firebase deploy --only functions

# Or deploy specific functions
firebase deploy --only functions:populateDailyWordLists,functions:refreshDailyWordLists
```

### 6. Usage Examples

#### Manual Population (Resets existing lists)

```bash
curl https://your-project.cloudfunctions.net/populateDailyWordLists
```

#### Clear All Daily Lists

```bash
curl https://your-project.cloudfunctions.net/clearAllDailyWordLists
```

#### Test API Connection

```bash
curl "https://your-project.cloudfunctions.net/testTrouveMotAPI?categoryId=19&count=5"
```

#### Generate Custom Lists (from app)

```typescript
const functions = getFunctions();
const generateLists = httpsCallable(functions, "generateDailyWordLists");

// Generate 3 easy lists
const easyLists = await generateLists({
  difficulty: "Facile",
  count: 3,
});

// Generate animal-related lists
const animalLists = await generateLists({
  category: "ANIMAUX",
  count: 2,
});
```

### 7. Migration Notes

- Old static word lists are replaced with dynamic API-based generation
- Categories are carefully mapped to appropriate difficulty levels
- Word counts are optimized for memory training (8-15 words per list)
- Automatic capitalization ensures consistent formatting
