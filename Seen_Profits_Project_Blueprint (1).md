# Seen Profits — Complete Project Planning & Requirements Document

**Document type:** Product & Technical Blueprint
**Prepared for:** Business stakeholders + Flutter/Backend development team
**Status:** Draft v1.1 — contains items marked **TBD** requiring business/legal decisions before build
**Confirmed technical stack:** Flutter (BLoC) frontend, built on the BioTip-mobile-app boilerplate · Node.js REST API backend · MongoDB database · Admin Panel frontend TBD (Section 24)

---

## How to read this document

- Plain language sections explain *what* and *why* for non-technical stakeholders.
- Technical sections (schema, API, architecture) explain *how* for developers.
- Anything marked **TBD** is a decision this document intentionally does not make for you, because it depends on legal, financial, or business choices only the founders/legal counsel can make.

---

## Table of Contents

1. Project Overview
2. User Roles & Permissions
3. Application Entry Flow
4. Localization (English/Urdu)
5. Business Authentication
6. Business Home/Dashboard
7. Add Business
8. Business Verification Workflow
9. Seeking Investment
10. Investor Authentication
11. Investor Profile
12. Investor Home / Business Feed
13. Business Detail Screen
14. Investment / Connect Flow
15. Chat System
16. Notifications
17. Ratings & Reviews
18. Favorites / Saved Businesses
19. Admin Panel
20. Security & Privacy
21. Business Age Verification
22. Complete Screen List
23. Complete User Flows
24. Backend Architecture & Database
25. API / Backend Business Logic
26. Error & Empty States
27. Legal / Business TBD Register
28. Future Features (Phase 2+)
29. MVP Scope & Prioritization
30. Final Deliverables Summary & Roadmap

---

# 1. Project Overview

**Seen Profits** is a two-sided marketplace app connecting small/medium business owners ("Dukandars") seeking capital with investors looking for local investment opportunities, moderated by a platform Admin.

**Core value proposition:**
- Business owners get visibility to real investors without needing personal networks or bank loans.
- Investors get a curated, verified pipeline of local businesses with real performance data, instead of relying on informal tips.
- Admin ensures trust: nothing reaches investors unverified, and nothing sensitive (CNIC, full bank details) leaks publicly.

**Platform components:**
| Component | Purpose |
|---|---|
| Business Portal (Flutter mobile) | Business owners manage their business profile, verification, and investor relationships |
| Investor Portal (Flutter mobile) | Investors discover, evaluate, and connect with businesses |
| Admin Panel (Web, recommended) | Staff verify businesses, manage users, handle disputes, view analytics |

**Critical framing (important for stakeholders):** At MVP stage, Seen Profits is a **discovery and connection platform**, not a licensed investment/brokerage platform. It does **not** move money between investors and businesses. It facilitates introduction, information sharing, and chat — actual investment/fund transfer happens off-platform until a proper legal/financial framework (escrow, licensing, KYC/AML) is established. This is deliberate and is expanded in Section 27.

---

# 2. User Roles & Permissions

| Capability | Business Owner | Investor | Admin |
|---|---|---|---|
| Register/Login | ✅ (own flow) | ✅ (own flow) | ✅ (separate secure portal, not in mobile app) |
| OTP phone verification | ✅ | ✅ | N/A (admin uses email+password+2FA) |
| Create business listing | ✅ | ❌ | ❌ (can edit/suspend only) |
| Submit for verification | ✅ | ❌ | reviews & decides |
| View own business analytics | ✅ | ❌ | ✅ (all businesses) |
| Browse/search verified businesses | ❌ (sees own only) | ✅ | ✅ |
| View business sensitive docs (CNIC, bank) | own only | ❌ never | ✅ |
| Express interest / connect | receives requests | initiates | monitors |
| Chat | ✅ with connected investors | ✅ with connected businesses | ✅ read-only for moderation/reported chats |
| Rate/review | receives | gives (after qualifying interaction) | moderates |
| Report a user/business | ✅ | ✅ | resolves |
| Manage categories | ❌ | ❌ | ✅ |
| Approve/reject/suspend businesses | ❌ | ❌ | ✅ |
| Suspend/block users | ❌ | ❌ | ✅ |
| View platform-wide analytics | ❌ | ❌ | ✅ |
| Manage admin sub-accounts/roles | ❌ | ❌ | ✅ (super admin only) |
| Audit log access | ❌ | ❌ | ✅ |

### Additional reasonable features not in the original list

**Business Owner additions:**
- Multiple businesses per owner (TBD whether MVP allows this — see 27)
- Business performance history graph (self-view)
- Withdraw/close an investment opportunity
- Mute/block a specific investor
- Download own business profile as PDF (for offline pitching)
- View why a business was rejected with actionable checklist

**Investor additions:**
- Investor "verification tier" (basic phone-verified vs. CNIC-verified) — CNIC-verified investors may get badge/priority, TBD on business rules
- Investment interest limits (e.g., max concurrent pending interests) to prevent spam — TBD threshold
- Export saved businesses / notes
- Mute/block a specific business owner

**Admin additions:**
- Role-based admin accounts (Super Admin, Verification Officer, Support/Moderator, Analyst) — not all admins should have full control
- Bulk actions (approve/reject multiple documents)
- Manual override for OTP/account issues (support tooling)
- Configurable business categories with Urdu/English labels
- System health/monitoring view (failed OTPs, chat abuse spikes, etc.)
- Feature flags / maintenance mode toggle
- Content management for static pages (Terms, Privacy Policy, FAQ, Help)
- Data export (CSV) for reporting/compliance

---

# 3. Application Entry Flow

```
Splash Screen
   ↓
Language Selection (first launch only; persisted after)
   ↓
Role Selection: [ Business ] [ Investor ]
   ↓                              ↓
Business Auth Flow          Investor Auth Flow
```

- **Admin never appears in the mobile role-selection screen.** Admin access is a completely separate web portal (recommended) with its own login, ideally on a separate subdomain (e.g., `admin.seenprofits.com`), not bundled into the consumer Flutter app binary. This is a security best practice — it keeps admin credentials and admin-only code paths out of a public app package that can be decompiled.
- Returning users: Splash → check stored session token → if valid, skip directly to role's Home; if expired, go to that role's Login screen (not Role Selection again, since role is remembered).
- If a user has never selected a role but has a session (edge case, e.g. reinstalled app), fall back to Role Selection.

