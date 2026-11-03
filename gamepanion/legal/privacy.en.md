# Data privacy

This explains which personal data gamepanion.app processes and why, as required by the GDPR (DSGVO). Last updated: 3 November 2026.

## Controller (Verantwortlicher)

Marcel Bruckner, Germany; the postal address is in the [legal notice](https://marcelbruckner.de/impressum). Email: [privacy@gamepanion.app](mailto:privacy@gamepanion.app). No data protection officer is appointed, as none is required.

## Hosting

Gamepanion runs on a server of Hetzner Online GmbH, Industriestr. 25, 91710 Gunzenhausen, Germany, in a data centre in Germany. Hetzner stores the data on my behalf under a data processing agreement (Art. 28 GDPR). Requests reach the server directly, with no other company in between.

The domain gamepanion.app is registered with Cloudflare, Inc. (USA), which also answers DNS queries for it. That is the lookup of the server's address; Cloudflare sees the address of the resolver that asks, not yours, and no request to the site passes through Cloudflare.

## Your account

**What:** your e-mail address; a short-lived sign-in code sent to it; if you add one, a passkey (its public key and the name of the device; the private key never leaves your device); your sessions (when they started and end, with neither your IP address nor your browser); the AI assistants you connected (their name and the address they sign in from) and their tokens; your language.

**Why and legal basis:** to sign you in and keep your log yours alone (Art. 6 (1) (b) GDPR).

**Retention:** as long as the account exists. A sign-in code is valid for a few minutes.

## What you file

**What:** what you tell Gamepanion about your games, yourself or through an AI assistant: games and playthroughs and their settings, play sessions with your words as you said them, quests, items, your build, notes, plans, tags and the sources you keep for a game.

**Why and legal basis:** to keep track of your games for you (Art. 6 (1) (b) GDPR). Nobody else on gamepanion.app sees it, and it is not used for anything else.

**Retention:** until you delete it, or your account. To delete your account and everything in it, write to [privacy@gamepanion.app](mailto:privacy@gamepanion.app) from the address you sign in with.

## Backups

So that a failure does not lose your log, copies are made of the databases (your account and what you filed; your subscription once you have one):

- every hour, kept on the same server for 1 day;
- every day, kept on the same server for 30 days;
- every day the newest daily copy, encrypted on the server before it leaves it, to a storage space at Hetzner that is separate from the server (Hetzner Storage Box, Germany), kept up to 29 days;
- every day a snapshot of the whole server, made and kept by Hetzner for 7 days.

A backup is not changed after it is made, so what you delete is still in the backups made before. It is gone from the last of them after 31 days at most. Backups are stored in Germany, are read only to bring the service back after a failure or a mistake, and are never used to bring back something on request: what you delete stays deleted. The legal basis is my legitimate interest, and my duty, to keep the service and your data available (Art. 6 (1) (f), Art. 32 GDPR).

## Your AI assistant

When you connect an AI assistant (such as Claude) to Gamepanion, it reads and writes your log on your behalf. What it reads goes to that assistant's provider under your own agreement with them; Gamepanion only answers the assistant you connected and signed in.

## The chat on gamepanion.app

**What:** when you use the chat in the web app, your messages and the parts of your log they need are sent to Anthropic, PBC (548 Market Street, San Francisco, CA 94104, USA), which runs the AI model that answers. The conversation is kept in your browser only, not on the server.

- **On Gamepanion's AI** (the plan with Gamepanion's AI): Anthropic processes them on my behalf under its commercial terms and data processing addendum (Art. 28 GDPR). The transfer to the USA is covered by the EU standard contractual clauses in that addendum (Art. 46 (2) (c) GDPR). Under those terms Anthropic does not train its models on them. Gamepanion counts how much of the monthly allowance you used (tokens and minutes of speech, per month), and nothing else about the conversation.
- **On your own Anthropic key:** the chat runs under your own agreement with Anthropic. Your key is stored encrypted and is never shown again; you can remove it on your account page at any time.

**Speaking into the chat:** your recording is turned into text by a speech-to-text service on the same server (no third party). The recording is not stored; the text becomes your message.

**Why and legal basis:** to answer what you ask in the chat (Art. 6 (1) (b) GDPR).

## Subscription and payment

**What:** a subscription is paid for through Creem (creem.io; Armitage Labs OÜ, Estonia), which is the seller of record and collects your payment and contact data (name, e-mail address, country, payment details) itself, under its own privacy policy. To start the checkout, Gamepanion gives Creem your e-mail address and your account's identifier. It receives from Creem only what the subscription needs: that it exists, which plan it is, whether it is paid and until when, and Creem's references for it and for you, so that "Manage subscription" opens your own customer portal.

**Why and legal basis:** to provide the subscription you bought (Art. 6 (1) (b) GDPR) and to keep the records the law requires, which Creem keeps as the seller.

**Retention:** as long as your account exists, so that a lapsed subscription can be taken up again. It is part of the backups described above.

## Server logs and IP addresses

**What:** for every request the web server logs the time, the method, the path with the names and ids in it replaced by placeholders, the status code and a shortened IP address: its last part is removed before the line is written, so it names a network of many connections, not yours. Your full IP address, your browser's user agent, cookies and query strings are not logged. Gamepanion's own log never holds what you filed, your e-mail address or your IP address.

**Why and legal basis:** to keep the service secure and to find and stop abuse (Art. 6 (1) (f) GDPR, legitimate interest).

**Retention:** 14 days, then the logs are deleted.

Separately, your IP address is used in memory to limit how often sign-in can be tried (same legal basis). It is kept for about a minute and is never written to disk.

## E-mail

**What:** the sign-in codes are sent from noreply@gamepanion.app, and mail to an address at gamepanion.app is received, through the mail servers of STRATO GmbH (Otto-Ostrowski-Straße 7, 10249 Berlin, Germany). If you write to me, your message with your address is stored there.

**Why and legal basis:** to sign you in (Art. 6 (1) (b) GDPR), and to read and answer what you wrote (Art. 6 (1) (f) GDPR, legitimate interest; Art. 6 (1) (b) if it is about a contract).

**Retention:** a sign-in mail is not kept by me. Your messages: until the matter is settled, and longer only where the law requires keeping business mail.

## Cookies and storage in your browser

A cookie keeps you signed in, and one remembers your language. Both are strictly necessary for the service you asked for (§ 25 (2) no. 2 TDDDG), so no consent is needed. The chat's conversation is kept in your browser's local storage, so that it is still there when you come back; it never leaves your device except as messages you send, and clearing the site's data in your browser removes it. There are no analytics, advertising or third-party requests, and nothing is loaded from external servers.

## Recipients and automated decisions

Your data is passed on only to those named above: Hetzner (hosting and backups), STRATO (e-mail), Anthropic (the chat, when you use it) and Creem (when you subscribe). There is no automated decision-making or profiling.

## Your rights

You have the right to access (Art. 15), rectification (Art. 16), erasure (Art. 17), restriction of processing (Art. 18), data portability (Art. 20) and to object to processing based on legitimate interest (Art. 21 GDPR). You can correct and delete what you filed yourself. For anything else, write to [privacy@gamepanion.app](mailto:privacy@gamepanion.app). I will answer within one month.

You also have the right to lodge a complaint with a supervisory authority. For me that is the Bavarian State Office for Data Protection Supervision (Bayerisches Landesamt für Datenschutzaufsicht), Promenade 18, 91522 Ansbach, [www.lda.bayern.de](https://www.lda.bayern.de).
