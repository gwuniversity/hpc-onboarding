# How to: Navigate Using the Command Line in HPC Clusters

This article outlines how to interact with the George Washington University’s high-performance computing (HPC) clusters after logging-on through your computer’s command line. To those already familiar with interacting with a Linux computer through text alone, feel free to skip to the next lesson on submitting a job using SLURM.

## Background Information on Command Line Interfaces (CLIs)

Command Line Interfaces, or CLIs for short, form the original way that users interacted with computer hardware. Generally speaking, you need to type a command, which may have both options (adjustments to the base command to do more specific things) and arguments (files or objects that are adjusted by the command itself). What most people use nowadays is some form of Graphical User Interface, or GUI; however, on the backend of GUIs, many programs are still running code on a CLI, which is why you may see a black window pop-up when some programs start. That being said, the majority of software nowadays hides that from the end user entirely.

Different operating systems may have different forms of syntax and formatting for interacting with the Command Line. Most notably, since Windows is not built on Unix like Linux and Mac OS, its standards can be quite different from the latter two. For the purposes of this article, our instructions will use Linux as the standard, since all our HPC clusters run some form of Linux-based OS. The only time that things will differ is how you access the clusters themselves, but those differences are already addressed in their respective articles.

---

## How do I interact with the system once I’ve logged on?

Let’s start off with what you’ll be presented with when successfully logging onto a cluster here at GW. For the purposes of this tutorial, we shall be using Pegasus as a basis for screenshots and filesystems. The commands being taught here will work across all of our clusters, and are fundamental to navigating and understanding Linux systems often used in HPC worldwide.

On Pegasus, you’ll start off in your home directory. This is represented by a tilde (\~) shown next to your username in the square brackets. To see where you are currently, use the *pwd* command (stands for “Print Working Directory”); this will display the path for the current folder you are in, known as your working directory. It is a good way to regain your bearings in case you ever get lost on where you are within the system, so make sure to keep it in your back pocket, just in case\!

To look at the files in your working directory, use the *ls* command (stands for “List”). This will provide a simple list of all the filenames in your working directory, organized alphabetically. Personally, I recommend adding the *\-l* option (meaning “long”) to get a more detailed list, which includes the file permissions, ownership, size and other helpful information, thus typing *ls \-l* will give you that full list.

To change directories, use the *cd* command (stands for “Change Directory”), followed by the filepath for the directory you wish to change to. This path can be either a relative path (simply the name of a folder within the working directory) or an absolute path (useful for switching between the three major directories discussed in the prior tutorial). Once successfully done, the square brackets should display the name of the current directory you are in; you can always check if it changed successfully by using the aforementioned *pwd* command.

If you’d like to make a folder within the working directory, use the *mkdir* command (stands for “Make Directory”), followed by the name you’d like to give that folder. You can verify that it was created successfully either by using the *ls* command and looking for the name, or using the *cd* command and seeing if it successfully moves you inside that folder.

If you’d like to remove files within your working directory, use the *rm* command (stands for “Remove”) followed by the filepath for the item you wish to remove. If it is a folder instead of a file, add the option *\-r* after the command itself but before the filepath. Please make sure to only delete things that are your own; two of the three major directories are shared with others in your research group, so please do not remove files that other researchers may be using.

---

## Further Assistance

Should you have any issues using any of these commands, such as being unable to delete files that you yourself added, please email [hpchelp@gwu.edu](mailto:hpchelp@gwu.edu) and detail the problems you encountered. Someone at Research Technology Services (RTS) will assist you as available\!