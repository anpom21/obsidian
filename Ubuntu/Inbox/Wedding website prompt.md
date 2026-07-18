Question me relentlessly on this plan. Investigate each path in the domain tree to discover all feature requirements. 

We want to make a website for our wedding, in an engineer she is a nurse. We want a page for the following.  
- Main screen  
- personalised invitation screen  
- a singles page for the boys, girls, women and men. People should sign up themselves as singles in order for them to be featured on the page.  
- There should be a dress code page  
- menu page  
- drinks page  
- page for taking pictures through the phone, and save on my server  
- playlist voting page (vote on our top 300 songs or add a new one)  
- timeline page?  
- bordplan

Below is the domain tree I would interrogate before building anything. I am going to treat this like a product spec, not a “nice wedding page,” because your feature list already implies guest identity, permissions, uploads, voting, moderation, and server-side storage.

0. Core product questions

What is the website’s primary purpose?

Is it mainly:

1. information hub,
2. RSVP/invitation system,
3. party interaction platform,
4. memory/photo collection system,
5. matchmaking/social fun feature,
6. all of the above?

Who is the site for?

Guests only, or also non-guests who may see public info?

Should the website be public, invite-link-only, password-protected, or personalized per guest?

Do you want this to feel elegant and wedding-like, funny and playful, practical, or engineer/nurse themed?

Do you want Danish only, English only, or both?

Do you want it mobile-first? I assume yes, but should desktop also look polished?

Will guests use it before the wedding, during the wedding, or after the wedding?

Which pages must work offline or under bad mobile reception at the venue?

  

1. Guest identity and access

This is the root decision. Many other features depend on it.

1.1 Guest model

Do you have a guest list already?

Should each guest have an individual profile in the system?

Should couples/families be grouped into one invitation?

Should children be listed separately?

Do guests have unique invitation links?

Example:

0) all of the above
 One shared password for all
 Theme should be elegant, playful, nurse and engineer themed. Danish only. Mobile first, desktop should be functional but not a priority. Guests can use it before , during and after. Wifi access is required to use it.
1) 
All use one shared password, being the wedding date. No personal invites. 
Yea the guest list should be saved in a google sheets which can be edited by admins. 
Guests should not be able to see other guests  

2)  main page
Beautiful landing page with count down, which turns into something else on the official day.
Have some nice images which it switches between. Have photo upload button for like sending a cute message. 

# 3. Personalized invitation screen

This has many hidden requirements.

## 3.1 Invitation content

Should every guest see their own name?

Example:

```
Dear Anna,
we would love to celebrate our wedding with you...
```

Should the wording differ between family, friends, colleagues, formal guests?

Should language differ per guest?

Should guests see who they are invited with?

Example:

```
You are invited together with Mikkel and the kids.
```

Should plus-ones be supported?

Can guests enter a plus-one name?

Can guests change plus-one later?

Should guests be able to decline?

Should they be able to RSVP partially? Example one person in a family attends, another does not.

## 3.2 RSVP

Do you want RSVP on the invitation page?

Fields:

```
Attending: yes/no/maybe
Number of guests
Dietary restrictions
Allergies
Need accommodation help
Need transport help
Song request
Message to couple
```

Should RSVP have a deadline?

Should guests receive confirmation after RSVP?

Should you receive email notifications?

Should guests be able to edit their RSVP after submission?

Should there be an admin dashboard to see RSVPs?

Should RSVP data export to CSV/Excel?

Do you need meal choices per guest?

Do you need separate ceremony/reception attendance?

Example:

```
Ceremony: yes/no
Dinner: yes/no
Party: yes/no
Brunch next day: yes/no
```

## 3.3 Invitation design

Do you want the personalized invitation to look like a digital card?

Should it have envelope animation?

Should it be printable?

Should it include calendar download links?

Should it include Google Maps / Apple Maps links?

Should it include accommodation info?

Should it include gift registry / wish list / MobilePay info?

Do you want a “save the date” version before the full invitation?

---

# 4. Singles pages: boys, girls, women, men

This is the most socially sensitive feature. It needs careful definition.

## 4.1 Concept and tone

What is the goal?

Is it:

