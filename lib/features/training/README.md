# Training Feature

The Training feature provides short, time-boxed exercise sessions that users can complete as part of their morning routine or throughout the day.

## Architecture

The feature follows Clean Architecture principles with clear separation between Domain, Data, and Presentation layers.

### Domain Layer

- **Entities**: Core business objects (TrainingPlan, Exercise, TrainingSession, etc.)
- **Repositories**: Abstract interfaces for data access
- **Use Cases**: Business logic for training operations

### Data Layer

- **Models**: Data transfer objects that extend domain entities
- **Repositories**: Concrete implementations of domain repositories
- **Data Sources**: Local (JSON assets) and Remote (Firestore) data sources

### Presentation Layer

- **Pages**: Main UI screens (TrainingHubPage, TrainingSessionPage)
- **Widgets**: Reusable UI components
- **Controllers**: Riverpod providers for state management

## Core Features

### Training Categories

1. **Cardio** - Heart rate boosting exercises
2. **Strength** - Bodyweight strength exercises
3. **Yoga** - Stretching and mindfulness

### Session Structure

- **Duration Options**: 5, 10, or 15-minute sessions
- **Exercise Types**:
  - Timed exercises (e.g., plank for 30s)
  - Rep-based exercises (e.g., 10 push-ups)
  - Rest periods between exercises
- **Difficulty Levels**: Beginner, Intermediate, Advanced

### User Experience

1. **Training Hub**: Browse plans, view stats, quick start options
2. **Session Execution**: Step-by-step exercise guidance with timer
3. **Progress Tracking**: Session history, streaks, achievements

### Data Tracking

- Session completion and performance
- User statistics and streaks
- Achievement system with unlockable badges
- Category-based progress tracking

## File Structure

```
lib/features/training/
├── domain/
│   ├── entities/
│   │   └── training_entities.dart
│   ├── repositories/
│   │   └── training_repository.dart
│   └── usecases/
│       └── training_usecases.dart
├── data/
│   ├── models/
│   │   └── training_models.dart
│   ├── repositories/
│   │   └── training_repository_impl.dart
│   └── datasources/
│       ├── training_plans_datasource.dart
│       └── training_firestore_datasource.dart
├── presentation/
│   ├── pages/
│   │   ├── training_hub_page.dart
│   │   └── training_session_page.dart
│   ├── widgets/
│   │   ├── training_plan_card.dart
│   │   └── training_stats_card.dart
│   ├── controllers/
│   │   └── training_controllers.dart
│   └── providers/
│       └── training_providers.dart
└── training.dart
```

## Usage

### Basic Navigation

```dart
// Navigate to training hub
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const TrainingHubPage()),
);

// Start a specific training plan
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TrainingSessionPage(plan: trainingPlan),
  ),
);
```

### State Management

```dart
// Watch user training stats
final statsAsync = ref.watch(userTrainingStatsProvider(userId));

// Watch training plans
final plansAsync = ref.watch(trainingPlansProvider);

// Control active training session
ref.read(activeTrainingSessionProvider.notifier).startSession(userId, plan);
```

### Adding New Training Plans

Training plans can be added in two ways:

1. **JSON Assets** (for default/built-in plans):

   - Add to `assets/data/training_plans.json`
   - Plans are cached locally for offline access

2. **Firestore** (for dynamic plans):
   - Store in `/training_plans` collection
   - Can be updated remotely without app updates

## Data Models

### TrainingPlan

- Contains metadata and list of exercises
- Categorized by type and difficulty
- Includes estimated duration and tags

### Exercise

- Supports timed, rep-based, and rest exercises
- Includes instructions and equipment requirements
- Tracks muscle groups targeted

### TrainingSession

- Records user's actual performance
- Tracks completion time and exercise results
- Supports rating and notes

### TrainingStats

- Aggregates user progress data
- Tracks streaks, totals, and achievements
- Provides category-based breakdowns

## Achievements System

Achievements are automatically unlocked based on user activity:

- First session completion
- Streak milestones (3, 7, 30 days)
- Total session counts (10, 50, 100)
- Category variety (trying different types)
- Time investment milestones

## Integration with SuperBrain

The training feature integrates with the broader SuperBrain ecosystem:

- Contributes to daily habit tracking
- Supports morning routine integration
- Provides quick-start options for routine workflows
- Syncs progress with user profile data

## Future Enhancements

Potential improvements include:

- Video demonstrations for exercises
- Custom workout creation
- Social features and challenges
- Wearable device integration
- Advanced progress analytics
- Personalized plan recommendations
