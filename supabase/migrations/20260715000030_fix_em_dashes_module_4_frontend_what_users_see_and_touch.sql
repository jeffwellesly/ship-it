-- Fix em dashes introduced by earlier typography-styling migrations.
-- Software Development with Claude Code / Module 4: Frontend: What Users See and Touch
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $D9e8574bf_c9ea_4919_a921_93d065c7b70e$Every app has a part you see and a part you do not see.

The part you see is the **frontend**.

When you open a food delivery app, you see restaurant cards, a search bar, filters, images, ratings, buttons, a cart icon, and a checkout screen. That is frontend.

When you open a learning app, you see course cards, lesson pages, progress bars, buttons, quizzes, and completion badges. That is also frontend.

>> Frontend is where humans and software meet.

If the frontend is confusing, the product feels confusing. If the frontend is slow, the product feels slow. If the frontend is inaccessible, some users cannot use the product at all.

This is why frontend is not just "making things pretty." Frontend is product experience.


ANALOGY

[!] Imagine a restaurant. The frontend is the dining room: menu design, tables, lighting, waiter interaction, payment counter, signage. The backend is the kitchen: cooking, inventory, billing logic, staff coordination. Users do not see the kitchen. They judge the restaurant mostly through the dining room. Software works the same way.


WHAT FRONTEND MUST DO

A good frontend should be:

**Clear:** The user understands what to do.

**Fast:** The page loads and responds quickly.

**Responsive:** It works on mobile, tablet, and desktop.

**Accessible:** People with different abilities can use it.

**Consistent:** Buttons, cards, colors, and spacing feel predictable.

**Trustworthy:** The product should not feel broken, random, or confusing.


KEY TERMS

**Frontend:** The part of software users see and interact with.

**User Interface:** The screens, buttons, forms, text, and visual elements users interact with.

**User Experience:** How the product feels while using it.

**Interaction:** Something the user does, like clicking, typing, tapping, or scrolling.


PRODUCT EXAMPLE

In your Ship It app: a course card is frontend. A lesson page is frontend. A quiz button is frontend. A progress bar is frontend. The system that stores whether you completed a lesson is backend and database, but you experience it through frontend.$D9e8574bf_c9ea_4919_a921_93d065c7b70e$ where id = '9e8574bf-c9ea-4919-a921-93d065c7b70e';

update lessons set content = $Dacd4ddf8_a42a_4264_9ff7_b26ddc5ce80e$In Module 2, you learned that HTML creates the structure of a webpage. Now let's go one level deeper.

HTML should not only create what appears on the page. It should also describe what each part means. That is called **semantic HTML**.

Semantic means "meaningful."

For example, this works visually:

  <div>Home</div>
  <div>About</div>
  <div>Projects</div>

But this gives more meaning:

  <nav>
    <a href="#home">Home</a>
    <a href="#about">About</a>
    <a href="#projects">Projects</a>
  </nav>

The second version tells the browser: "This is navigation." That matters for screen readers, search engines, browser tools, other developers, and long-term maintainability.


BAD VS GOOD STRUCTURE

Bad:

  <div>
    <div>My Website</div>
    <div>About me</div>
    <div>Projects</div>
  </div>

Good:

  <header>
    <nav>
      <a href="#about">About</a>
      <a href="#projects">Projects</a>
    </nav>
  </header>

  <main>
    <section id="about">
      <h1>About me</h1>
    </section>
  </main>

  <footer>
    <p>Built with Ship It.</p>
  </footer>

Both can look the same. But the second one is much better because it has meaning.


IMPORTANT HTML ELEMENTS

**header:** Top section of a page or section.

**nav:** Navigation links.

**main:** Main content of the page.

**section:** A meaningful section of content.

**article:** Independent content, like a blog post or card.

**footer:** Bottom section.

**button:** Clickable action.

**a:** Link to another place.

**form:** Collects user input.


WHY THIS MATTERS

Beginners often use div for everything. A div is just a box, it has no meaning. If everything is a div, the page becomes harder to understand and less accessible.

[!] A real button can be used with a keyboard. A fake button made from a div may not work properly for keyboard or screen reader users.

>> If something is a button, use a button. If something is a link, use a link.$Dacd4ddf8_a42a_4264_9ff7_b26ddc5ce80e$ where id = 'acd4ddf8-a42a-4264-9ff7-b26ddc5ce80e';

update lessons set content = $Db9f7a9c5_0c10_4cb4_9735_cfce7267171e$HTML creates the structure. CSS turns that structure into design.

CSS decides: color, font, size, spacing, borders, shadows, layout, hover effects, animations, and mobile behavior.

A page with only HTML may work, but it usually looks plain. A page with thoughtful CSS feels like a real product.