1. funny icebreaker,
2. actual matchmaking,
3. bachelor/bachelorette-style joke,
4. “meet other guests” feature,
5. party game?

Mostly funny icebreaker for the singles. So they can make their own profile which includes 3 things:
- An image
- A short description/ icebreaker / interest 
- Instagram handle (optional)
When they have signed up they will be given some keyword they can use to log in to the singles page AND change their own profile. Example key word funniest-wingman-23, or best-toastmast-58 or some combination of adjective and wedding/ party person role so it is easy to remember. 

## 4.2 Signup flow

What does “sign up themselves as singles” mean?

Should they click:

```
Feature me on the singles page
```

What fields should they provide?

Possible:

```
Name
Age
Photo
Short bio
Relationship status
Looking for: men/women/anyone/friends/no preference
Fun fact
Table number
Instagram
Phone number
Consent checkbox
```

Should photos be required?

Should submitted profiles require admin approval before appearing?

Can guests edit or delete their profile?

Can guests report profiles?

Should you allow joke submissions about other people? I recommend no.

Should the page display contact details, or only fun bios?

Should guests be able to “like” someone?

Should there be private messaging? I would probably avoid this.

Should there be categories:

```
Single men
Single women
Single guests
Open to dance
Needs beer-pong partner
```

instead of boys/girls/women/men?

## 4.3 Safety/privacy

Should the singles page be indexed by Google? It must not be.

Should profile photos be protected?

Should guests have to accept that their profile is visible to other wedding guests?

Should profiles automatically disappear after the wedding?

Should the entire singles feature be disabled after the wedding?

Should you keep or delete this data later?

---

# 5. Dress code page

What is the dress code?

Do you already have a phrase?

Examples:

```
Formal
Black tie optional
Cocktail
Summer formal
Garden party
Semi-formal
Festive formal
Smart casual
```

What should the page contain?

```
Dress code title
Explanation in plain language
Examples for men
Examples for women
Color palette
What not to wear
Weather notes
Shoe advice
Venue surface advice
Cultural/religious notes
FAQ
```

Should it be split by gender, or be more general?

Should you include inspiration photos?

Should you include colors to avoid? White, cream, bridal colors?

Should you include “no jeans,” “no sneakers,” “no shorts,” etc.?

Should guests be encouraged to wear certain colors?

Do you want an engineer/nurse themed joke here, or keep it elegant?

Should it include weather contingency?

Example:

```
The ceremony is outside, so bring a jacket if it gets cold.
```

Should there be a practical note about shoes if there is grass, gravel, sand, or cobblestone?

---

# 6. Menu page

Is the menu fixed, or will guests choose?

Should guests see the full menu before the wedding?

Should the menu page include:

```
Welcome snack
Starter
Main course
Dessert
Late-night snack
Wedding cake
Vegetarian option
Vegan option
Children’s menu
Allergens
```

Should allergens be explicit?

Should dietary restrictions be collected on RSVP and used by catering?

Should each guest see their assigned meal?

Should there be a “secret menu” or do you want everything public?

Should the menu page also cover coffee, cake, midnight food, breakfast/brunch?

Should it include supplier/caterer name?

Should it be elegant prose or just practical?

Should the menu change based on guest dietary restrictions?

---

# 7. Drinks page

What is the purpose of the drinks page?

Is it informational, interactive, or playful?

Possible features:

```
Bar menu
Signature cocktails
Wine list
Beer list
Non-alcoholic options
Drinking rules/games
Open bar hours
Payment info
Last call
Water station info
Coffee/tea info
```

Will there be signature drinks named after you?

Should guests vote on signature cocktails before the wedding?

Should guests be able to suggest drinks?

Should the drinks page include alcohol-free options prominently?

Should it include taxi/transport/safety info?

Should it include allergens? Example nuts, dairy, citrus.

Should there be a “nurse warning” joke about hydration?

Should there be an “engineer-approved ethanol delivery system” joke, or is that too much?

---

# 8. Photo-taking/upload page

This is a full technical subsystem.

## 8.1 Capture method

Do you want guests to take pictures directly in the browser camera?

Or upload existing photos from their camera roll?

Best practical version: support both.

Should the page open camera immediately?

