# Pages

A visual walkthrough of the main screens in a Helpbuttons Network. Screenshots are taken from a live community network — "Vecinos del Campillín" — used as an example.

---

## User pages

### Home

![Home hero](../images/screencaps/1_home_a.jpg)

The top of the home page shows the network's name, tagline, and background image — all set by the admin. Three main actions are always visible: **Explore**, **Publish**, and **Share**. Below the hero, a summary card shows how many buttons and users are active, followed by all available button types as quick-access chips.

![Home tags and info](../images/screencaps/1_home.jpg)

Scrolling down reveals the most-used tags across the network (useful for discovering what topics are active), the admin's curated list of recommended tags, and a section showing the administrators and assistance contacts. First-time visitors use this page to understand what the community is about before registering.

---

### Explore

![Explore page](../images/screencaps/2_explore.jpg)

The main view of the Network. Buttons appear as pins on the map and as summary cards in a list alongside it. Button type filters are pinned at the top, allowing quick narrowing by category. Clicking a zone on the map expands the buttons in that area. The URL encodes the current map state, making any view shareable as a direct link.

---

### Filters

![Filters panel](../images/screencaps/5_filters.jpg)

An overlay panel accessible from Explore. Users can filter buttons by date range (with a calendar picker), by location (search or drop a pin), or combine both. Filters apply to both the map and the list simultaneously.

---

### Publish a button

![Publish button form](../images/screencaps/2_crear_boton.jpg)

The button creation form. On the left, the user selects the button type — each type has a custom icon and colour defined by the admin. On the right, the standard fields: title, description, keywords (tags), images, and location. If the selected type has extra fields (date, price, etc.) they appear in this same form. The location field opens a map picker for precise or approximate placement.

---

### Button detail

![Button detail view](../images/screencaps/4_button_view.jpg)

The full page for a single button. Shows the button's image gallery, title, type, location, follower count, and the author's first message. The map remains visible on the right side, keeping geographic context. Users can follow the button to receive updates, message the owner, or leave public comments in the feed.

---

### Messages

![Messages — button conversation](../images/screencaps/2_messages.jpg)

Three-panel messaging view. The left column lists all conversations — button feeds, direct messages, system notices, admin forum, and community forum. The centre shows the active thread. The right panel displays the button card associated with the conversation, keeping context visible.

![Messages — community forum](../images/screencaps/3_group_chat_comunidad.jpg)

The **community forum** thread is a shared group chat open to all members of the network, independent of any specific button. Useful for general announcements, questions, and community conversation. The admin forum works the same way but is restricted to administrators.

![Messages — notifications and event feed](../images/screencaps/2b_messages.jpg)

The messages inbox also surfaces **system notices** (avisos) — automatic notifications such as button renewals, tag subscriptions firing, or new followers. When a notice is about an event button, the right panel shows the full event card including date, time, location, and price.

---

### Profile

![User profile](../images/screencaps/3_profile.jpg)

The user's public profile page. Shows their name, username, role badge (e.g. Administrator), and tabs for published, followed, and commented buttons. Admin users see quick-access buttons to edit their profile, configure the Network, access moderation, and log out.

---

### Share and community integration

![Share panel](../images/screencaps/01_compartir.jpg)

The sharing panel, accessible from the home screen. It provides two groups of actions:

**Invite people** — copy the registration link, or generate **printable invitation cards** with QR codes that people can scan to join the network directly, without needing to know the URL.

![Printable QR invitation cards](../images/screencaps/01_compartir_b.jpg)

The invitation card generator produces a print-ready PDF sheet of QR cards — multiple cards per page, ready to cut and hand out at events, noticeboards, or community spaces. Each card is a personal credential: scanning the QR lets the user log in to the network directly, with no email address or password required.

**Share network content** — print the current button list as a **PDF bulletin**, embed the network in an external website using an **iframe**, or subscribe to the network's **RSS feed** to follow new publications through any feed reader or social media tool.

![PDF bulletin preview](../images/screencaps/01_compartir_c.jpg)

The PDF bulletin export generates a paginated document listing current buttons with their title, type, description, location, and a QR code linking to each one. Useful for printing and distributing in physical spaces — community centres, noticeboards, assemblies — reaching people who may not use digital tools.

