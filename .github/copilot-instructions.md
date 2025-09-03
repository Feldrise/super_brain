# GitHub Copilot Instructions for **SuperBrain** (Flutter + Firebase)

## Project Overview

**SuperBrain** helps users improve memory and cognitive well-being through a daily **Home** hub (Tip of the Day, Words to remember), a **Reminder** space for **course summaries** with **spaced repetition**, and a **Morning Routine** (dream journal, daily journal, guided breathing, short training sessions).

**Primary goals (MVP)**

- Frictionless onboarding (Email/Google/Apple).
- Daily habit loop: Home → Morning routine → Quick review.
- Simple content model: tips, words, summaries, journals.
- Push notifications for reminders + routines.

---

## Tech Stack & Principles

- **Flutter** (Material 3, adaptive layouts).
- **Firebase**: Auth, Firestore, Cloud Functions, FCM, Storage, Crashlytics, Analytics, Remote Config.
- **State mgmt**: Riverpod (providers for services, repositories, viewmodels).
- **Routing**: GoRouter.
- **Models**: Freezed + json_serializable.
- **Offline-first**: Firestore cache; local drafts via Hive for journals (sync on network).
- **Clean Architecture + Feature-first** module layout (mirrors your previous doc).&#x20;

---

## Project Structure

```
superbrain/
├─ lib/
│  ├─ main.dart
│  ├─ core/
│  │  ├─ app_env.dart           # Firebase env keys, toggles
│  │  ├─ errors/                # Failure, exceptions, error mapper
│  │  ├─ services/              # Auth, Firestore, Storage, Messaging, Analytics
│  │  ├─ utils/                 # Date, formatters, timeboxing, breathing helpers
│  │  └─ widgets/               # AppShell, AppScaffold, Common UI
│  ├─ theme/                    # M3 theme, colors, typography
│  ├─ features/
│  │  ├─ auth/
│  │  ├─ home/                  # Tip of day, quick stats, shortcuts
│  │  ├─ tips/
│  │  ├─ words/                 # word lists, study sessions
│  │  ├─ reminder/              # course summaries, spaced repetition
│  │  ├─ morning/
│  │  │  ├─ journal/            # dreams & daily entries
│  │  │  ├─ breath/             # guided breathing
│  │  │  └─ training/           # cardio/muscle/yoga mini-sets
│  │  ├─ profile/
│  │  └─ navigation/
│  └─ app.dart                  # Router + Shell
├─ assets/ (images, lottie, fonts)
├─ test/
└─ pubspec.yaml
```

### Feature Module Layout

```
features/<feature_name>/
├─ data/        # models, dto, repositories impl (Firestore)
├─ domain/      # entities, value objects, repository interfaces, usecases
└─ presentation/# pages, widgets, controllers, providers (Riverpod)
```

_(Keeps clear separation of concerns like your Hello Workspace guide.)_&#x20;

---

## Firestore Data Model (MVP)

Collections (prefix with `users/{uid}/` where noted):

- `users` (root): `{ displayName, email, photoURL, createdAt, streakCount, lastActiveAt, routineConfig }`
- `tips` (global, curated): `{ id, text, category, locale, weight, active }`
- `users/{uid}/words`: `{ id, term, meaning, tags[], createdAt, nextReviewAt, easiness, interval, reps }`
- `users/{uid}/summaries`: `{ id, title, body (md), tags[], createdAt, nextReviewAt, srsMeta }`
- `users/{uid}/journals`: `{ id, type: "dream"|"daily", content, mood?, createdAt }`
- `users/{uid}/breath_sessions`: `{ id, pattern:"coherence|4-7-8|box", durationSec, completedAt }`
- `users/{uid}/training_sessions`: `{ id, kind:"cardio|strength|yoga", planId?, durationSec, completedAt }`
- `scheduled_notifications` (service): `{ uid, type, payload, scheduledFor, status }`

Indexes to create:

- `users/{uid}/words` on `nextReviewAt` (ASC) where `nextReviewAt <= now()`
- `users/{uid}/summaries` on `nextReviewAt` (ASC)
- `tips` on `active==true`, `locale`

---

## Authentication

- **Firebase Auth** with **Email/Password**, **Google**, **Apple**.
- Store minimal profile in `users/{uid}` on first login.
- Riverpod `authStateProvider` exposes `AsyncValue<User?>`.

```dart
final firebaseAuthProvider = Provider((_) => FirebaseAuth.instance);
final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
);
```

---

## Routing (GoRouter)

- Shell with bottom navigation: `/home`, `/reminder`, `/morning`, `/profile`.
- Deep links: `/reminder/summary/:id`, `/words/study`, `/morning/breath/:pattern`.

```dart
final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (ctx, st, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomePage()),
        GoRoute(path: '/reminder', builder: (_, __) => const ReminderPage(), routes: [
          GoRoute(path: 'summary/:id', builder: (c,s)=> SummaryDetailPage(id: s.pathParameters['id']!)),
        ]),
        GoRoute(path: '/morning', builder: (_, __) => const MorningHubPage()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
      ],
    ),
  ],
);
```

---

## State Management (Riverpod)

- **Service providers** for Auth, Firestore, Messaging, Analytics.
- **Repository providers** per feature (wordsRepository, summariesRepository…).
- **ViewModel** (StateNotifier) per screen for load/save/submit/complete.