Should users be able to select multiple photos?

Should videos be allowed?

Should Live Photos be supported? Usually they become still images unless handled specially.

Should uploads be compressed client-side?

Should original quality be preserved?

Should EXIF metadata be stripped for privacy?

Should timestamps be preserved?

Should uploaded photos be associated with a guest identity?

Should anonymous uploads be allowed?

## 8.2 Storage

You said “save on my server.”

Where exactly?

```
VPS?
Home server?
NAS?
Raspberry Pi?
Cloud VM?
Docker host?
```

Do you have a domain name?

Do you have HTTPS?

What backend stack do you prefer?

Possible:

```
Node/Express
Python/FastAPI
Django
Go
PHP
Static frontend + upload API
```

Where should files be stored?

```
Local filesystem
S3-compatible storage
Backblaze B2
MinIO on your server
Google Drive
Nextcloud
```

If local filesystem:

```
/data/wedding/photos/originals
/data/wedding/photos/compressed
/data/wedding/photos/pending
/data/wedding/photos/approved
```

Do you need backups?

How much storage do you expect?

Example rough calculation:

```
100 guests × 30 photos × 4 MB = 12 GB
100 guests × 10 videos × 50 MB = 50 GB
```

Should upload size be limited?

Should upload rate be limited?

Should uploads continue if the phone locks? Usually not reliably in browser.

Should the app show upload progress?

Should failed uploads retry?

Should there be QR codes on tables linking directly to upload page?

## 8.3 Moderation/gallery

Should uploaded photos be immediately visible to guests?

Or saved privately for you?

Should there be a live slideshow?

Should you approve photos before public display?

Can guests delete their own uploaded photos?

Should admins be able to delete/hide photos?

Should you be able to download all photos as ZIP?

Should photos be grouped by uploader, table, timestamp, or event moment?

Should there be a post-wedding gallery?

Should guests be able to download photos later?

Should uploads require consent text?

Example:

```
By uploading, you allow us to store and use these photos privately for wedding memories.
```

## 8.4 Technical risk

What happens if the server goes down during the wedding?

Do you need a fallback QR code to Google Photos/Drive?

Do you want automatic monitoring?

Do you want local venue Wi-Fi?

Do you expect poor mobile coverage?

Should the page be optimized for iPhone Safari and Android Chrome?

Do you need HEIC support?

Do you need server-side conversion from HEIC to JPEG?

---

# 9. Playlist voting page

This also needs proper constraints.

## 9.1 Song database

You mention “our top 300 songs.”

Where does this list come from?

Spotify playlist?

CSV?

Manually entered?

YouTube?

Apple Music?

Should the page sync with Spotify?

Do you want to embed Spotify previews?

Do you want album art?

Fields:

```
artist
title
spotify_url
preview_url
album_art
genre
language
explicit
added_by
votes
```

Do you want guests to vote before the wedding, during the party, or both?

Should votes influence the DJ playlist?

Do you have a DJ?

Will the DJ actually use the exported list?

Should there be an export button?

## 9.2 Voting rules

How many votes per guest?

Options:

```
Unlimited
One vote per song
Max 10 total votes
Upvotes/downvotes
Rank top 5
```

Should people be able to remove their vote?

Should duplicate songs be prevented?

Should guests be able to add new songs?

Should added songs require approval?

Should guests be able to vote on newly added songs?

Should explicit songs be allowed?

Should joke songs be allowed?

Should there be a blacklist?

Should there be categories?

```
Dinner music
First dance
Party
Danish classics
Singalong
Do-not-play
```

Should there be a “ban this song” vote?

Could people abuse voting? Do you care?

Should voting be anonymous or visible?

Should guests see current rankings?

Should rankings be hidden to avoid herding?

Should the top 300 be searchable/filterable?

Should songs have preview playback?

Should there be a “random song battle” interface?

Example:

```
Which song should survive?
[Song A] vs [Song B]
```

## 9.3 Integration

Do you want to import from Spotify using Spotify API?

Do you have a Spotify developer account?

Should guests add songs by pasting Spotify links?

Should the backend normalize duplicates?

Example duplicate problem:

