# Detection catalog

Detailed before/after for every pattern in the quick-reference table in [SKILL.md](SKILL.md). Patterns 1–31 are AI tells (based on Wikipedia's "Signs of AI writing"). Patterns 32–38 are plain-voice tells — clever, performative, or workshopped writing that isn't always AI-generated but breaks the plain voice all the same.

## Content patterns

### 1. Significance inflation [HIGH]

**Words to watch:** stands/serves as, is a testament/reminder, a vital/significant/crucial/pivotal/key role/moment, underscores/highlights its importance, reflects broader, symbolizing its ongoing/enduring/lasting, contributing to the, setting the stage for, marking/shaping the, represents/marks a shift, key turning point, evolving landscape, focal point, indelible mark, deeply rooted

**Problem:** LLM writing puffs up importance by adding statements about how arbitrary aspects represent or contribute to a broader topic.

**Before:** The Statistical Institute of Catalonia was officially established in 1989, marking a pivotal moment in the evolution of regional statistics in Spain. This initiative was part of a broader movement across Spain to decentralize administrative functions.

**After:** The Statistical Institute of Catalonia was established in 1989 to collect and publish regional statistics independently from Spain's national office.

### 2. Notability emphasis [MED]

**Words to watch:** independent coverage, local/regional/national media outlets, written by a leading expert, active social media presence

**Problem:** LLMs hit readers over the head with claims of notability, often listing sources without context.

**Before:** Her views have been cited in The New York Times, BBC, Financial Times, and The Hindu. She maintains an active social media presence with over 500,000 followers.

**After:** In a 2024 New York Times interview, she argued that AI regulation should focus on outcomes rather than methods.

### 3. Superficial -ing phrases [HIGH]

**Words to watch:** highlighting/underscoring/emphasizing..., ensuring..., reflecting/symbolizing..., contributing to..., cultivating/fostering..., encompassing..., showcasing...

**Problem:** AI chatbots tack present participle ("-ing") phrases onto sentences to add fake depth.

**Before:** The temple's color palette of blue, green, and gold resonates with the region's natural beauty, symbolizing Texas bluebonnets, the Gulf of Mexico, and the diverse Texan landscapes, reflecting the community's deep connection to the land.

**After:** The temple uses blue, green, and gold. The architect said these reference local bluebonnets and the Gulf coast.

### 4. Promotional language [HIGH]

**Words to watch:** boasts a, vibrant, rich (figurative), profound, enhancing its, showcasing, exemplifies, commitment to, natural beauty, nestled, in the heart of, groundbreaking (figurative), renowned, breathtaking, must-visit, stunning

**Problem:** LLMs struggle to keep a neutral tone, especially for "cultural heritage" topics.

**Before:** Nestled within the breathtaking region of Gonder in Ethiopia, Alamata Raya Kobo stands as a vibrant town with a rich cultural heritage and stunning natural beauty.

**After:** Alamata Raya Kobo is a town in the Gonder region of Ethiopia, known for its weekly market and 18th-century church.

### 5. Vague attributions [HIGH]

**Words to watch:** Industry reports, Observers have cited, Experts argue, Some critics argue, several sources/publications (when few are cited)

**Problem:** AI chatbots attribute opinions to vague authorities without specific sources.

**Before:** Due to its unique characteristics, the Haolai River is of interest to researchers. Experts believe it plays a crucial role in the regional ecosystem.

**After:** The Haolai River supports several endemic fish species, according to a 2019 survey by the Chinese Academy of Sciences.

### 6. Challenges and prospects sections [MED]

**Words to watch:** Despite its... faces several challenges, Despite these challenges, Challenges and Legacy, Future Outlook

**Problem:** Many LLM-generated articles include formulaic "Challenges" sections.

**Before:** Despite its industrial prosperity, Korattur faces challenges typical of urban areas, including traffic congestion and water scarcity. Despite these challenges, Korattur continues to thrive.

**After:** Traffic congestion increased after 2015 when three new IT parks opened. The municipal corporation began a stormwater drainage project in 2022.

## Language and grammar patterns

### 7. AI vocabulary [HIGH]

**High-frequency AI words (all models):** Additionally, align with, crucial, delve, emphasizing, enduring, enhance, fostering, garner, highlight (verb), interplay, intricate/intricacies, key (adjective), landscape (abstract), pivotal, showcase, tapestry (abstract), testament, underscore (verb), valuable, vibrant

**Model-specific:** straightforward, nuanced, comprehensive, leverage, holistic, meticulous, navigate, ultimately, it's worth noting, I'd be happy to, let me [verb]

**Problem:** These words appear far more often in post-2023 text and tend to co-occur.

**Before:** Additionally, an enduring testament to Italian colonial influence is the widespread adoption of pasta in the local culinary landscape, showcasing how these dishes have integrated into the traditional diet.

**After:** Pasta dishes, introduced during Italian colonization, remain common, especially in the south.

### 8. Copula avoidance [MED]

**Words to watch:** serves as/stands as/marks/represents [a], boasts/features/offers [a]

**Problem:** LLMs substitute elaborate constructions for simple "is"/"are".

**Before:** Gallery 825 serves as LAAA's exhibition space for contemporary art. The gallery features four separate spaces and boasts over 3,000 square feet.

**After:** Gallery 825 is LAAA's exhibition space for contemporary art. It has four rooms totaling 3,000 square feet.

### 9. Negative parallelisms [MED]

**Problem:** "Not only...but..." or "It's not just about..., it's..." are overused.

**Before:** It's not just about the beat riding under the vocals; it's part of the aggression and atmosphere. It's not merely a song, it's a statement.

**After:** The heavy beat adds to the aggressive tone.

### 10. Rule of three [MED]

**Problem:** LLMs force ideas into groups of three to appear comprehensive.

**Before:** The event features keynote sessions, panel discussions, and networking opportunities. Attendees can expect innovation, inspiration, and industry insights.

**After:** The event includes talks and panels, with time for informal networking between sessions.

### 11. Synonym cycling [LOW]

**Problem:** Repetition-penalty behavior causes excessive synonym substitution.

**Before:** The protagonist faces many challenges. The main character must overcome obstacles. The central figure eventually triumphs. The hero returns home.

**After:** The protagonist faces many challenges but eventually triumphs and returns home.

### 12. False ranges [LOW]

**Problem:** "from X to Y" where X and Y aren't on a meaningful scale.

**Before:** Our journey has taken us from the singularity of the Big Bang to the grand cosmic web, from the birth and death of stars to the enigmatic dance of dark matter.

**After:** The book covers the Big Bang, star formation, and current theories about dark matter.

## Style patterns

### 13. Em dash overuse [MED]

**Problem:** LLMs use em dashes more than people do. (Unslop bans them outright — see SKILL.md formatting constraints.)

**Before:** The term is promoted by Dutch institutions—not by the people themselves. You don't say "Netherlands, Europe" as an address—yet this continues—even in official documents.

**After:** The term is promoted by Dutch institutions, not by the people themselves. You don't say "Netherlands, Europe" as an address, yet this continues even in official documents.

### 14. Boldface overuse [LOW]

**Before:** It blends **OKRs (Objectives and Key Results)**, **KPIs (Key Performance Indicators)**, and **Balanced Scorecard (BSC)**.

**After:** It blends OKRs, KPIs, and tools like the Balanced Scorecard.

### 15. Inline-header lists [MED]

**Before:**
- **User Experience:** The experience has been significantly improved.
- **Performance:** Performance has been enhanced through optimized algorithms.
- **Security:** Security has been strengthened with end-to-end encryption.

**After:** The update improves the interface, speeds up load times, and adds end-to-end encryption.

### 16. Title case headings [LOW]

**Before:** `## Strategic Negotiations And Global Partnerships`

**After:** `## Strategic negotiations and global partnerships`

### 17. Emojis [LOW]

**Before:** Launch Phase: The product launches in Q3 / Key Insight: Users prefer simplicity

**After:** The product launches in Q3. User research showed a preference for simplicity.

### 18. Curly quotes (some models) [LOW]

**Problem:** Some models emit curly quotes instead of straight ones. Model-dependent.

**Before:** He said "the project is on track" but others disagreed.

**After:** He said "the project is on track" but others disagreed. (straight quotes)

### 19. Hyphenated word-pair overuse [LOW]

**Problem:** AI hyphenates common compounds (cross-functional, data-driven, client-facing, well-established) with perfect consistency. The uniformity itself is the tell.

**Before:** Our cross-functional team uses a data-driven approach to deliver client-facing solutions with a well-established, future-proof methodology.

**After:** The team pulls from several departments. They decide based on usage data and build features customers interact with directly.

### 20. Persuasive tropes and signposting [MED]

**Words to watch:** The real question is, Let's dive in, Let's break this down, Here's the thing, What's really going on, The truth is, Let's unpack this, At the end of the day

**Before:** Let's dive into what's really going on with AI regulation. The real question isn't whether to regulate, it's how. Let's break this down.

**After:** AI regulation proposals differ mainly on enforcement. The EU opted for pre-market risk assessments; the US has leaned toward voluntary commitments.

### 21. Single quotes in prose [LOW]

**Before:** The CEO stated, 'This is our most important launch yet.' Critics called the product 'underwhelming.'

**After:** The CEO stated, "This is our most important launch yet." Critics called the product "underwhelming."

## Communication patterns

### 22. Collaborative artifacts [HIGH]

**Words to watch:** I hope this helps, Of course!, Certainly!, You're absolutely right!, Would you like..., let me know, here is a..., I'd be happy to, Let me [verb] that for you

**Before:** Here is an overview of the French Revolution. I hope this helps! Let me know if you'd like me to expand on any section.

**After:** The French Revolution began in 1789 when financial crisis and food shortages led to widespread unrest.

### 23. Knowledge-cutoff disclaimers [MED]

**Before:** While specific details about the company's founding are not extensively documented in readily available sources, it appears to have been established sometime in the 1990s.

**After:** The company was founded in 1994, according to its registration documents.

### 24. Sycophantic tone [HIGH]

**Before:** Great question! You're absolutely right that this is a complex topic. That's an excellent point about the economic factors.

**After:** The economic factors you mentioned are relevant here.

### 25. Post-action summaries [HIGH]

**Problem:** AI appends a paragraph restating what it just said. People don't recap their own paragraphs.

**Before:** The migration moved 12,000 records from PostgreSQL to DynamoDB over three days. Two tables needed schema changes. / In summary, the migration successfully transferred all records with schema modifications for two tables.

**After:** The migration moved 12,000 records from PostgreSQL to DynamoDB over three days. Two tables needed schema changes.

### 26. Unsolicited ethical caveats [MED]

**Before:** Web scraping can extract product prices using BeautifulSoup or Playwright. It's worth noting that web scraping raises important ethical and legal considerations, and you should always respect robots.txt.

**After:** Web scraping can extract product prices using BeautifulSoup or Playwright.

### 27. Second-person lock [MED]

**Before:** When you're building a distributed system, you need to think about consistency. You'll want to decide whether you need strong consistency or whether eventual consistency works for your use case.

**After:** Distributed systems force a decision about consistency models. Strong consistency simplifies application logic but limits throughput. Eventual consistency scales better but pushes complexity to the application.

### 28. Markdown overuse in prose [MED]

**Before:**
## Key Takeaways
- **Performance**: 3x faster
- **Reliability**: 99.9% uptime
### Next Steps
1. Monitor metrics

**After:** The new system is 3x faster and uptime improved to 99.9%. The team is monitoring production metrics before the next migration phase.

## Filler and hedging

### 29. Filler phrases [MED]

- "In order to achieve this goal" → "To achieve this"
- "Due to the fact that it was raining" → "Because it was raining"
- "At this point in time" → "Now"
- "The system has the ability to process" → "The system can process"
- "It is important to note that the data shows" → "The data shows"

### 30. Excessive hedging [MED]

**Before:** It could potentially possibly be argued that the policy might have some effect on outcomes.

**After:** The policy may affect outcomes.

### 31. Generic positive conclusions [MED]

**Before:** The future looks bright for the company. Exciting times lie ahead as they continue their journey toward excellence.

**After:** The company plans to open two more locations next year.

## Plain-voice tells (clever, performative, workshopped)

These aren't always AI-generated. They're the human ways writing turns clever or boastful and stops sounding plain.

### 32. Clever / writerly phrasing [HIGH]

**Problem:** Lines written to be quotable. Metaphors, "positioning" lines, turns of phrase a person wouldn't say out loud.

**Before:** My recent work sits right where you operate. Once you ship to real users, a slow rollback stops being theoretical.

**After:** I've been working on the same problems you have. I built a tool that rolls back a bad deploy in seconds, so a broken release doesn't stay live.

### 33. Swagger and commands [HIGH]

**Problem:** Claiming superiority, commanding the reader, performing confidence instead of stating facts.

**Before:** Give me 15 minutes and I'll show you exactly where I'd plug in. I'd back myself to add value fast.

**After:** Would you be open to a quick call to see if there's a fit? (State a real fact about your work; let it carry the confidence.)

### 34. Fake first-person authority [MED]

**Problem:** Vague lived-experience claims used to sound credible. Distinct from vague third-party attribution (#5) — this is fake *personal* experience.

**Before:** I've seen this play out time and again. I see this constantly with teams I work with.

**After:** On the last two projects I worked on, the same caching bug showed up both times. (Name the specific instance, or cut the claim.)

### 35. Clever comparative endings [MED]

**Problem:** Closing on a tidy contrast for effect.

**Before:** The worst engineers ship fast and break things. The best ship fast and fix them.

**After:** Shipping fast only works if you also budget time to fix what breaks.

### 36. Anaphora / stacked openings [MED]

**Problem:** Several sentences in a row sharing the same opening structure, for rhythm. ("More speed. More scale. More reach.")

**Before:** Higher output. Higher quality. Higher morale. That's what changed.

**After:** Output went up, the work got better, and the team was happier.

### 37. Rhetorical-question fragments [MED]

**Problem:** One-word or fragment questions asked for effect. "The reality?" "Why does this matter?" "And honestly?"

**Before:** The reality? Most teams never measure this. Why does it matter? Because you can't fix what you don't track.

**After:** Most teams never measure this, so they can't fix what they aren't tracking.

### 38. "Most"-openers [LOW]

**Problem:** Sentences starting with "Most people think..." / "Most teams..." set up a strawman to knock down. Often paired with reversal framing.

**Before:** Most people think more meetings mean more alignment.

**After:** More meetings didn't make our team more aligned. (Speak from the specific case, not a generalization about "most people.")