THE MOST IMPORTANT CSS IDEA

CSS works by selecting something and styling it.

  h1 {
    color: white;
    font-size: 48px;
  }

This means: "Find every h1 and make the text white and 48px."

The h1 is the **selector**. color and font-size are **properties**. white and 48px are **values**.


CLASSES

A class is a reusable label you can give to an HTML element.

  <div class="card">Project 1</div>
  <div class="card">Project 2</div>
  <div class="card">Project 3</div>

  .card {
    padding: 24px;
    border-radius: 16px;
    background: #16161f;
  }

Now all cards share the same style.


VISUAL HIERARCHY

Good design tells the user what matters first.

If everything is the same size and color, users do not know where to look.

**Main headline:** Should be large.

**Supporting text:** Should be smaller.

**Primary button:** Should stand out.

**Secondary actions:** Should be quieter.


THE BOX MODEL

Every element on a webpage is like a box. A box has:

**Content:** The text or image inside.

**Padding:** Space inside the box, between the content and the border.

**Border:** The line around the box.

**Margin:** Space outside the box, separating it from other elements.

  .card {
    padding: 24px;
    border: 1px solid #2a2a3a;
    margin-bottom: 20px;
  }

>> The HTML says what exists. The CSS makes it feel like a real product.


PRODUCT EXAMPLE

A course card in your app may have:

  .course-card {
    padding: 24px;
    border-radius: 18px;
    background: #181820;
    border: 1px solid #2d2d3a;
  }

The HTML says what exists. The CSS makes it feel like a premium course card.$Db9f7a9c5_0c10_4cb4_9735_cfce7267171e$ where id = 'b9f7a9c5-0c10-4cb4-9735-cfce7267171e';

update lessons set content = $Dd479be1e_8c4a_4c0c_bbed_fd1ed253bca4$HTML creates the page structure. But the browser does not work with HTML as plain text forever.

When the browser opens your HTML file, it creates a live internal version of the page. That live version is called the **DOM**.

DOM stands for Document Object Model. You do not need to memorize the full form. Just remember:

>> The DOM is the live page tree that JavaScript can read and change.


SIMPLE MENTAL MODEL

Imagine your webpage is a family tree.

At the top: document. Inside it: html. Inside that: head and body. Inside body: header, main, footer. Inside main: section, button, p.

Each element is a node in the tree. JavaScript can find a node and change it.


EXAMPLE

  <h1 id="mainTitle">Hello</h1>
  <button id="changeButton">Change title</button>

  const title = document.getElementById("mainTitle");
  const button = document.getElementById("changeButton");

  button.addEventListener("click", function () {
    title.textContent = "The title changed.";
  });

What happens? JavaScript finds the heading. JavaScript finds the button. JavaScript waits for a click. When clicked, JavaScript changes the heading text. That is DOM manipulation.


KEY TERMS

**DOM:** The live page structure inside the browser.

**Node:** One item in the DOM tree.

**Element:** An HTML item like h1, p, button, or section.

**Event:** Something the user does, like click or type.

**Event listener:** JavaScript waiting for an event.

**Render:** The browser drawing the page on screen.


WHY THIS MATTERS

When users interact with a frontend, JavaScript often updates the DOM.

[!] Clicking "Like" changes the heart icon. Adding to cart updates the cart count. Opening a dropdown shows menu items. Toggling dark mode changes the page theme. Submitting a form shows success or error. These are all frontend interactions driven by JavaScript changing the DOM.


DEBUGGING TIP

If a button does not work, check: does the ID in HTML match JavaScript? Is script.js connected? Did you save the file? Is the script loading after the HTML elements exist?$Dd479be1e_8c4a_4c0c_bbed_fd1ed253bca4$ where id = 'd479be1e-8c4a-4c0c-bbed-fd1ed253bca4';

update lessons set content = $D30839d85_7fa6_4e8b_82e9_12ade79c6df9$Some data on a page changes while the user is using it. That changing data is called **state**.

Examples of state: Is dark mode on or off? Is the menu open or closed? How many items are in the cart? Which tab is selected? Has the quiz been answered? Is the form showing an error? Is data loading?

>> State is what the frontend remembers at a given moment.


ANALOGY

[!] Imagine you are taking an order at a restaurant with a notepad. As the customer adds items, you write them down. The kitchen does not need to know every change immediately. The notepad remembers the current order. That notepad is like frontend state.


EXAMPLE: DARK MODE STATE

Your page can remember whether dark mode is on.

  <button id="themeToggle">Toggle theme</button>

  themeToggle.addEventListener("click", function () {
    document.body.classList.toggle("light-mode");
  });

  body {
    background: #0b0b10;
    color: white;
  }

  body.light-mode {
    background: #f5f5f7;
    color: #111111;
  }