```
"Mr. Brightside"
"Mr Brightside - Remastered"
"The Killers - Mr. Brightside"
```

Should the playlist export back to Spotify automatically?

Should the site generate a final playlist ordered by votes?

---

# 10. Timeline page

The question mark matters. Decide whether this is informational or dynamic.

What timeline do you need?

Before wedding:

```
RSVP deadline
Hotel booking deadline
Ceremony time
Transport time
```

Wedding day:

```
Arrival
Ceremony
Reception
Dinner
Speeches
Cake
First dance
Party
Late-night snack
Bar closes
Transport home
```

After wedding:

```
Photo gallery
Thank-you note
```

Should the timeline be public?

Should it differ per guest group?

Example:

```
Family arrives earlier for photos.
Toastmaster sees speech schedule.
Regular guests do not see internal logistics.
```

Should the timeline update live?

Should it show “Now” during the wedding?

Should it show countdown to next event?

Should admins be able to modify it on the day?

Should it include locations per event?

Should it include maps between ceremony and venue?

Should it include transport information?

Should it include contact person for delays?

Should it support hidden/internal timeline items?

Example:

```
Photographer arrives
Bride/groom prep
Vendor setup
Speech order
```

Do you need separate timelines for:

```
Guests
Vendors
Wedding party
Couple
Toastmaster
```

---

# 11. Bordplan / table plan

This is another real data model.

## 11.1 What guests see

Should guests only see their own table?

Or the full seating chart?

Should they search their name?

Should there be a QR code at the entrance opening the table plan?

Should the table plan be visible before the wedding?

Should it be hidden until the day?

Should guests be able to see who is at their table?

Should they be able to see the full room layout?

Should the table names/numbers be themed?

Should the page support last-minute changes?

## 11.2 Admin table planning

Do you want the site to help create the table plan, or only display a finished plan?

If creating it:

```
Guests
Relationships
Groups
Must sit together
Should sit near
Should not sit together
Table capacity
Children
High chairs
Wheelchair access
Dietary meal placement
```

Should you import from spreadsheet?

Should you drag-and-drop guests between tables?

Should it validate capacities?

Should it export printable PDFs?

Should it generate place cards?

Should it integrate with menu/dietary restrictions?

If only displaying it:

```
Guest -> table number
Table -> list of names
Room map image
```

Should there be a graphical floorplan?

Do you have venue layout dimensions?

Should you upload an image of the room plan and overlay tables?

---

# 12. Missing likely pages/features

Your current list is good, but I would question whether you also need these.

## 12.1 RSVP page

Do you want RSVP as part of personalized invitation, or a dedicated page?

## 12.2 Practical information page

Do guests need:

```
Venue address
Parking
Transport
Taxi numbers
Hotel recommendations
Check-in info
Accessibility
Childcare
Contact person
Gift info
FAQ
```

## 12.3 Location page

Should there be a page with:

```
Ceremony location
Reception location
Map links
Parking map
Public transport
Walking directions
```

## 12.4 Contact page

Should guests contact you, or should they contact toastmaster/best man/maid of honor?

Should the contact page show phone numbers?

Should contact info be hidden behind guest access?

## 12.5 Speeches/entertainment signup

Do you need a page where guests can contact the toastmaster to give speeches or arrange entertainment?

Fields:

```
Name
Type: speech/song/game/video
Estimated duration
Needs projector/audio
Notes
```

Should this go directly to the toastmaster?

## 12.6 Gifts/wishes page

Do you want a wish list?

MobilePay?

Bank transfer?

Charity donation?

Honeymoon fund?

Should it be tasteful and optional?

## 12.7 FAQ page

Common questions:

```
Can I bring a plus-one?
Can I bring children?
Where do I park?
What should I wear?
When should I RSVP?
Can I take photos during the ceremony?
Can I post on social media?
Who do I contact?
```

## 12.8 Countdown / after-party / accommodation

Do guests need hotel recommendations?

Do you need next-day brunch info?

Do you need transport home?

---

# 13. Admin dashboard

You probably need one.

What should admins manage?

```
Guests
RSVPs
Dietary restrictions
Invitations
Singles profiles
Photo uploads
Playlist songs
Song votes
Timeline
Menu
Drinks
Table plan
Page content
Site settings
```

