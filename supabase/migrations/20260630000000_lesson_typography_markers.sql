-- Add >> (pull quote) and [!] (callout) markers to Lesson 1.1 for demonstration.
-- Apply the same pattern to other lessons via the Supabase dashboard.

update lessons
set content = $L$Most beginners are not afraid of software because software is hard.

They are afraid because the computer feels fragile.

The terminal looks serious. The black screen feels like a place where one wrong word can destroy the machine. But that is not how modern computers work.

>> Your computer is not a glass museum item. It is a workshop.

When you use your computer normally, you click folders, drag files, open apps, and press buttons. That is called the **visual interface**.

Developers also use another interface called the **terminal**.

The terminal is not a different computer. It is another way to talk to the same computer.

[!] Think of it like this: the normal interface is like using a restaurant menu with pictures — you tap what you want. The terminal is like speaking directly to the waiter. You say exactly what you want. Same restaurant. Different way of ordering.

In this course, you will use the terminal only inside safe project folders. That means even if you make a mistake, the worst case is usually that you delete or break something you created for practice. You are not going to damage your laptop by learning.

IMPORTANT SAFETY RULE

Do not run a command you do not understand. When unsure, ask Claude:

"Explain this command before I run it. Tell me what it does, what files it can change, and whether it is safe for a beginner."

That one habit will keep you safe.

KEY TERMS

**GUI** — Graphical User Interface. The visual way you use your computer: icons, windows, buttons, folders.

**Terminal** — A text-based way to talk to your computer by typing commands.

**Command** — An instruction you type into the terminal.

**Project folder** — A folder where all files for one software project live.$L$
where title = 'Your Computer Is Not Fragile';