---

# 4. Localization (English / Urdu)

| Aspect | Approach |
|---|---|
| Language selection | Shown once on first launch; changeable later from Settings |
| Default language | Device locale if supported (en/ur), else English |
| Persistence | Stored locally (e.g., `shared_preferences`) and optionally synced to user profile so it follows them across devices |
| Flutter architecture | `flutter_localizations` + `intl` package with `.arb` files (`app_en.arb`, `app_ur.arb`); all UI strings referenced via generated `AppLocalizations`, never hardcoded |
| RTL support | Urdu is RTL. Wrap app in `Directionality`/rely on Flutter's automatic RTL handling via `Locale('ur')`; test every screen — icons, padding, text alignment, chat bubbles, forms, number fields (numbers typically stay LTR even in RTL text) |
| Scope of translation | All static UI text, validation/error messages, push/in-app notifications, empty states, dialogs, button labels, onboarding, legal pages |
| User-generated content (business descriptions, chat) | **Not** auto-translated in MVP — stored as entered. Auto-translation is a Phase 2 feature (TBD) |
| Category names | Stored bilingually in the database (`name_en`, `name_ur`) so Admin manages one category with two labels |
| Backend/API error messages | API returns language-agnostic error **codes**; the Flutter app maps codes to localized strings client-side (never rely on backend to return pre-translated text) |
| Date/number formatting | Use `intl` locale-aware formatting (currency as PKR, date formats) |

---

# 5. Business Authentication

### Registration fields
Full Name, Email, Phone Number, CNIC, Password, Confirm Password.

### Validation rules
| Field | Rule |
|---|---|
| Full Name | 3–100 chars, letters/spaces only |
| Email | Standard email regex, uniqueness check, case-insensitive storage |
| Phone Number | Pakistani format validation (e.g., `03XXXXXXXXX` / `+92 3XX XXXXXXX`), uniqueness check |
| CNIC | 13-digit format `XXXXX-XXXXXXX-X`, uniqueness check (one CNIC = one account across the platform, business or investor — **TBD**: can the same person hold both a business and investor account?) |
| Password | Minimum 8 chars, at least 1 letter + 1 number (TBD: require special char?); hashed with bcrypt/argon2, never stored/logged in plaintext |
| Confirm Password | Must match |

### Flow
```
Registration form → Submit
   → Backend validates uniqueness (email/phone/CNIC)
   → Account created with status = "unverified"
   → OTP sent via SMS to phone
   → OTP Verification screen
      → Correct + within expiry → status = "phone_verified" → Business Home
      → Incorrect → error, allow retry (max attempts)
      → Expired → prompt Resend
```

### OTP rules (fill gap)
- OTP: 6-digit numeric code
- Expiry: 5 minutes (TBD, configurable via admin/remote config)
- Resend: allowed after 30-second cooldown, max 5 resends per hour per number
- Max verification attempts: 5 per OTP; after exceeding, invalidate and force resend
- Rate limiting: max OTP requests per phone number per day (e.g., 10) to prevent SMS bombing/cost abuse

### Duplicate account handling
- If email/phone/CNIC already exists and is verified → reject with "Account already exists, please login."
- If exists but unverified (abandoned registration) → allow resuming OTP verification instead of creating a duplicate row.

### Other required flows
- **Forgot Password:** enter email/phone → OTP or reset link → set new password → invalidate old sessions.
- **Logout:** clears local session/token, revokes refresh token server-side.
- **Account deactivation:** soft-disable, business listing hidden from investors, reversible on request.
- **Account deletion:** user-initiated request → confirmation → data handled per retention policy (see Section 20); business/investment history may be anonymized rather than hard-deleted for record-keeping — **TBD** based on legal retention requirements.
- **Session/token expiry & refresh token rotation** for security.

---

# 6. Business Home / Dashboard

