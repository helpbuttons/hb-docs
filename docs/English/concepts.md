# Core Concepts

This page explains the main building blocks of Helpbuttons in plain terms. Understanding these five concepts is enough to work on any part of the codebase.

---

## Network

A **Network** is the top-level community container. Think of it as the "app" you are creating for your community.

Each Network has:
- A **name, description, and location** (used to set the map's default area)
- A **radius** defining the geographic scope
- An **avatar** and customizable colors/theme
- A **privacy setting**: public (visible to anyone) or private (invite-only)
- A set of **ButtonTemplates** that define what types of buttons exist in this Network
- **Coordinators** who can moderate content and manage users

Each Helpbuttons installation hosts **one Network**. Separate installations can **federate** with each other to share users and content across instances.

**Example**: A neighborhood mutual aid group runs its Network at `ayuda.mibarrio.org`. It's configured as public, has two button types ("Offering" and "Requesting"), and three coordinators.

---

## Button (Helpbutton)

A **Button** is the core post — the unit of information that users publish and other users respond to. The name "Helpbutton" reflects the original mutual aid focus, but a button can represent any kind of offer, need, event, or resource.

Every button has these base fields:
- **Title** and **description**
- **Location** (with optional privacy: exact point or approximate area)
- **Type** (defined by the Network's ButtonTemplates — e.g. "Offer", "Need", "Event")
- **Tags**
- **Images**
- **Date** (optional, turns it into an event)

Buttons belong to the Network they were created in. Through federation, a button can be shared with other Networks that use the same ButtonTemplate.

Every button has a **Feed** — see below.

**Example**: A user posts a button: "I have 5kg of tomatoes to share" → type "Offering", location set to approximate area, tagged "food, vegetables". Other users see it on the map and message through the button's feed.

---

## ButtonTemplate

A **ButtonTemplate** is what makes each Network unique. It defines extra fields beyond the base button structure — the Network coordinator creates templates that match their community's use case.

A food-sharing network might add: food type, quantity, dietary info.
A transport network might add: departure, destination, departure time, seats available.
An event network might add: date, duration, maximum participants.

ButtonTemplates are defined in JSON and the frontend renders the appropriate form fields and filters automatically.

**Example**: The coordinator creates a "Ride offer" template with fields: `from`, `to`, `departure_time`, `seats`. When users create a "Ride offer" button, they fill in those extra fields. The Explore page shows a "departure time" filter.

---

## User

A **User** is a registered person who can join Networks, publish Buttons, and interact with others.

Key properties:
- Users exist **across Networks** — their profile and reputation travel with them
- Users can **join and leave** Networks freely (subject to privacy settings)
- Users can **support** each other (positive endorsement, no ratings)
- Users can be **blocked** by coordinators within a Network or globally
- Coordinators can assign other users **coordinator roles** within their Network

There is no global reputation score — reputation is social, established through peer endorsements and community trust.

---

## Feed

A **Feed** is the public conversation thread attached to a button — where coordination happens: questions, confirmations, status updates. All members can read and post in a button's feed.

---

## Messaging

All private and group communication lives in the **Messages** section, separate from button feeds. Each thread is called an **Activity Conversation**. There are three types:

- **Button conversation**: opened from a specific button, it creates a one-to-one private chat between the user and the button's creator. Invisible to everyone else.
- **Community forum**: a single group Activity Conversation open to all members of the Network.
- **Coordinator forum**: a group Activity Conversation restricted to the Network's coordinators.

---

## Tag

**Tags** serve two distinct purposes:

1. **Search and filter**: users can search buttons by tag across a Network
2. **Notifications**: users can subscribe to tags in their settings and receive email notifications when new buttons with those tags are created

Tags are free-form — anyone can create a tag when posting a button. Network coordinators can suggest or feature preferred tags in the Network's configuration.

---

## How they fit together

```
Server
└── Network (e.g. "Barrio Lavapiés")
    ├── ButtonTemplate: "Offering"
    ├── ButtonTemplate: "Requesting"
    ├── ButtonTemplate: "Event"
    │
    ├── Button: "Tomatoes to share"  [type: Offering, owner: user_A]
    │   └── Feed: [message from user_B, reply from user_A, ...]
    │
    ├── Button: "Need a ride to Madrid" [type: Requesting, owner: user_C]
    │   └── Feed: [...]
    │
    └── Users: [user_A, user_B, user_C, ...]
        └── Tags subscriptions, roles, profiles
```

Each installation runs one Network. Installations can federate with other servers, sharing users and content. Buttons can be shared across federated Networks that use the same ButtonTemplate.

---

For the technical detail — database columns, TypeScript interfaces, API endpoints — see [Architecture](6architecture.md).
