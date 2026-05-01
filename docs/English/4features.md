# Features

Helpbuttons is a feature-rich platform for geo-based community cooperation. Below is a full overview of what it offers out of the box.

For a deeper explanation of how these features work together, see [Core Concepts](concepts.md).

---

## Buttons (posts)

### Basic structure
Every Button has: title, location, description, type, tags, and images. The type and any extra fields are defined by the Network's ButtonTemplate.

### Geolocation
Buttons are tied to a geographic location. Users can search by place, browse on a map, or filter by distance. Results display on map and list simultaneously.

### Hide exact location
Users can publish a button with an approximate area instead of an exact point, preserving privacy while still enabling location-based discovery.

### Multiple images
Upload multiple images per button. They display as a gallery on the button page.

### Events
Adding a date to a button turns it into an event. Events can be listed chronologically, and they expire automatically after their date passes. Recurring dates are also supported.

### Price and currency
Users can add a price to a button. A price of `0` displays a "Free" badge. "Price on request" is also an option. Currency is typed freely (e.g. EUR, USD). No currency conversion is provided.

---

## Modular button templates

The defining characteristic of Helpbuttons is the **ButtonTemplate** system. Network admins define button types with custom fields: date, price, boolean, list, or any field type the community develops. This makes the same codebase work for food sharing, transport, skill exchange, emergency coordination, or any other use case.

Examples of custom fields: departure/destination (transport), quantities and food type (food sharing), duration and skill level (skill exchange), event capacity (events).

---

## Maps and exploration

### Map views
The Explore page offers multiple views:
- **Map + list**: pins on the map, summary list alongside
- **Honeycomb zones**: buttons grouped by geographic area, click to expand
- **List only**: for text-heavy browsing or low-bandwidth use

### Deep URL routing
The map state (zoom, lat/lng, selected button) is encoded in the URL, making it fully shareable and linkable.

### Map styles and key locations
Admins can change the map's visual style (tile layer) to match the network's identity or improve readability. They can also define **key locations** — named places pinned on the map with a special marker, useful for community landmarks, meeting points, or points of interest.

### Embeddable map
Networks can embed a read-only map widget on external websites using an **iframe**. The embed respects the network's configuration and can be filtered by tag or button type.

### Social media feed
Networks expose a public **RRSS feed** (RSS/Atom) of recently published buttons. Communities can pipe this into social media channels, newsletters, or aggregator tools to keep followers updated without requiring them to visit the platform.

### PDF bulletin
Admins can export a **PDF bulletin** of buttons currently published in the Network. This is useful for printing and distributing in physical spaces — noticeboards, community centers, assemblies — reaching people who may not use digital tools.

---

## Communication

### Button feed (public messages)
Every button has a feed — a conversation thread where users can leave messages, updates, and coordination notes. Visible to all participants.

### Private messages
Users can reply privately in a button's feed. Only the button owner and the message author can see private replies.

### Group messaging
Users can exchange messages in group conversations, independent of specific buttons.

---

## Tags

### Tag creation and search
Users create tags when posting buttons. Tags are searchable and filterable across the Network.

### Tag subscriptions and notifications
Users can subscribe to tags in their settings. When a new button is created with a subscribed tag, they receive an email notification.

---

## Email notifications

Users can enable or disable email notifications for:
- New messages in their buttons' feeds
- New direct private messages
- New buttons created with subscribed tags
- Button status changes

---

## User profiles

### Public or private profile
Users can choose to show or hide their buttons on their public profile page. A public profile with a list of buttons can serve as a personal sharing page.

### Phone contact
Users can add a phone number to their profile, enabling direct calls, WhatsApp, and Telegram links from other users.

### Follow buttons
Users can follow other users' buttons to receive updates on changes and owner messages.

### Reputation via endorsements
There is no star rating. Users can endorse (support) each other — a social trust signal rather than a numerical score.

---

## Moderation and administration

### Decentralized administration
Network owners can assign any number of additional admins. Admins can moderate, delete, and block content or users. Multiple admins distribute the workload and increase community trust.

### User blocking
Admins can block users within a Network or globally. Blocked users cannot rejoin.

### Invitation-only networks
Admins can set a Network to private. Visitors can see buttons but cannot interact without an invitation. Invitation links can be limited by number of uses and expiration time.

---

## Network customization

### Appearance
Admins can customize: colors, logo/avatar, name, description, preferred tags, button types, map view defaults, and language.

### Location and radius
Each Network has a home location and a geographic radius that sets the default map view.

### Custom domain support
If your network is hosted on the team's server at helpbuttons.org, you can use a custom domain (e.g. `coopera.mibarrio.org`).

---

## Federation

If two Networks federate, users can move between them with the same credentials and content can be shared across instances. This is the building block for a decentralized, inter-connected ecosystem of communities. See [Philosophy](2philosophy.md) for more context on why this matters.

---

## Internationalisation

The platform ships with support for: **English, Spanish, Catalan, Basque, Portuguese**. Additional languages can be added by translating the locale files in `api/locales/` and `web/public/locales/`.