The page state is: "Is the light-mode class present or not?" When the class exists, the page looks light. When the class is removed, the page looks dark.


LOCAL STATE VS SHARED STATE

Some state belongs to one small piece of UI. A dropdown is open or closed, that is **local state**. Some state affects many parts of the page. Dark mode affects the whole page. Cart count affects the header, cart page, and checkout. That is **shared state** or global state.


BUTTON TEXT STATE

You can also update the button text to match the current state:

  themeToggle.addEventListener("click", function () {
    document.body.classList.toggle("light-mode");
    const isLight = document.body.classList.contains("light-mode");
    themeToggle.textContent = isLight ? "Switch to dark" : "Switch to light";
  });

[!] Good UI keeps state and labels in sync. If the page switches to light mode but the button still says "Switch to light mode," that is confusing for the user.


PRODUCT EXAMPLE

In a shopping app: if the cart count shows 3, that number is state. If the user adds another item, the state becomes 4. The UI updates. That is how state affects the screen.$D30839d85_7fa6_4e8b_82e9_12ade79c6df9$ where id = '30839d85-7fa6-4e8b-82e9-12ade79c6df9';

update lessons set content = $D15dd4720_5829_4d51_ba6c_bfe8375fd08e$Your webpage should work on phone, tablet, laptop, and large monitor.

That is hard because screen sizes are very different. A phone screen is narrow. A laptop screen is wide. A layout that looks good on laptop may feel cramped on mobile.

**Responsive design** means the page adapts to different screen sizes.


ANALOGY

[!] Think of packing clothes. For a large suitcase, you can spread things out. For a small backpack, you must prioritize and stack carefully. Same content, different layout. That is responsive design.


MOBILE-FIRST THINKING

A good beginner rule: design for mobile first.

Why? Because mobile forces clarity. There is no space for unnecessary things. Start with one column. Then add more columns for larger screens.

Mobile layout:
  Card 1
  Card 2
  Card 3

Desktop layout:
  Card 1    Card 2    Card 3

Same content. Different layout.


CSS MEDIA QUERY

A **media query** lets CSS apply different styles at different screen widths.

  .project-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 16px;
  }

  @media (min-width: 768px) {
    .project-grid {
      grid-template-columns: repeat(3, 1fr);
    }
  }

This means: on small screens, use one column. On screens wider than 768px, use three columns.


IMPORTANT VIEWPORT LINE

Every responsive page should include this inside the head:

  <meta name="viewport" content="width=device-width, initial-scale=1.0">

This tells mobile browsers: "Use the actual device width." Without it, mobile pages can look zoomed out and tiny.


FLEXBOX AND GRID

Two common CSS layout tools:

**Flexbox:** Good for arranging items in one direction. Examples: navigation links, buttons in a row, centering content.

**Grid:** Good for rows and columns. Examples: course cards, product cards, project cards, dashboard panels.

>> You do not need to master both today. Just know they help create layout.


TESTING

In Chrome DevTools: right-click the page, choose Inspect, click the device toolbar icon, and preview mobile sizes. Always test narrow width, your page may look great on your screen and terrible on a phone.$D15dd4720_5829_4d51_ba6c_bfe8375fd08e$ where id = '15dd4720-5829-4d51-ba6c-bfe8375fd08e';

update lessons set content = $Ddeac075c_61b4_46bf_abce_481f13fd0d69$**Accessibility** means building software so more people can use it.

This includes people who use screen readers, navigate with a keyboard, have low vision, have color blindness, have hearing loss, have motor difficulties, get motion sickness from animations, or are using a broken mouse or trackpad.

>> Accessibility is not only for a small group. It helps everyone.


ANALOGY

[!] Think about ramps on sidewalks. They help wheelchair users. But they also help parents with strollers, travelers with luggage, delivery workers, elderly people, and anyone carrying heavy bags. Good accessibility works the same way. Captions help people with hearing loss, and people watching videos in a noisy airport. Keyboard shortcuts help people with motor disabilities, and power users who want to move faster.


THREE BEGINNER ACCESSIBILITY RULES

RULE 1, USE REAL HTML ELEMENTS

If it is a button, use a button.

  Good:  <button>Submit</button>
  Avoid: <div onclick="submitForm()">Submit</div>

Real HTML elements come with built-in accessibility.


RULE 2, MAKE KEYBOARD NAVIGATION WORK

Users should be able to press Tab and move through interactive elements. Try this: open your page, put your mouse aside, press Tab. Can you reach every button and link? Can you see where focus is?

If you cannot see where you are, keyboard users are lost.


RULE 3, LABEL THINGS CLEARLY

