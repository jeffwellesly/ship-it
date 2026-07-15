-- Fix em dashes introduced by earlier typography-styling migrations.
-- Software Development with Claude Code / Final Capstone: Ship Your Portfolio Product
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $D88542769_fb70_4eff_b421_e8a524cd9446$Before sharing your product, test it.

Do not just say: looks good.

Check the main flows. Record the results.


FINAL TEST CASES

TEST 1, Live page opens
  Expected: Frontend loads without obvious errors.
  Status: Pass / Fail

TEST 2, Projects load
  Expected: Project cards appear from backend/database.
  Status: Pass / Fail

TEST 3, Posts load
  Expected: Blog or learning note cards appear.
  Status: Pass / Fail

TEST 4, Contact form success
  Expected: Valid message submits and appears in Supabase.
  Status: Pass / Fail

TEST 5, Contact form error
  Expected: Missing email or message shows clear error.
  Status: Pass / Fail

TEST 6, Mobile layout
  Expected: Page is readable and usable on mobile width.
  Status: Pass / Fail

TEST 7, No localhost
  Expected: Live frontend does not call localhost.
  Status: Pass / Fail

TEST 8, Backend health
  Expected: GET /health returns success JSON.
  Status: Pass / Fail


UPDATE TESTING.MD

After running tests, update TESTING.md with capstone QA results.

Add a section:

  ## Capstone QA Results
  Date:
  Test 1, Live page opens: Pass
  Test 2, Projects load: Pass
  Test 3, Posts load: Pass
  Test 4, Contact form success: Pass
  Test 5, Contact form error: Pass
  Test 6, Mobile layout: Pass
  Test 7, No localhost: Pass
  Test 8, Backend health: Pass

  Known issues:
  [List any problems found and whether they are Low/Medium/High severity]


CLAUDE PROMPT

Ask Claude:
  Create a final capstone QA checklist for my portfolio product.

  Include:
  1. Frontend checks
  2. Backend checks
  3. Supabase checks
  4. Contact form checks
  5. Mobile checks
  6. Accessibility checks
  7. Deployment checks
  8. No localhost checks
  9. README checks
  10. GitHub safety checks

  Keep it practical.$D88542769_fb70_4eff_b421_e8a524cd9446$ where id = '88542769-fb70-4eff-b421-e8a524cd9446';

update questions set choices = $De1985552_a52b_47d3_a68f_2edc84968980Q$["Minimum Viable Product, the smallest useful version worth sharing","Maximum Visual Polish, the best-looking version","Main Verified Process, the tested code path","Most Visible Page, the homepage"]$De1985552_a52b_47d3_a68f_2edc84968980Q$::jsonb where id = 'e1985552-a52b-47d3-a68f-2edc84968980';
