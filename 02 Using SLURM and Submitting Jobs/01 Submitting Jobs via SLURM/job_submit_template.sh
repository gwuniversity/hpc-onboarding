#!/bin/sh

# Hello! Here is a template for submitting a job via SLURM on Pegasus, while explaining the different options and lines.
# This has been written by Jake Messick, Cyberinfrastructure Specialist I with Research Technology Services.
# For any assistance with any issues you may encounter, please email hpchelp@gwu.edu and detail any problems there.
# Without further ado, let's begin!

# -t stands for time, which is the amount of time your program will be allotted, in the format dd-hh:mm:ss.
# I've defaulted to four hours here, but you can adjust to your needs. Shorter times are prioritized by the scheduler.
# If your code has yet to finish by the time the value specified here has been hit, it will terminate prematurely.
# Make sure to run tests of your code with small amounts of input to see how long it may run for, then extrapolate for the final.
# Please keep in mind that you cannot set a time longer than the time limit of your desired queue.
#SBATCH -t 4:00:00

# -p stands for partition, but refers to what we call the "queues" for nodes in the system.
# You can check the status of the queues at the current moment by using the command sinfo while on Pegasus.
# That provides a list of all the queues, their respective nodes and the statuses for each.
# "idle" means available, "alloc" means in use. The others aren't as important for end users; idle nodes mean they're free to use.

# If you are unsure of the purpose of a given queue, please use the following link to understand the categorization:
# https://hpc.gwu.edu/submitting-jobs-to-pegasus/

# -N is the number of nodes you are requesting in that queue; for most purposes, it should be 1.
#SBATCH -p med-gpu -N 1

# These two options are the output and error files respectively. They'll be saved in whatever directory you submit the job from.
# Output contains what would traditionally go to the terminal in programming software when running the code.
# Error contains any errors that appear while running the code; these traditionally appear in the terminal in red.
# Using these two effectively can allow you to debug your code when attempting to run it on Pegasus for the first time.
# Additionally, the "%j" portion of the filename will write out the job submission number of the job itself.
#SBATCH -o testing%j.out
#SBATCH -e testing%j.err

# These final two options notify you via email of when your job has done any number of things; setting the latter to
# "all" just makes it notify you of when it was submitted, when it begins to run, and when it either completes or fails.
# Please put your username in the designated spot before submitting this, so you can get the emails yourself!
#SBATCH --mail-user=[username]@gwu.edu
#SBATCH --mail-type=all


# Most users will simply be running Python code across a node or a few nodes.
# Thus, this template has preloaded the Python 3 module and a line for you to run your Python file.
# Please replace [filepath] with the location of your Python file, either relative to the current directory or absolute.
# For other modules, use the command "module avail" to see a full list of modules. Add a new line below after the load
# instruction stating "module load [name of desired module]" to have access to that module in the code you wish to run.
module load python3
python [filepath]

# Once you're happy with everything here, save it in nano (CRTL+O) and submit it using the command "sbatch [filename].sh".
# If you haven't changed the filename, it would be "sbatch job_submit_template.sh".

# To check on the status of a job either queued (pending, "PD") or in progress (running, "R"), use the command squeue --me.
# To check on the status of a job that has finished (either completed or failed), use the command sacct -j [job_number].