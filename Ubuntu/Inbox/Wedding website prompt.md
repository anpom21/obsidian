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