If a button only has an icon, screen readers may not know what it means. Use aria-label.

  <button aria-label="Toggle dark mode">
    🌙
  </button>


OTHER IMPORTANT CHECKS

**Color contrast:** Text should be readable against the background.

**Alt text for images:** Images should have descriptions when they communicate meaning.

  <img src="profile.jpg" alt="Portrait of Jeff smiling">

**Form labels:** Inputs should have labels.

  <label for="email">Email</label>
  <input id="email" type="email">

**Reduced motion:** Some users get discomfort from heavy animations.

  @media (prefers-reduced-motion: reduce) {
    * {
      animation: none;
      transition: none;
    }
  }


COMMON MISTAKE

Removing focus outlines because they "look ugly."

  Bad:    button:focus { outline: none; }
  Better: button:focus { outline: 2px solid #8b7cff; outline-offset: 3px; }

Users need to see where they are.$Ddeac075c_61b4_46bf_abce_481f13fd0d69$ where id = 'deac075c-61b4-46bf-abce-481f13fd0d69';

update lessons set content = $D8a658e14_17e4_427d_a676_365c732021a6$Now you will upgrade your webpage into a cleaner frontend.

This is not just about decoration. You will improve the structure, layout, interaction, responsiveness, and accessibility.

Your goal is to make the page feel more like a real product.


FINAL PROJECT REQUIREMENTS

Your upgraded webpage should include:

  1. Semantic HTML structure
  2. Header and navigation
  3. Hero section
  4. About section
  5. Interest cards
  6. Project cards
  7. Internet Request Demo from Module 3
  8. Dark/light mode toggle
  9. Responsive layout
  10. Accessible buttons and links
  11. Visible focus states
  12. Clean Git commit


RECOMMENDED FILE STRUCTURE

  my-first-webpage/
    index.html
    style.css
    script.js
    CLAUDE.md


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Upgrade my webpage into a product-style frontend.

  Requirements:
  1. Use semantic HTML: header, nav, main, section, article, footer.
  2. Keep the project beginner-friendly.
  3. Use only HTML, CSS, and JavaScript. No frameworks.
  4. Add a clean header with navigation links.
  5. Add a hero section with my name and a short headline.
  6. Add an About section, Interests section with cards,
     and Projects section with cards.
  7. Keep the Internet Request Demo from Module 3.
  8. Add a dark/light theme toggle using JavaScript state.
  9. Make the layout mobile-first and responsive.
  10. Add accessible labels where needed.
  11. Ensure keyboard focus is visible.

  Before editing, explain your plan. After editing, list the
  files changed and explain what changed in each file.


EXAMPLE HTML SKELETON

  <header class="site-header">
    <a href="#" class="logo">My Webpage</a>
    <nav aria-label="Main navigation">
      <a href="#about">About</a>
      <a href="#projects">Projects</a>
    </nav>
    <button id="themeToggle" aria-label="Toggle theme">
      Toggle theme
    </button>
  </header>

  <main>
    <section class="hero">
      <h1>Hi, I'm Jeff.</h1>
      <p>Learning to build real software products with AI.</p>
    </section>

    <section id="projects" class="section">
      <h2>Projects</h2>
      <div class="card-grid">
        <article class="card">
          <h3>My First Webpage</h3>
          <p>Built with HTML, CSS, and JavaScript.</p>
        </article>
      </div>
    </section>
  </main>

  <footer class="site-footer">
    <p>Built while learning with Ship It.</p>
  </footer>


FINAL QA CHECKLIST

STRUCTURE
Does the page have header, main, and footer?
Are sections clearly separated?
Is the page easy to scan?

DESIGN
Is the headline readable?
Is spacing comfortable?
Do cards look consistent?
Does the primary action stand out?

INTERACTION
Does the theme toggle work?
Does the API fetch demo still work?
Do links scroll to the right sections?

RESPONSIVE
Does it work on mobile width?
Do cards stack properly?
Are buttons easy to tap?

ACCESSIBILITY
Can you navigate with Tab?
Is focus visible?
Are buttons real buttons?
Are links real links?
Are labels clear?


SAVE WITH GIT

When the upgraded frontend works, run:

  git status
  git add .
  git commit -m "Upgrade webpage frontend"


BADGE UNLOCKED

>> You completed Module 4.

You now understand frontend at a product-builder level.

You learned: frontend is the part users see and touch. HTML should describe meaning. CSS creates visual design. JavaScript updates the DOM. Components are reusable UI blocks. State is what the page remembers. Responsive design makes pages work on every screen. Accessibility makes products usable for more people.

Next module: Module 5, Backend: The Kitchen You Never See.$D8a658e14_17e4_427d_a676_365c732021a6$ where id = '8a658e14-17e4-427d-a676-365c732021a6';
