-- Disambiguate Module 25 Lesson 1 title (was a duplicate of Module 21's lesson 1 title)
update lessons
set title = 'Why This Module Matters: The Full System Around the Model'
where module_id = (select id from modules where sort_order = 25)
  and sort_order = 1;