Should admin changes require code deployment, or should you edit everything in a UI?

Do you want a CMS-like admin panel?

Would editing YAML/JSON files be acceptable?

Given your technical profile, a simple file-backed admin system may be fine, but RSVP/photo/song voting need a database.

Do you want audit logs?

Should admin actions be reversible?

Do you want export buttons?

```
Export RSVPs CSV
Export dietary restrictions CSV
Export playlist CSV
Download all photos
Export table plan
```

---

# 14. Data/privacy/legal questions

This matters because you will store personal data.

What personal data are you storing?

```
Names
Emails
Phone numbers
Dietary restrictions
Photos
Relationship/single status
Music preferences
Messages
```

How long will you keep it?

Should guests be able to request deletion?

Should you have a simple privacy note?

Should photos be private?

Should the singles page be accessible after the wedding?

Should uploaded images be used only privately?

Should there be consent checkboxes for:

```
RSVP data
Photo uploads
Singles page profile
Public gallery visibility
```

Should backups include personal data?

Who has server access?

Is the server in your home or a cloud region?

---

# 15. Technical architecture questions

## 15.1 Frontend

What stack do you want?

Good options:

```
Next.js
SvelteKit
Astro + API backend
Django templates
Laravel
Plain React/Vite + API
```

Do you want server-side rendering?

Do you care about SEO? Probably no, if private.

Do you want it installable as a PWA?

Should it look app-like on phones?

Should it support Danish characters, emojis, and special typography?

## 15.2 Backend

What backend are you comfortable maintaining?

```
FastAPI
Django
Node/Express
Next.js API routes
SvelteKit server routes
Go
```

Do you want Docker deployment?

Do you want one service or multiple?

Do you already have a reverse proxy?

```
Nginx
Caddy
Traefik
Cloudflare Tunnel
```

Do you already have HTTPS certificates?

## 15.3 Database

What database?

```
SQLite
PostgreSQL
MariaDB
MongoDB
```

For this scope, SQLite is probably enough unless you expect heavy concurrent uploads/voting.

Do you want database backups?

How often?

Where should backups go?

## 15.4 File storage

Local server filesystem or object storage?

Should uploaded files be accessible through public URLs?

Should photo URLs be signed/private?

Should image thumbnails be generated?

Should there be malware scanning? Probably not necessary, but file type validation is.

## 15.5 Deployment

Where will it run?

```
Home server
VPS
Hetzner
DigitalOcean
Cloudflare Pages + backend
Vercel
Netlify
```

Do you need it to survive home internet outage?

Do you want to expose your home server publicly?

Should Cloudflare Tunnel be used?

Do you want daily backups?

Do you want uptime monitoring?

---

# 16. Data model discovery

At minimum, I see these entities:

```
Guest
Invitation
RSVP
PageContent
SinglesProfile
PhotoUpload
Song
SongVote
TimelineEvent
Table
SeatAssignment
MenuItem
DrinkItem
AdminUser
```

Questions:

Should every action map to a guest?

Can anonymous users upload photos or vote?

Can one guest vote multiple times?

Can one invitation include multiple guests?

Can one guest have multiple dietary restrictions?

Can one song have many aliases?

Can one uploaded photo belong to multiple tags?

Should table assignments be per guest or per invitation group?

---

# 17. Permission model

Who can do what?

```
Public visitor
Invited guest
Guest with personal token
Singles participant
Admin
Toastmaster
DJ
Photographer
```

Questions:

Can DJ access playlist export only?

Can photographer access uploaded photos?

Can toastmaster access speeches/timeline but not singles profiles?

Can guests see table plan?

Can guests see menu?

Can guests upload photos without RSVP?

Can declined guests still access pages?

Can guests edit RSVP after deadline?

Can admins impersonate guests to debug invitations?

---

# 18. Content management

How will page content be edited?

Hardcoded in code?

Markdown files?

Admin UI?

Database?

Google Sheet?

YAML files?

For example:

```
content/
  main.md
  dress-code.md
  menu.yaml
  drinks.yaml
  timeline.yaml
```

Do you want your partner to be able to edit text without touching code?