---

### FAQ / Legal

![FAQ page](../images/screencaps/15_faqs.jpg)

The public FAQ and legal information page. Displays the network's description ("What is this network?"), privacy policy, ethics policy, and cookie policy — all written by the admin in the network configuration. The page footer shows the Helpbuttons version and the Mozilla Public License.

---

## Network configuration (admin)

All configuration pages are reached from Profile → Configure your Network. Changes take effect immediately.

---

### Configuration overview

![Network config overview](../images/screencaps/6_network_config.jpg)

The top-level configuration panel. All settings are grouped into five sections: **Define the network** (name, description, location), **Privacy preferences**, **Appearance**, **Configure your network** (location, key places, tags), and **Supplementary information** (legal texts, contact). A single Save button at the bottom applies all changes.

---

### Privacy settings

![Privacy settings](../images/screencaps/6_network_privacy_settings.jpg)

Controls three key access policies:

- **QR-only registration** — when enabled, users can only register by scanning a QR invitation card, no open sign-up.
- **Moderation** — when enabled, all buttons submitted by non-admins are held for review before appearing on the map.
- **Anonymous registration** — allows users to join without an email address, useful for low-barrier community tools (comes with a spam risk warning).

---

### Appearance

![Appearance settings](../images/screencaps/7_customize_network.jpg)

Visual identity of the Network. Admins can rename what a "button" is called (singular and plural) so the interface speaks the community's language. Primary and secondary brand colours are set here (hex values). The network logo (400×400 px) and a background header image are uploaded in this section.

---

### Network location and key places

![Location and key places settings](../images/screencaps/10_location_network_settings.jpg)

Sets the geographic centre and default zoom level of the map — this is where the map snaps to every time someone opens the network. Admins can define **key locations** (named landmarks visible as special markers on the map), toggle whether exact button locations are hidden by default, and set the network's recommended tags shown on the home page.

---

### Location picker

![Location picker modal](../images/screencaps/10_key_locations.jpg)

The location picker modal used when setting the network centre or adding a key location. Admins type an address or click on the map to place a pin, and adjust the default zoom level with a slider. Used both for the network's home location and for each individual key place.

---

### Button template list

![Button template list](../images/screencaps/8config_button_template_list.jpg)

The list of all button types defined for this Network. Each type shows its label, emoji icon, and colour band. Icons on the right indicate whether the type has extra fields (price, date, scheduler). Admins can edit any type or add new ones.

---

### Button template editor

![Button template editor](../images/screencaps/9_button_template_form.jpg)

The editor for a single button type. Admins set the type's name, icon (emoji), and colour. Below that, optional extra fields can be toggled on: **Add price** (enables buy/sell display), **Add date** (turns the type into an event type), **Add scheduler** (sets an automatic reactivation reminder). These extra fields appear in the publish form and as filters on the Explore page.

---

### Supplementary information

![Supplementary info](../images/screencaps/11_custom_faqs_fields.jpg)

The legal and contact section. Admins write the network's privacy policy and ethics policy in free-text fields. These texts are shown publicly on the FAQ page. A contact field allows publishing an email or phone number visible to all members.

---

## Moderation (admin)

### Moderation panel

![Moderation panel](../images/screencaps/12_moderation.jpg)

The moderation hub, accessible from the profile page. Sections: **Users** (manage accounts, block users), **Pending buttons** (buttons awaiting approval if moderation mode is on), **Published buttons** (full searchable list of all live buttons), **QR Invitations** (generate and manage invite codes), **Admin communications** (broadcast messages to the community).

---

### Button moderation list

![Moderation button list](../images/screencaps/13_moderation_buttons.jpg)

A searchable table of all published buttons. Each row shows the title, type badge, tags, time since posting, and author. Admins can open any button from here to review, edit, or remove it.

---

### QR invitations

![QR invitations](../images/screencaps/14_diginvites_menu.jpg)

Generates invitation cards with optional expiry dates (day, week, month, or never). Each card is rendered as a QR code and a plain URL. The QR acts as a personal credential — scanning it logs the user into the network directly, with no email address or password required. Cards can be printed and distributed physically or shared digitally.