### Dashboard states
| State | What's shown |
|---|---|
| No business exists | Empty state with "Add Your Business" CTA, short explainer of the verification process |
| Pending verification | Status banner ("Under Review"), estimated review time (TBD SLA, e.g. "2–3 business days"), read-only submitted data |
| Approved | Full dashboard: performance summary, investor interest count, investment requests, edit option (edits to a live listing may re-trigger review — **TBD** policy: minor edits like description vs. major edits like financials) |
| Rejected | Rejection reason(s) from admin, clear checklist of what to fix, "Resubmit" CTA |
| Changes required | Specific field-level feedback, partial resubmission allowed (don't force re-filling the whole form) |
| Suspended | Explanation + support contact, listing hidden from investors |

### Standard dashboard elements (when approved)
- Business status badge
- Investment requirement summary (amount sought vs. amount "committed" if tracked)
- Investor interest count (new/unread)
- Active investment requests list
- Notifications bell
- Messages/chat shortcut
- Quick "Edit Business" and "Add Business" (if multi-business allowed — TBD)
- Mini performance chart (revenue/profit trend)

---

# 7. Add Business

### Business Information
| Field | Notes |
|---|---|
| Business Name | required |
| Business Category | dropdown, single primary category (TBD: allow secondary/tags?) |
| Description | required, min/max length |
| Business Type | e.g., Sole Proprietorship, Partnership — TBD list |
| Address (street/area) | required |
| City | required, dropdown of major cities + free text fallback |
| Province | required |
| Map Location (lat/long) | required, pin drop via map picker |
| Date Business Started | required — used to compute Business Age |
| Business Age (computed) | auto-derived from start date; must be ≥ 1 year to submit for verification |
| Number of Employees | optional, range picker |
| Contact info (business phone, alt contact) | required |
| Business Photos | min 3, max N images |

### Financial Information
| Field | Notes |
|---|---|
| Monthly Revenue (avg, last 3–6 months) | required |
| Monthly Expenses (avg) | required |
| Monthly Profit (computed or entered) | required |
| Last Month Revenue / Sales Bill | required, supports the "1 last month sales" requirement from original spec |
| Average Monthly Revenue/Profit | derived if multiple months entered, else single entry (TBD: require 3–6 months history at MVP, or accept self-reported single figures with "self-reported, unverified" disclaimer until admin cross-checks documents) |
| Bank Account Number | required, **stored encrypted, never shown publicly** |
| Required Investment Amount | required |
| Investment Purpose | required, free text or category (e.g., inventory, expansion, equipment) |
| Expected Return / Profit Sharing Model | required but **TBD** on exact legal structure (see Section 27) |

### Verification Documents
| Document | Required? |
|---|---|
| CNIC (front/back) | required |
| Business registration document (if applicable) | TBD — many small "Dukaan" shops may not have formal registration; may need alternate proof |
| Shop ownership/rental proof | required (rent agreement or ownership doc) |
| Bank statement (recent) | required, cross-checked against declared revenue |
| Sales records / bill photos | required |
| Utility bill (proof of address/operation) | required |
| Business photos (storefront, interior) | required |
| Other supporting documents | optional |

**TBD:** Exact list of legally acceptable documents per Pakistani business registration norms (e.g., NTN, Chamber of Commerce registration for larger businesses) needs confirmation from legal/compliance.

### 1-year minimum age rule
- Enforced at submission: if `today - date_business_started < 365 days`, block submission with clear message and show the eligible date.
- Prevents wasted admin review time on ineligible businesses.

---

# 8. Business Verification Workflow

### Statuses
```
Draft → Pending Verification → Under Review → { Approved | Rejected | Changes Required } → (Suspended, at any point post-approval)
```

| Status | Meaning | Visible to investors? |
|---|---|---|
| Draft | Owner still filling form, not submitted | No |
| Pending Verification | Submitted, awaiting admin pickup | No |
| Under Review | Admin actively reviewing | No |
| Changes Required | Admin needs more/corrected info | No |
| Approved | Verified, live on platform | **Yes** |
| Rejected | Did not meet criteria | No |
| Suspended | Was approved, later suspended (violation/dispute) | No |

### Flow
```
Owner submits → status: Pending Verification
   → Admin opens review queue → status: Under Review
   → Admin checks: business age, documents, financial plausibility, location, category correctness
   → Decision:
       Approve → status: Approved → visible to investors → owner notified
       Reject  → status: Rejected → reason required → owner notified → can edit & resubmit
       Request Changes → status: Changes Required → specific fields flagged → owner notified
```

- Rejection **must** include a structured reason (dropdown reason + free-text notes), not just free text — improves consistency and lets Admin generate analytics on common rejection causes.
- Owner can correct and resubmit unlimited times (TBD: rate-limit resubmissions to prevent queue spam, e.g., 24-hour cooldown).

### Public vs. private data
| Data | Investor sees | Admin sees |
|---|---|---|
| Business name, category, description, photos | ✅ | ✅ |
| Location (approximate area/map pin) | ✅ | ✅ (+ exact address) |
| Business age | ✅ | ✅ |
| Revenue/profit summary (aggregated/rounded, or full — **TBD** on precision level) | ✅ (possibly rounded ranges) | ✅ (exact) |
| Required investment, purpose, expected return | ✅ | ✅ |
| CNIC | ❌ Never | ✅ (verification only, access-logged) |
| Full bank account number | ❌ Never (masked, e.g., last 4 digits if shown at all) | ✅ (verification only, access-logged) |
| Uploaded documents (rent agreement, utility bill, etc.) | ❌ Never | ✅ |
| Business owner's personal phone/email | ❌ Not until a connection is accepted (**TBD**: revealed after mutual interest, or only via in-app chat) | ✅ |

---

# 9. Seeking Investment

A business can create/attach an **Investment Opportunity** once approved:

| Field | Notes |
|---|---|
| Required Investment Amount | e.g., Rs. 50,000 – Rs. 1,000,000+ |
| Investment Purpose | inventory, expansion, equipment, renovation, etc. |
| Investment Duration | e.g., "12 months," "open-ended" |
| Expected Return / Profit Sharing | **TBD** — see legal section; UI should present this as "business owner's proposed terms," not a platform-guaranteed return |
| Minimum Investment Amount | optional, per-investor minimum contribution |
| Maximum Investment Amount | optional, cap per investor or cap on total raise |
| Investment Status | Open, Partially Funded (if tracking partial commitments — TBD), Fully Funded, Closed |

**Important disclaimer requirement (must appear in UI):** Seen Profits does not guarantee returns, does not verify the accuracy of financial projections beyond submitted documents, and is not a party to any investment agreement between business owner and investor. This must be shown before an investor can express interest (Section 27).

---

# 10. Investor Authentication

Same structure and rules as Business Authentication (Section 5): Full Name, Email, Phone, CNIC, Password/Confirm → OTP → Investor Home. Same OTP rules, password rules, forgot password, logout, deactivation/deletion apply.

**Note:** CNIC collection for investors is required for platform trust/KYC-readiness even though CNIC verification against NADRA or similar is **TBD** (likely Phase 2 — see Section 21/27). At MVP, CNIC may be collected but only manually spot-checked by admin, not automatically verified.

---

# 11. Investor Profile

| Field | Notes |
|---|---|
| Name, profile picture, phone, email | standard |
| CNIC verification status | Unverified / Submitted / Verified |
| Preferred business categories | multi-select |
| Investment budget/range | optional, helps recommendation engine later |
| Location | for location-based filtering/recommendations |
| Investment history | list of past interests/completed connections |
| Saved businesses | shortcut to favorites |

Categories example: Restaurant, Grocery, Clothing, Electronics, Pharmacy, Manufacturing, Services (admin-managed list, extensible).

---

# 12. Investor Home / Business Feed

### Business card fields
Title, Category, Short Description, Rating, Business Age, Location, Investment Required, Verification Badge, Performance Summary (mini-indicator, e.g., "↑ Growing" trend icon).

### Filters/sorting
- Search (by name/keyword)
- Category filter (multi-select)
- Location filter (city/province, radius if using precise geolocation)
- Investment amount range filter
- Business age filter
- Rating filter
- Sort by: Newest, Investment amount (low-high/high-low), Rating, Recommended
- Featured businesses (admin-curated placement — **TBD**: paid feature or editorial choice)
- Recently added
- Recommended (basic version: match investor's preferred categories; ML-based recommendations = Phase 2)

Only `Approved` status businesses appear here — enforced at query level, not just UI filtering (security: never trust client to filter).

---

# 13. Business Detail Screen

**Basic Info:** Name, Description, Category, Age, Location (map), Rating, Verification Badge, Photo gallery.

**Business Performance:** Monthly revenue/expenses/profit (as investor-visible level per Section 8), historical trend chart, growth indicator. Chart should clearly label whether data is "self-reported" vs "verified against documents" to manage investor trust/expectations.

**Investment Info:** Required investment, purpose, duration, expected return/profit-sharing terms, minimum investment, current status (Open/Closed/Funded).

**Never shown:** CNIC, full bank number, private documents, owner's raw contact info (until connection accepted, per chat-mediated contact policy).

---

# 14. Investment / Connect Flow

```
Investor taps "Invest / Express Interest"
   → Popup/screen shows: business name, required amount, investor's intended amount,
     business age, performance graph, purpose, expected return, disclaimer
   → Investor confirms → "Connect / Express Interest"
   → Creates Investment Interest/Request record (status: Pending)
   → Notifies Business Owner
   → Chat channel opens between the two parties
   → Owner responds: Accept / Reject / Negotiate
   → Status tracked: Pending → Accepted/Rejected/Negotiating → Completed/Cancelled
```

| Status | Meaning |
|---|---|
| Pending | Investor expressed interest, awaiting owner response |
| Accepted | Owner agreed to proceed (off-platform terms discussion continues) |
| Negotiating | Terms being discussed (amount/return adjusted) |
| Rejected | Owner declined |
| Completed | Marked by both parties (or admin, for record) once actual investment happened off-platform |
| Cancelled | Investor withdrew interest |

**Critical guardrail:** No money moves inside the app at MVP. This flow is a structured "matchmaking + negotiation tracker," not a payment flow. "Completed" is a self-reported status for record-keeping, not proof of funds transfer, until a real payment/escrow system is integrated (Phase 2, TBD).

**Missing feature to add:** Investor should be limited on how many *simultaneous pending* interests they can have to reduce spam-connecting (TBD threshold), and business owners should be able to set a cap on total investors they're actively negotiating with at once.

---

# 15. Chat System

**MVP (Must Have):**
- One-to-one chat, tied to an investment interest/connection (chat unlocked only after interest expressed — prevents cold-spam messaging)
- Text messages, timestamps, read/unread status
- Push + in-app notification on new message
- Block/report user from within chat
- Chat history persistence
- Delete conversation (soft-delete for own view; not for the other party, to preserve dispute evidence)

**Should Have / Optional (mark clearly to stakeholders):**
- Image/document sharing (useful for sharing extra proof documents) — adds storage/moderation complexity
- Typing indicator
- Online/offline status
- Message delivery status (sent/delivered/seen — separate from read receipts)

**Moderation requirement:** Admin should have a read-only view of reported conversations for dispute resolution (with privacy safeguards — access should be logged, and ideally only accessible after a report is filed, not blanket surveillance).

---

# 16. Notifications

| Type | Business | Investor |
|---|---|---|
| Account | Registration success, OTP | Registration success, OTP |
| Verification | Business submitted, approved, rejected, changes required | Verification badge updates on saved businesses |
| Discovery | — | New recommended business matching preferences |
| Engagement | Investor expressed interest, new chat message | Business owner responded, new chat message |
| Investment | Request accepted/rejected/negotiating | Investment status updates |
| Platform | Admin announcements | Admin announcements |
| Saved items | — | Updates on saved/favorited businesses (status change, funding progress) |

**Delivery channels:** Push notifications (FCM), in-app notification center, with read/unread state and history (retained e.g. 90 days — TBD retention window).

**Preferences:** Users should be able to toggle notification categories on/off (e.g., mute promotional/announcement pushes but keep transactional ones).

---

# 17. Ratings & Reviews

- Investors can rate/review a business **only after a qualifying interaction** — recommended trigger: after an investment request reaches "Accepted" or "Completed" status (prevents drive-by/competitor-sabotage reviews on businesses they never engaged with).
- 1–5 star rating + written review.
- Business owners cannot review investors in MVP (asymmetric — **TBD** whether mutual rating is wanted later, similar to ride-share driver/rider rating models).
- Reported/inappropriate reviews go into Admin's moderation queue; admin can hide/remove without deleting the underlying record (for audit trail).
- Rating aggregation shown on Business Detail Screen and feed cards.

---

# 18. Favorites / Saved Businesses

- Save/unsave a business (heart icon)
- Dedicated "Saved Businesses" list in Investor profile
- Push/notification when a saved business's status changes (e.g., funding closed, new update posted) — **should have**, not strictly MVP-critical but low effort, high retention value

---

# 19. Admin Panel

### Dashboard
Total/verified/pending/rejected businesses, total/active investors, investment requests (by status), completed investments (self-reported), reported accounts/content, recent platform activity feed, revenue/fees if applicable (**TBD** — depends on monetization model, see Section 27).

### Business Management
View/search/filter, review details & documents (with document viewer), approve/reject/request changes (with reason codes), suspend, delete (soft-delete preferred for audit trail).

### Investor Management
View/search/filter, view profile, verify identity (manual CNIC check at MVP), suspend, block, delete.

### Investment Management
View all requests, track statuses, review disputes (flagged by either party), view aggregate investment history, generate reports/exports.

### Category Management
Add/edit/deactivate categories with bilingual (EN/UR) names; deactivating a category shouldn't break existing businesses tagged with it — reassignment flow needed.

### Reports & Complaints
Users can report: fake business, fraud, misleading info, harassment, suspicious activity, inappropriate chat content. Admin queue with status (New/Investigating/Resolved/Dismissed), resolution notes, and ability to take action directly from the report (suspend user, remove content) — linking the moderation action to the report for audit purposes.

### Additional Admin capabilities (gaps identified)
- **Role-based admin accounts:** Super Admin, Verification Officer (documents/approvals only), Support Agent (users/chat/reports only), Analyst (read-only dashboards). Prevents any single compromised admin login from having full platform control.
- **Audit logs:** every admin action (approve, reject, suspend, delete, document view) logged with admin ID, timestamp, target, before/after state.
- **Content management:** edit static pages (Terms & Conditions, Privacy Policy, FAQ, Help & Support content), bilingually.
- **System/config settings:** OTP expiry duration, resend cooldown, minimum business age (in case it's ever adjusted), featured business slots, maintenance mode toggle.
- **Broadcast/announcement tool:** send platform-wide or segmented (all businesses / all investors) notifications.
- **Data export:** CSV/Excel export of businesses, investors, investment requests for offline reporting/compliance review.

---

# 20. Security & Privacy

| Area | Requirement |
|---|---|
| Authentication | Secure password hashing (bcrypt/argon2), JWT-based sessions (access + refresh token pair) issued by the Node.js backend, with expiry + refresh rotation |
| OTP | Rate-limited, time-limited, attempt-limited (Section 5); never log raw OTP in plaintext logs |
| RBAC | Enforced server-side in the Node.js API layer via middleware + service-level ownership checks (MongoDB has no native row-level security, so this discipline is mandatory — see Section 24); never trust client-side role claims alone |
| CNIC/Bank privacy | Encrypted at rest (field-level encryption in MongoDB); masked/excluded via server-side projections in all API responses except to authorized admin roles; every admin access to this data should be **audit-logged** |
| Document access | Signed, short-lived URLs for private object storage (provider **TBD** — e.g., S3-compatible bucket); never publicly listable buckets |
| API authorization | Every endpoint validates JWT + role + resource ownership (e.g., a business owner can only edit *their* business, not any business by guessing an ID) |
| Database security | Principle of least privilege for the Node.js service's DB user/connection string; Mongoose schema validation + sanitized queries (no raw string-built queries) — prevents NoSQL injection |
| Access control consistency | Since MongoDB has no per-row enforcement, access rules must live in one shared service layer (Section 24) so every new endpoint automatically inherits the correct read/write restrictions instead of re-implementing them ad hoc |
| Admin access control | Separate portal, IP-allowlisting optional (TBD), mandatory 2FA for admin accounts |
| Audit logs | Immutable log of sensitive actions (approvals, suspensions, document views, deletions) |
| Fraud prevention | Duplicate CNIC/account detection, anomaly detection on rapid mass "interest" spam (basic rate limiting at MVP; ML-based fraud detection = Phase 2) |
| Rate limiting | On login attempts, OTP requests, chat message sending (anti-spam), report submissions |
| Secure chat | Messages encrypted in transit (TLS); at-rest encryption of message content (TBD level — full E2E encryption is a larger undertaking, likely Phase 2; MVP: server-side encryption at rest is sufficient) |
| Data deletion | User-requested deletion honors legal retention needs (financial/investment records may need retention for dispute purposes even after account deletion — **TBD**, consult legal) |
| Privacy Policy / Terms & Conditions | Required before launch; **TBD content**, must be drafted/reviewed by legal counsel, not generated as boilerplate for a financial-adjacent product |

---

# 21. Business Age Verification

Approaches to consider for verifying the "≥1 year old" requirement:

| Method | Reliability | Notes |
|---|---|---|
| Self-declared start date | Low (input only) | Used to gate the submission form initially |
| Business registration document | High, if business is formally registered | Many small shops may not have this |
| Rental agreement | Medium-High | Shows occupancy duration if dated |
| Utility bills (multiple months spanning >1 year) | Medium-High | Practical and commonly available |
| Bank statements showing 1+ year of activity | High | Strong signal but requires owner comfort sharing statements |
| Sales/purchase records | Medium | Supports plausibility, not definitive proof |
| Admin manual judgment call | Final authority | Admin cross-references above and makes the approve/reject call |

**Final verification method and exact document combination required: marked TBD**, pending confirmation of what's realistically obtainable from small Pakistani retail/service businesses (many operate informally). Recommend defining a minimum "2 of the above" rule once legal/ops team decides.

---

# 22. Complete Screen List

### Common
Splash · Language Selection · Role Selection · Notifications Center · Settings · Profile · Help & Support · Terms & Conditions · Privacy Policy

### Business
Login · Registration · OTP Verification · Forgot/Reset Password · Home/Dashboard · Add Business (multi-step form) · Edit Business · Verification Status/Detail · Business Preview (how investors see it) · Investment Opportunity Management · Investor Interest List · Investor Detail (from owner's side) · Chat List · Chat Conversation · Notifications · Profile · Settings

### Investor
Login · Registration · OTP Verification · Forgot/Reset Password · Home/Feed · Search Results · Filters · Category Selection (onboarding + editable later) · Business Detail · Investment/Interest Popup · Connect Confirmation · Investment Request Tracking List · Saved Businesses · Investment History · Chat List · Chat Conversation · Notifications · Profile · Settings

### Admin (Web Panel)
Login (with 2FA) · Dashboard · Business Review Queue · Business Detail/Document Viewer · Investor Management List/Detail · Investment Requests List/Detail · Category Management · Reports/Complaints Queue · Report Detail/Resolution · User Management (suspend/block) · Admin Role/Account Management · Content Management (Terms/Privacy/FAQ) · Broadcast/Announcements · Analytics · Audit Log Viewer · Settings/Config

---

# 23. Complete User Flows

### Business Owner
```
Register → OTP → Home (empty state)
  → Add Business (multi-step form + documents)
  → Submit → Pending Verification
  → Admin reviews → Approved
  → Create/Edit Investment Opportunity terms
  → Receive Investor Interest notification
  → Review investor's proposed amount → Accept/Reject/Negotiate
  → Chat with investor
  → Mark request Completed/Cancelled (self-reported)
```

### Investor
```
Register → OTP → Set up Profile → Select Preferred Categories
  → Home Feed (filtered/recommended businesses)
  → Search/Filter
  → Business Detail
  → Tap Invest/Connect → review disclaimer → Confirm
  → Investment Request created (Pending)
  → Await owner response → Chat opens
  → Track status through Negotiating → Accepted/Completed or Rejected/Cancelled
```

### Admin
```
Login (2FA) → Dashboard
  → Business Review Queue → open business → verify documents → Approve/Reject/Request Changes
  → Manage Users (investors/businesses) → suspend/block if needed
  → Monitor Investment Requests → resolve disputes if flagged
  → Handle Reports/Complaints queue → take action
  → View Analytics → export reports
```

---

# 24. Backend Architecture & Database

### Confirmed stack

Architecture: **Flutter (BLoC) → Repository/API Service Layer → Node.js REST API → MongoDB**

| Layer | Technology | Notes |
|---|---|---|
| Mobile frontend | Flutter | Business + Investor portals |
| State management | BLoC | Strict `UI → BLoC → Repository/Service → API` separation; no business logic in widgets |
| Flutter boilerplate | BioTip-mobile-app (CodeSwifters) repo, reused as a structural starting point | Reused for project scaffolding/conventions only — **all BioTip-specific domain logic, models, and screens must be stripped out and replaced.** See boilerplate notes below. |
| Backend | Node.js (REST API) | Central business-logic layer; owns all validation, authorization, and side effects (notifications, status transitions) — Flutter never talks to MongoDB directly |
| Database | MongoDB | Document store; schema enforced at the application layer (Mongoose or equivalent ODM) since MongoDB itself is schema-flexible |
| Admin Panel frontend | **TBD** (Flutter Web / React.js / Next.js) | Consumes the same Node.js REST API; role-based access control enforced backend-side regardless of which frontend is chosen |
| Localization | Flutter `intl` + `.arb` files | EN/UR, RTL for Urdu |
| Realtime (chat, live status) | **TBD** — Node.js options include Socket.IO, native WebSockets, or a managed pub/sub service | Needs to be decided alongside chat scale expectations |

**Boilerplate reuse notes (BioTip-mobile-app):**
- Treat it strictly as a technical starting point: project structure, BLoC setup conventions, theming/localization scaffolding, common widgets (buttons, inputs, loaders, error views), networking/interceptor setup, and dependency choices may be reused.
- Anything BioTip-domain-specific (its food-freshness/AI-scan feature screens, its data models, its API contracts) must be removed, not adapted-in-place — building Seen Profits screens *on top of* leftover BioTip logic risks hidden coupling and dead code.
- Recommend an early "boilerplate audit" task: fork/clone the repo, delete all BioTip-specific feature modules, keep only `core/`, `shared widgets`, `theme`, `localization scaffold`, `network client`, and `bloc base classes` (exact folder names TBD until the repo is reviewed by the dev team — I was not able to inspect its contents directly, as the repository is not publicly fetchable from this environment; the development team should review it directly on GitHub).
- Re-run a dependency audit (`pubspec.yaml`) — drop packages BioTip needed (e.g., AI/camera/image-classification SDKs) that Seen Profits won't use, to keep the app lean.

### Core collections (MongoDB)

Document-oriented equivalent of the earlier relational sketch — embed where data is always read together and small; reference (via ObjectId) where data is large, independently queried, or access-controlled differently.

| Collection | Purpose | Key fields | Read/Write |
|---|---|---|---|
| `users` | Base identity for all roles | `_id`, `role` (enum: business/investor), `email`, `phone`, `cnicEncrypted`, `passwordHash`, `status`, `createdAt` | self write; admin read/write |
| `businessProfiles` | Business core data | `_id`, `ownerId` (ref users), `name`, `categoryId`, `description`, `address`, `city`, `province`, `location: {lat, lng}`, `dateStarted`, `employeesCount`, `verificationStatus`, `verificationHistory[]` | owner write (own), investor read (if approved, via API projection), admin full |
| `businessFinancials` | Financial figures — **kept as a separate collection, not embedded**, so it can carry stricter access rules than the parent profile | `businessId` (ref), `monthlyRevenue`, `monthlyExpenses`, `monthlyProfit`, `lastMonthSales`, `avgRevenue`, `avgProfit`, `bankAccountEncrypted` | owner write (own), admin read, investor read via a server-side **projection** that strips/rounds sensitive fields (never send the raw document to investor-facing endpoints) |
| `businessDocuments` | Uploaded verification docs (metadata; files live in object storage, e.g., S3-compatible bucket — **TBD provider**) | `businessId`, `docType`, `storagePath`, `uploadedAt`, `reviewed`, `reviewedBy` | owner write (own, pre-approval), admin read only |
| `investorProfiles` | Investor core data | `_id`, `userId` (ref), `preferredCategories[]`, `budgetRange`, `location`, `cnicVerificationStatus` | self write, admin read |
| `businessCategories` | Category taxonomy | `_id`, `nameEn`, `nameUr`, `active` | admin write, all read |
| `investmentOpportunities` | The "ask" per business | `_id`, `businessId`, `amountRequired`, `purpose`, `duration`, `expectedReturnNotes`, `minAmount`, `maxAmount`, `status` | owner write (own business), investor read (if business approved), admin read |
| `investmentRequests` | Investor interest/connection | `_id`, `opportunityId`, `investorId`, `businessId`, `intendedAmount`, `status` (enum), `statusHistory[]`, `createdAt`, `updatedAt` | investor create/update own, owner update (accept/reject), admin read all |
| `savedBusinesses` | Investor favorites | `investorId`, `businessId`, `savedAt` | self write, admin read |
| `chats` | Conversation threads | `_id`, `investmentRequestId` (nullable if pre-connect chat allowed), `participantIds[]`, `createdAt` | participants read/write own |
| `messages` | Chat messages | `_id`, `chatId`, `senderId`, `content`, `sentAt`, `readAt`, `attachmentUrl` (nullable) | participants read/write own thread |
| `notifications` | Per-user notification feed | `_id`, `userId`, `type`, `payload`, `read`, `createdAt` | self read, system write |
| `ratingsReviews` | Investor → business reviews | `_id`, `businessId`, `investorId`, `rating`, `reviewText`, `createdAt`, `hidden` | investor create own, all read (unless hidden), admin moderate |
| `reports` | User-submitted reports | `_id`, `reporterId`, `targetType`, `targetId`, `reason`, `notes`, `status`, `resolvedBy`, `resolvedAt` | reporter create, admin read/write |
| `adminUsers` | Admin accounts + roles | `_id`, `email`, `passwordHash`, `role` (enum), `twoFactorSecret`, `active` | super_admin write, self read |
| `auditLogs` | Immutable admin action trail | `_id`, `adminId`, `action`, `targetType`, `targetId`, `beforeState`, `afterState`, `timestamp` | system write only, admin read (super_admin only ideally) |
| `otpVerifications` | OTP tracking | `_id`, `userId`/`phone`, `codeHash`, `expiresAt`, `attempts`, `purpose` (register/reset) | system only |

**Indexing notes (MongoDB-specific, flag for backend dev):** compound indexes on `businessProfiles.verificationStatus + categoryId + city` for feed queries; unique indexes on `users.email`, `users.phone`, `users.cnicEncrypted`-hash (can't uniquely index an encrypted value directly — store a separate deterministic hash field for uniqueness checks); TTL index on `otpVerifications.expiresAt` for automatic cleanup.

**Not final** — this schema is a strong starting point but should be reviewed against actual query patterns once the API layer is designed (e.g., whether `businessFinancials` needs further splitting for finer-grained access control between "investor-visible rounded view" vs "raw admin data").

### Access control model (Node.js, no native Row-Level Security)

Unlike Postgres/Supabase, MongoDB has no built-in row-level security — **all access control must be enforced in the Node.js API layer**, consistently, on every route:

- **Middleware-based RBAC:** every route declares which role(s) may call it; a shared auth middleware validates the JWT, attaches `req.user`, and rejects mismatched roles before the controller runs.
- **Ownership checks in controllers/services, not trusted from the client:** e.g., "update business" checks `businessProfiles.ownerId === req.user.id` server-side on every request, regardless of what the Flutter app sends.
- **Field-level projection for sensitive data:** investor-facing endpoints must use explicit MongoDB projections (or a dedicated "public view" service function) that exclude `bankAccountEncrypted`, `cnicEncrypted`, and raw document storage paths — never rely on the Flutter UI to simply "hide" fields it received.
- **Service-layer enforcement, reused everywhere:** implement these checks once in shared repository/service functions (e.g., `businessService.getForInvestor(id)` vs. `businessService.getForOwner(id, ownerId)` vs. `businessService.getForAdmin(id)`) rather than duplicating logic per-route, so a forgotten check in one new endpoint doesn't leak data.
- **Document-level audit logging:** any admin read of `businessDocuments` or `businessFinancials.bankAccountEncrypted`/`cnicEncrypted` should write an `auditLogs` entry.

---

# 25. API / Backend Business Logic

| Operation | Auth required | Role restriction | Notes |
|---|---|---|---|
| Register | No | — | Rate-limited by IP/device |
| Login | No | — | Rate-limited, lockout after N failed attempts |
| OTP verification | Session (unverified) | — | Attempt + expiry limited |
| Create business | Yes | Business owner | One business per owner at MVP (TBD if multiple allowed) |
| Update business | Yes | Owner of that business only | Major-field edits may reset status to "Changes Required"/re-review — TBD policy |
| Submit for verification | Yes | Owner | Blocked if business age < 1 year or required fields/docs missing |
| Admin approve/reject | Yes | Admin (Verification Officer+) | Must include reason for rejection; writes to audit_logs |
| Create investment opportunity | Yes | Owner, business must be Approved | |
| Browse/search businesses | Yes (or public read-only? **TBD** — recommend requiring investor login even to browse, for analytics + spam control) | Investor | Only returns Approved businesses (enforced server-side) |
| Multi-category filter | Yes | Investor | |
| Express investment interest | Yes | Investor | Rate-limited (max concurrent pending interests — TBD) |
| Accept/reject investment request | Yes | Business owner of that opportunity | |
| Chat send/receive | Yes | Participants only | Realtime mechanism **TBD** (Socket.IO / WebSockets / managed pub-sub) on top of the Node.js backend |
| Notifications dispatch | System | — | Triggered from within Node.js service logic on relevant events (e.g., after a MongoDB write succeeds, the service layer enqueues/pushes the notification — no DB-native triggers in MongoDB, so this must be explicit application code) |
| Ratings submission | Yes | Investor, only if qualifying interaction exists | |
| Reports submission | Yes | Any authenticated user | |

All state-changing endpoints must validate: (1) valid session, (2) correct role, (3) resource ownership, (4) business rule preconditions (e.g., age requirement, approval status) — in that order, server-side, never relying on the Flutter client to enforce these.

---

# 26. Error & Empty States

| State | UX requirement |
|---|---|
| No businesses found (feed/search) | Friendly empty illustration + "adjust filters" CTA |
| No saved businesses | Explain what favoriting does + browse CTA |
| No investment requests | Explain flow, prompt relevant action (business: "wait for investors"; investor: "browse businesses") |
| No messages | Explain chat unlocks after connecting |
| No notifications | Simple empty state |
| Network error | Retry button, offline indicator |
| Server error (5xx) | Generic friendly message, no raw stack traces/error codes shown to user |
| Invalid OTP | Inline error, remaining attempts shown |
| Expired OTP | Prompt resend clearly |
| Invalid login | Generic "invalid credentials" (don't reveal whether email or password was wrong — security best practice) |
| Business rejected | Clear reason + resubmit path (Section 8) |
| Business pending | Reassuring status, no dead-end |
| Missing documents | Field-level indicators on what's missing before submit is allowed |
| Unauthorized access | Redirect to login / "you don't have permission" without leaking whether the resource exists |
| Account suspended | Clear explanation + support contact, block further app usage until resolved |

---

# 27. Legal / Business TBD Register

**This section is intentionally not decided by this document.** These require legal counsel + founder/business decisions before real-money features are built or the platform is publicly marketed as an "investment platform."

| Area | Why it's TBD |
|---|---|
| Investment model (equity? profit-sharing? loan?) | Determines regulatory classification; equity-like arrangements may trigger securities regulations in Pakistan |
| Profit sharing mechanics | Needs a defined, enforceable formula and dispute process |
| Return guarantees | Platform must **never** imply guaranteed returns without licensing — legal risk |
| Platform fees / monetization | Subscription? Success fee on connections? Featured listing fees? Undecided |
| Payment processing | Not built at MVP; requires a licensed payment processor/PSP evaluation |
| Escrow | Needed if platform ever holds funds — requires financial licensing, likely Phase 2+ |
| Refund/cancellation policy | Depends on payment model above |
| Investor protection mechanisms | Dispute resolution process, complaint escalation SLAs |
| Business owner obligations | Contractual obligations once "Accepted" — currently informal/off-platform |
| KYC/AML requirements | CNIC collection is a first step; full KYC/AML compliance requires regulatory guidance |
| Terms & Conditions / Privacy Policy | Must be legally drafted, not template-generated, given financial-adjacent nature |
| Disclaimers | Must clearly state platform is a discovery/connection tool, not a financial advisor or broker, until otherwise licensed |
| Local regulatory requirements (SECP, SBP involvement?) | Needs direct legal consultation — Seen Profits may fall under Securities and Exchange Commission of Pakistan oversight depending on final investment model |

**Recommendation:** Launch MVP explicitly as a "discovery & connection" platform with strong disclaimers, and treat any real fund movement/escrow/return-guarantee functionality as a distinct, legally-gated Phase 2+ initiative.

---

# 28. Future Features (Phase 2+)

- Payment gateway integration
- Escrow service
- Digital contracts / e-signatures for investment agreements
- Advanced analytics (cohort analysis, investor ROI tracking)
- AI-based business recommendations for investors
- Investor portfolio dashboard (aggregated view across investments)
- Automated business performance tracking (bank feed integration — highly sensitive, needs consent flows)
- Video calls (in-app, for pitch meetings)
- Automated document verification (OCR/AI-assisted authenticity checks)
- Fraud detection (ML-based anomaly detection on listings/behavior)
- Advanced admin analytics/BI dashboards
- Investor risk profiling
- Investment calculator/ROI simulator
- Multi-business support per owner
- Mutual (business→investor) ratings
- Full end-to-end encrypted chat
- CNIC verification via NADRA or similar government API integration
- Auto-translation of user-generated content (business descriptions, chat)

---

# 29. MVP Scope & Prioritization

### Must Have (MVP)
- Business & Investor registration/login/OTP
- Add Business (info + financials + documents)
- Business verification workflow (Admin approve/reject/changes-required)
- Public/private data separation (CNIC/bank never exposed)
- Investor feed with search + core filters (category, location, investment amount)
- Business Detail screen
- Express Interest / Connect flow with status tracking
- 1-to-1 text chat (post-connection only)
- Core notifications (verification updates, new interest, new message, request status)
- Favorites/saved businesses
- Admin panel: business review, user management, category management, reports queue, basic dashboard
- Bilingual (EN/UR) UI with RTL support
- Core security: RBAC, RLS, encrypted sensitive fields, audit logs for admin actions

### Should Have
- Ratings & reviews (post-qualifying-interaction)
- Rejection reason analytics for admin
- Role-based admin sub-accounts
- Broadcast/announcement tool
- Saved-business update notifications
- Business performance trend chart

### Nice to Have
- Image/document sharing in chat
- Typing indicator / online status
- Featured businesses
- PDF export of business profile
- Data export (CSV) for admin

### Future (explicitly out of MVP)
- Everything in Section 28
- Any real payment/escrow/fund-transfer functionality
- CNIC government-verified KYC
- Multi-business-per-owner support

---

# 30. Final Deliverables Summary & Roadmap

This document has covered: project overview, role-based requirements (business/investor/admin), complete screen inventory, user flows, database structure, backend architecture, security model, localization approach, verification/investment/chat/notification workflows, error/empty states, a legal TBD register, and MVP vs. Phase 2 prioritization.

### Recommended development order

1. **Foundation:** Audit and strip the BioTip boilerplate (Section 24); set up the Node.js project (routing, Mongoose models, auth middleware) and MongoDB instance; auth (email/phone/OTP) with JWT issuance; base `users`/role collections; shared service-layer access-control pattern; Flutter localization scaffolding (EN/UR `.arb` files); design system.
2. **Business side, pre-verification:** Registration → OTP → Add Business form (multi-step) → document upload → submission.
3. **Admin core:** Admin auth (2FA), business review queue, approve/reject/changes-required flow, category management.
4. **Investor side, discovery:** Registration → OTP → category preferences → feed → filters/search → business detail (respecting visibility rules).
5. **Connection layer:** Express interest → investment_requests lifecycle → notifications wiring.
6. **Chat:** Realtime 1-to-1 messaging tied to accepted/pending connections.
7. **Engagement layer:** Favorites, ratings/reviews, notification center polish.
8. **Admin depth:** Reports/complaints queue, user suspension/block, analytics dashboard, audit log viewer.
9. **Hardening:** Security review (RLS audit, rate limiting, encrypted field verification), full EN/UR + RTL QA pass, error/empty state QA, legal page integration (pending legal sign-off from Section 27).
10. **Launch prep:** Load/performance testing, analytics instrumentation, staged rollout plan.

### Key dependencies to flag
- Admin verification workflow must exist **before** investor feed is meaningful (feed is empty without approved businesses).
- Chat is gated by the connection flow — build investment_requests before chat.
- Legal sign-off (Section 27) should happen in parallel with development, not after, since disclaimer text and terms must be integrated into UI before public launch, not bolted on.

### Explicit assumptions made in this document (flag to stakeholders)
- One business per owner at MVP (TBD if this should change).
- Investment amounts in PKR only at MVP (no multi-currency).
- No real fund transfer occurs on-platform at MVP.
- Admin panel assumed to be a web app, not part of the Flutter mobile binary.
- CNIC collected but not government-verified at MVP.
- Browsing the investor feed requires login (TBD if a public preview mode is wanted for marketing purposes).

---

*End of document. Items marked TBD should be resolved with founders/legal counsel before their corresponding features move from planning to development.*
