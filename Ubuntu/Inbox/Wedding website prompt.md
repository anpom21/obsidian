

---
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
Menu is fixed
Should guests see the full menu before the wedding?
No only at the wedding
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
Yeah sounds good

Should there be a “secret menu” or do you want everything public?
There should be room for a secret menu

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

Give me a fun playful idea that you can think off i want you to be creative here and sell the idea to me.

---

# 8. Photo-taking/upload page

This is a full technical subsystem.

## 8.1 Capture method

Do you want guests to take pictures directly in the browser camera?
Yes
Or upload existing photos from their camera roll?
Both
Best practical version: support both.
YES
Should the page open camera immediately?
Sure
Should users be able to select multiple photos?
Yes
Should videos be allowed?
Yes
Should Live Photos be supported? Usually they become still images unless handled specially.
Yes lets handle them, so both the video and the image is uploaded, separately
Should uploads be compressed client-side?
Yeah just slightly.
Should EXIF metadata be stripped for privacy?
Yes
Should timestamps be preserved?
Yes

Should anonymous uploads be allowed?
Yes
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
Home server.

Do you have a domain name?
Not yet.
Do you have HTTPS?
I want it, but maybe not required, is it hard to get?
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
Python would be lovely, if the beautiful website can be achieved there, otherwise choose whatever that will bring the prettiest website.

Where should files be stored?

```
Local filesystem
S3-compatible storage
Backblaze B2
MinIO on your server
Google Drive
Nextcloud
```
Local filesystem on home server.

If local filesystem:

```
/data/wedding/photos/originals
/data/wedding/photos/compressed
/data/wedding/photos/pending
/data/wedding/photos/approved
```
`/data/wedding/photos/originals/<timestamp>`


How much storage do you expect?
i have 100 gb ready so should be plenty


Should upload size be limited?
no
Should upload rate be limited?

Should uploads continue if the phone locks? Usually not reliably in browser.
No
Should the app show upload progress?
YES
Should failed uploads retry?
Yes
Should there be QR codes on tables linking directly to upload page?
Sure!
## 8.3 Moderation/gallery

Should uploaded photos be immediately visible to guests?
Yes

Should there be a live slideshow?
Yes
Should you approve photos before public display?
No
Can guests delete their own uploaded photos?
No
Should admins be able to delete/hide photos?
YES
Should you be able to download all photos as ZIP?
Yes
Should photos be grouped by uploader, table, timestamp, or event moment?
Timestamp
Should there be a post-wedding gallery?
Yes
Should guests be able to download photos later?

Should uploads require consent text?
YES
Example:

```
By uploading, you allow us to store and use these photos privately for wedding memories.
```



# 11. Bordplan / table plan

This is another real data model.

## 11.1 What guests see

Should guests only see their own table?
Yes
Or the full seating chart?
Yes
Should they search their name?
Yes
Should there be a QR code at the entrance opening the table plan?

Should the table plan be visible before the wedding?
No
Should it be hidden until the day?
Yes
Should guests be able to see who is at their table?
Yes
Should they be able to see the full room layout?
Yes

# 12. Missing likely pages/features

Your current list is good, but I would question whether you also need these.


## 12.2 Practical information page

Do guests need:

```
Venue address
Parking
Transport
Taxi numbers
Accessibility
Contact person
Gift info
```
These should be implemented
## 12.3 Location page

Should there be a page with:

```
Ceremony location
Reception location
Parking map
```

## 12.4 Contact page

Should guests contact you, or should they contact toastmaster/best man/maid of honor?
Contact me untill the day of the wedding it should change to my best man
Should the contact page show phone numbers?
Yes
Should contact info be hidden behind guest access?
Yes

## 12.6 Gifts/wishes page

Do you want a wish list?
Yes just show a nice page with a big link to ønskeskyen.
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

Sure


---

# 13. Admin dashboard

You probably need one.

What should admins manage?

```
Guests
Dietary restrictions
Singles profiles
Photo uploads
Timeline
Menu
Drinks
Table plan
Page content
Site settings
```

Should admin changes require code deployment, or should you edit everything in a UI?
Simple easy to maintain UI would be nice.
Do you want a CMS-like admin panel?
What is that
Would editing YAML/JSON files be acceptable?
PLENTY fine!!
Given your technical profile, a simple file-backed admin system may be fine, but RSVP/photo/song voting need a database.

Do you want audit logs?
What is this for?
Should admin actions be reversible?
Yes
Do you want export buttons?
Nah
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
Dietary restrictions
Photos
Relationship/single status
```

How long will you keep it?

Should guests be able to request deletion?

Should you have a simple privacy note?
YES
Should photos be private?

Should the singles page be accessible after the wedding?
NO
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
at my home

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

Not experience on frontend, just do whatever will make it the most proffesional looking
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
Django or FastAPI

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

Havent worked much with webiste backends so do what you trust, idont have https, is it hard to get?
## 15.3 Database

What database?

```
SQLite
PostgreSQL
MariaDB
MongoDB
```
SQL sounds good.


For this scope, SQLite is probably enough unless you expect heavy concurrent uploads/voting.

Do you want database backups?

How often?

Where should backups go?

## 15.4 File storage

Local server filesystem or object storage?
Local file server.
Should uploaded files be accessible through public URLs?
yes
Should photo URLs be signed/private?
no
Should image thumbnails be generated?
yes
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
No
Do you want to expose your home server publicly?
No
Should Cloudflare Tunnel be used?
Sounds good
Do you want daily backups?
No
Do you want uptime monitoring?
No

---

# 16. Data model discovery

At minimum, I see these entities:

```
Guest
PageContent
SinglesProfile
PhotoUpload
TimelineEvent
Table
SeatAssignment
MenuItem
DrinkItem
AdminUser
```

Questions:

Should every action map to a guest?
No
Can anonymous users upload photos?
No




Can one uploaded photo belong to multiple tags?
yes

---


# 21. MVP vs nice-to-have

Which features are must-have for launch?

I would split like this:

## MVP

```
Main page
Timeline
Table plan
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

/singles
  singles overview

/singles/signup
  self-signup form

/singles/[profile]
  optional profile detail

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

