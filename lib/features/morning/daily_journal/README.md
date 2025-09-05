# Daily Journal Feature

## Overview

The Daily Journal is a morning routine feature within SuperBrain that allows users to record their daily thoughts, gratitude, goals, and reflections. It's designed to promote mindfulness, goal-setting, and personal growth as part of the user's morning routine.

## Features Implemented

### Core Functionality

- ✅ **Daily Entry Creation**: Users can create one journal entry per day with rich content
- ✅ **Daily Entry Editing**: Edit existing journal entries
- ✅ **Daily Entry Deletion**: Remove unwanted journal entries
- ✅ **Search Functionality**: Search through journal entries by content, gratitude, goals, and reflections

### Morning Journal Structure

- ✅ **Main Content**: Free-form journaling with helpful prompts
- ✅ **Mood Tracking**: 8 different mood options for the morning (Excellent, Good, Neutral, Tired, Stressed, Anxious, Sad, Energetic)
- ✅ **Gratitude List**: Multiple gratitude entries to cultivate positive thinking
- ✅ **Daily Goals**: Set specific goals and intentions for the day
- ✅ **Personal Reflection**: Additional space for deeper thoughts and insights

### User Experience

- ✅ **Morning Prompts**: Pre-written prompts to help users start journaling
- ✅ **Date Selection**: Choose specific dates for journal entries
- ✅ **Streak Tracking**: Track consecutive days of journaling to build habits
- ✅ **Today's Status**: Quick view of whether today's entry is completed
- ✅ **Offline-First**: Data stored in Firestore for persistence and sync

## Architecture

### Clean Architecture Pattern

```
Domain Layer:
├── entities/daily_entry.dart          # Core business models with mood enum and prompts
├── repositories/                      # Abstract repository contracts
└── usecases/                         # Business logic use cases (CRUD + streak tracking)

Data Layer:
└── repositories/                     # Firestore implementation with date-based queries

Presentation Layer:
├── pages/                           # Daily journal list and entry form pages
├── providers/                       # Riverpod state management
└── widgets/                        # Reusable UI components (cards, stats, empty states)
```

### Key Technologies

- **State Management**: Riverpod with StateNotifier pattern
- **Data Persistence**: Cloud Firestore with user-scoped collections
- **Code Generation**: Freezed for immutable data classes
- **Navigation**: Integrated with existing app navigation

## Usage

### From Morning Routine

1. Navigate to "Routine Matinale" from home screen
2. Tap on "Journal quotidien" card (shows completion status)
3. Create new entries with the floating action button

### Daily Entry Process

1. **Date Selection**: Choose the date for the entry (defaults to today)
2. **Main Content**: Describe thoughts and feelings (required field)
3. **Quick Prompts**: Use suggested prompts for inspiration
4. **Mood Selection**: Choose morning emotional state
5. **Gratitude**: List things you're grateful for (one per line)
6. **Daily Goals**: Set intentions and objectives for the day
7. **Reflection**: Additional personal insights and thoughts

### Search & Organization

- Use the search icon to find entries by keywords
- Search across all content: main text, gratitude, goals, and reflections
- Browse chronologically organized entry list
- View detailed statistics and streak information

## Data Model

```dart
@freezed
class DailyEntry with _$DailyEntry {
  const factory DailyEntry({
    required String id,
    required String content,           // Main journal content
    String? mood,                      // Selected morning mood
    @Default([]) List<String> gratitudeList,     // List of gratitude items
    @Default([]) List<String> goalsForToday,     // Daily goals and intentions
    String? reflection,                // Additional personal reflection
    required DateTime entryDate,      // Date of the journal entry
    required DateTime createdAt,      // When the entry was created
    DateTime? updatedAt,              // When the entry was last updated
    @Default(false) bool isSynced,    // Sync status
  }) = _DailyEntry;
}
```

### Morning Moods Available

- 😄 Excellent
- 😊 Bien (Good)
- 😐 Neutre (Neutral)
- 😴 Fatigué (Tired)
- 😰 Stressé (Stressed)
- 😟 Anxieux (Anxious)
- 😢 Triste (Sad)
- ⚡ Énergique (Energetic)

## Future Enhancements

### Analytics & Insights

- Mood pattern analysis over time
- Goal completion tracking
- Personal growth metrics
- Weekly/monthly summaries

### Enhanced Features

- Export entries to PDF/markdown
- Voice-to-text for quick entry
- Photo attachments
- Reminder notifications for journaling
- Integration with other wellness features

### Social Features

- Optional sharing with privacy controls
- Goal accountability with friends
- Inspirational quotes and prompts

## Technical Notes

### Firestore Structure

```
users/{userId}/daily_entries/{entryId}
```

### Key Features

- **One entry per day**: Users can only have one entry per date
- **Auto-date detection**: New entries default to today's date
- **Streak calculation**: Counts consecutive days with entries
- **Rich search**: Searches across all text fields including lists
- **Offline support**: Firestore handles offline/online sync automatically

### Integration

The Daily Journal integrates seamlessly with the Morning Routine and shows completion status on the main morning page. The feature follows the same patterns as the existing Dream Journal for consistency.