```dart
final wordsDueProvider = StreamProvider.autoDispose((ref) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return const Stream.empty();
  final fs = ref.watch(firestoreProvider);
  return fs.collection('users/$uid/words')
      .where('nextReviewAt', isLessThanOrEqualTo: Timestamp.now())
      .orderBy('nextReviewAt')
      .limit(50)
      .snapshots()
      .map((snap) => snap.docs.map((d)=> Word.fromJson(d.data())).toList());
});
```

---

## Repetition Spacée (SRS) – Words & Summaries

- Use SM-2 inspired fields: `easiness`, `interval`, `reps`, `nextReviewAt`.
- Update SRS after each review (quality 0-5).
- Show **Study Session** that pulls next due items.

```dart
@freezed
class Word with _$Word {
  const factory Word({
    required String id,
    required String term,
    required String meaning,
    @Default([]) List<String> tags,
    DateTime? nextReviewAt,
    @Default(2.5) double easiness,
    @Default(1) int interval,
    @Default(0) int reps,
    required DateTime createdAt,
  }) = _Word;
  factory Word.fromJson(Map<String,dynamic> json)=> _$WordFromJson(json);
}
```

---

## Morning Routine

- **Dream Journal** & **Daily Journal** (markdown/plaintext, local draft → Firestore).
- **Breathing** patterns (coherence 5-5, 4-7-8, box 4-4-4-4), simple inhale/exhale animation + timer.
- **Training**: minimal predefined plans (JSON asset). Track duration + completion.

```dart
final breathingPatternProvider = Provider<BreathPattern>((_) => BreathPattern.coherence());
class BreathPattern { final int inhale, hold, exhale, hold2; /* … */ }
```

---

## Notifications (FCM)

- User opts in to:

  - **Morning ping** (journal + breathing).
  - **Reviews due** (words/summaries).
  - **Tip of the day**.

- Use **Cloud Functions** to schedule notifications.

**Cloud Functions (TypeScript) sketch:**

```ts
export const scheduleDaily = pubsub.schedule("every day 06:30").onRun(async () => {
  const users = await db.collection("users").get();
  for (const u of users.docs) {
    const token = u.get("fcmToken");
    if (!token) continue;
    await messaging.send({ token, notification: { title: "SuperBrain", body: "Morning routine is ready." } });
  }
});
```

---

## Tips of the Day

- Server-curated `tips` with `active==true`, weighted random by `weight` and `locale`.
- Cache last shown tip per user to avoid repeats within X days.
- Remote Config toggles (e.g., feature flags for new tip categories).

---

## Theming & UX

- Material 3, light/dark themes.
- Typography: readable sizes, large tap targets, high contrast.
- Reusable widgets: `AppCard`, `AppButton`, `SectionHeader`, `EmptyState`, `ErrorView`.

---

## Error Handling & Analytics

- All async → `AsyncValue` surfaced in UI (loading, error).
- Log to **Crashlytics**; events to **Analytics** (session_complete, review_done, breath_completed).
- Graceful degradation offline (journals, study queue).

---

## Testing

- **Unit**: SRS calculator, repositories.
- **Widget**: HomePage, StudySession flow.
- **Golden**: key cards & tiles.
- **Integration**: Auth + Firestore read/write (use emulator suite).

---

## Commands & Tooling

```bash
# Setup
flutter pub get
dart run build_runner build -d

# Firebase emulators (auth, firestore, functions)
firebase emulators:start

# Run
flutter run

# Tests
flutter test
```

---

## Copilot Behavior Hints (what to suggest by default)

- Prefer **Riverpod** providers and **StateNotifier** for view models.
- Use **Freezed** models with `fromJson/toJson`.
- Write Firestore code with **converters** and **indexed** queries.
- For study sessions, propose **SM-2 updates** (easiness/interval/nextReviewAt).
- For breathing, generate **simple Tween animation** with `AnimationController`.
- For training, suggest **time-boxed** circuits from local JSON assets.
- For notifications, suggest **FCM token handling** and **Functions** scheduling.
- Use **const constructors**, `LayoutBuilder`, and `MediaQuery` for responsive UI.
- Follow Material 3 and accessibility best practices (semantics, large targets).

---

## Example Firestore Repository Snippet

```dart
class WordsRepository {
  WordsRepository(this._fs, this._uid);
  final FirebaseFirestore _fs;
  final String _uid;

  CollectionReference<Word> get _col => _fs
    .collection('users/$_uid/words')
    .withConverter<Word>(
      fromFirestore: (s,_) => Word.fromJson(s.data()!..['id']=s.id),
      toFirestore: (w,_) => w.toJson()..remove('id'),
    );

  Stream<List<Word>> dueWords() => _col
    .where('nextReviewAt', isLessThanOrEqualTo: Timestamp.now())
    .orderBy('nextReviewAt').limit(50)
    .snapshots().map((q)=>q.docs.map((d)=>d.data()).toList());

  Future<void> upsert(Word w) => _col.doc(w.id).set(w);
}
```

---

## Delivery Phases (for Copilot context)

1. **MVP A**: Auth, Home (tip), Morning (journals + breathing), basic profile.
2. **MVP B**: Words + Study sessions (SRS), reminders + FCM.
3. **MVP C**: Summaries library + spaced repetition, stats & streaks.
4. **Post-MVP**: Training presets, gamification, insights, widgets.