Do you want version control?

Do you want preview before publishing?

---

# 19. Design/theme questions

What visual identity?

```
Elegant
Minimalist
Romantic
Playful
Technical
Medical/engineering references
Danish summer wedding
Classic formal
```

Colors?

Fonts?

Do you have invitation artwork already?

Should the website match physical invitations?

Should there be photos of you?

Should there be illustrations?

Should engineer/nurse theme be subtle or explicit?

Possible subtle theme:

```
“Designed with precision, cared for with love.”
```

Too cheesy, or good?

Should animations be minimal for performance?

Should the UI be accessible for older guests?

Large text mode?

High contrast?

Simple navigation?

---

# 20. Operational wedding-day questions

Who will maintain the site during the wedding?

Do you want to be debugging uploads at your own wedding? Hopefully no.

Should someone else have admin access?

What features are allowed to fail without ruining anything?

Critical:

```
Invitation
RSVP
Timeline
Location
Table plan
```

Fun but non-critical:

```
Singles page
Playlist voting
Photo upload
Drinks page
```

Should high-risk features be isolated so they cannot break core info pages?

Should static pages remain available even if the backend/database fails?

I would strongly recommend yes.

---

# 21. MVP vs nice-to-have

Which features are must-have for launch?

I would split like this:

## MVP

```
Main page
Personalized invitation
RSVP
Dress code
Menu
Drinks
Timeline
Table plan
Practical info/location
Admin guest import/export
```

## Interactive phase

```
Photo upload
Playlist voting
Singles signup/page
```

## Advanced/admin phase

```
Admin dashboard
Moderation
Spotify import/export
Live photo gallery
Table-plan drag/drop
Guest-specific timeline
```

Questions:

Which features must be ready before invitations are sent?

Which features can launch later?

Do you want the site to evolve from invitation site into wedding-day app?

Should hidden pages be activated closer to the date?

---

# 22. Suggested route structure

A possible domain tree:

```
/
  main landing page

/invite/[token]
  personalized invitation
  RSVP

/rsvp
  fallback RSVP entry

/info
  practical information

/location
  venue, maps, parking, transport

/dress-code
  dress code

/menu
  food menu

/drinks
  drinks/bar menu

/timeline
  wedding-day schedule

/table-plan
  guest table lookup / seating plan

/photos
  camera/upload page

/gallery
  approved photo gallery, optional

/playlist
  vote on songs

/playlist/add
  suggest song

/singles
  singles overview

/singles/signup
  self-signup form

/singles/[profile]
  optional profile detail

/speeches
  contact toastmaster / entertainment signup

/faq
  common questions

/admin
  dashboard

/admin/guests
/admin/rsvps
/admin/photos
/admin/playlist
/admin/singles
/admin/timeline
/admin/table-plan
/admin/content
```

Question: does that tree match your mental model, or do you want the site to be fewer pages and more app-like?

---

# 23. My strongest concerns

The singles page needs explicit consent and moderation.

The photo upload system needs robust server handling, file limits, backups, and mobile testing.

The playlist voting page needs anti-duplicate handling and clear voting rules.

The personalized invitation/RSVP system needs a clean guest data model before you build UI.

The table plan can become surprisingly complex if you want drag-and-drop planning rather than simple display.

The website should have a static/public-safe core that still works if all interactive features fail.

---

# 24. First answers I need from you

Start with these. They unblock the architecture.

1. Should guests have personal invite links, or one shared wedding password?
2. Do you need RSVP, or is the personalized invitation only informational?
3. Should one invitation support multiple people, like couples/families?
4. Should the site be Danish, English, or bilingual?
5. Where will the site be hosted?
6. What backend/frontend stack do you prefer?
7. Should photo upload support videos?
8. Should uploaded photos be public to guests, private to you, or moderated first?
9. Should singles profiles require admin approval before appearing?
10. Should playlist voting integrate with Spotify?
11. Do you want an admin dashboard, or are config files/spreadsheets acceptable?
12. Is the table plan only for display, or should the site help you build it?

My immediate recommendation: design the guest/invitation/permission model first. Everything else becomes much easier once you know who the user is, what they can access, and whether their actions are tied to a guest record.