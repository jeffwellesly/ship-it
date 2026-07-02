-- Rename "ML for Everyone" → "AI/ML for Everyone" and update description
update courses
set
  title       = 'AI/ML for Everyone',
  description = 'Understand AI and machine learning from a product and business perspective — no math degree required.'
where sort_order = 2;
