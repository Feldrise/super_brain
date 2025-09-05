# Firebase Setup for Words Feature

## Step 1: Deploy Firestore Rules and Indexes

First, deploy the Firestore configuration:

```bash
# Make sure you're logged in to Firebase
firebase login

# Deploy Firestore rules and indexes
firebase deploy --only firestore
```

## Step 2: Populate Test Data

You have two options:

### Option A: Use the Test Data Service (in app)

In your Flutter app, you can call:

```dart
import 'package:super_brain/core/services/test_data_service.dart';

// Somewhere in your app initialization or debug screen
await TestDataService.populateTestWordLists();
```

### Option B: Use Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: `superbrain-feldrise`
3. Go to Firestore Database
4. Create the following collection structure:

```
daily_word_lists/
  └── sample_animals/
      ├── id: "sample_animals"
      ├── title: "Animaux sauvages - 10 mots"
      ├── words: ["Éléphant", "Girafe", "Lion", "Tigre", "Rhinocéros", "Hippopotame", "Crocodile", "Zèbre", "Antilope", "Léopard"]
      ├── difficulty: "Facile"
      ├── category: "Animaux"
      ├── isUserCreated: false
      ├── isActive: true
      ├── createdAt: [current timestamp]
      ├── nextReviewAt: [timestamp 1 hour from now]
      ├── easiness: 2.5
      ├── interval: 1
      └── reps: 0
```

### Option C: Deploy and Use Cloud Functions

1. Setup Cloud Functions:

```bash
cd functions
npm install
npm run build
firebase deploy --only functions
```

2. Call the population function:

```bash
# Replace [YOUR_REGION] with your Firebase region (e.g., us-central1)
curl -X POST https://[YOUR_REGION]-superbrain-feldrise.cloudfunctions.net/populateDailyWordLists
```

## Step 3: Test the Integration

1. Run your Flutter app
2. Navigate to the Reminder tab → Words Lists
3. You should see the word lists load from Firebase

## Troubleshooting

### Index Creation Errors

If you see errors about missing indexes, Firebase will show you the exact index creation URLs in the console. You can:

1. Copy the URL from the error message
2. Paste it in your browser to automatically create the index
3. Or add the indexes manually to `firestore.indexes.json`

### Common Indexes Needed

The queries in the app require these indexes:

1. **daily_word_lists collection**:

   - `isActive` (ascending) + `createdAt` (descending)

2. **users/{userId}/word_lists subcollection**:

   - `isActive` (ascending) + `createdAt` (descending)
   - `isActive` (ascending) + `nextReviewAt` (ascending)

3. **users/{userId}/study_sessions subcollection**:
   - `startedAt` (descending)

### Firestore Rules

The current rules allow:

- ✅ Authenticated users can read daily word lists
- ✅ Users can read/write their own word lists and study sessions
- ❌ Only admin/cloud functions can write daily word lists

## Debug the Providers

If the word lists still don't load, check the debug output in your Flutter console. Look for messages starting with:

- `🎯 allWordListsProvider:`
- `📚 dailyWordListsProvider:`
- `❌ Error in...`

The app will fall back to sample data if Firebase fails, so you should always see something.

## Current Provider Behavior

The `allWordListsProvider` will:

1. Try to fetch from Firebase daily_word_lists collection
2. If successful but empty, show sample data
3. If error occurs, show sample data
4. Log all steps for debugging

This ensures the UI always works while you set up Firebase.
