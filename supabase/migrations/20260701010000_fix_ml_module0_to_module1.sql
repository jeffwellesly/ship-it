-- Rename ML Module 0 → Module 1 and fix sort_order
update modules
set
  title      = 'Module 1: Machine Learning Basics for Product Managers',
  sort_order = 1
where title = 'Module 0: Machine Learning Basics for Product Managers';
