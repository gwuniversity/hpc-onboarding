#!/bin/sh

# Hello! Here is a template for submitting a GPU job via SLURM, while explaining the different options and lines.
# This has been updated to accommodate the new resource-based scheduling system, and is accurate as of February 23rd, 2026.
# This has been written by Jake Messick, Cyberinfrastructure Specialist I with Research Technology Services.
# For any assistance with any issues you may encounter, please email hpchelp@gwu.edu and detail any problems there.
# Without further ado, let's begin!

# These first two options are essential, as failure to include them will result in the job not submitting whatsoever.

# -t stands for time / timelimit, which is the amount of time your program will be allotted, in the format dd-hh:mm:ss.
# I've defaulted to four hours here, but you can adjust to your needs. Shorter times are prioritized by the scheduler.
# If your code has yet to finish by the time the value specified here has been hit, it will terminate prematurely.
# Make sure to run tests of your code with small amounts of input to see how long it may run for, then extrapolate for the final.
# Please keep in mind that you cannot set a time longer than 14 days for CPU jobs.
#SBATCH -t 4:00:00

# -p stands for partition, or "queue" as we colloquially refer to them. These are a remnant of the old style of scheduling,
# and are planned for decommissioning once we swap to the resource-based scheduling system full time on May 9th, 2026.
# For now, however, you will still need to specify a queue in order to use the resource-based system.
# For GPU jobs on Pegasus and Raptor, use 'gpu'. For all resource-based requests on Cerberus, use 'workshop'.
#SBATCH -p gpu

# The next options are also important, and you'll need to define all of them in order to make the most of the new system.
# While there are defaults, you typically want to adjust the values for your code's particular needs and requirements.
# As for the values we provide below, these are the base configurations we recommended in the previously released
# 'Pegasus Research Guide to Resource Allocation' document. Feel free to adjust as you'd like for your own needs.

# NOTE: While requests are quite flexible & you have more control over what you can request in an allocation compared to before,
# it is important to emphasize that the physical nodes are an upper bound to the maximum resources you can get. For instance,
# the most cores you can validly request at a single time is 384, the total count on our high core count node hcc001;
# if you try and request 385, the system will return an error stating a node with that configuration does not exist.
# SLURM will not automatically parallelize your code to split resources across multiple nodes, so make sure your requested
# resource configuration is something satisfiable within existing hardware in a single node.
# Should you have any concerns related to this, feel free to reach out at hpchelp@gwu.edu and we will assist ASAP.

# --gres is the option for requesting GPUs. This is required if you want a GPU; selecting the queue alone isn't enough.
# <TYPE> is the specific kind of GPU you're looking to request. If you wish to know what GPUs are available on the cluster,
# you can use the command below to scope out all the available configurations. Examples include v100, a100, l40s, etc.
# 
# sinfo -o "%P %G"
# 
# <COUNT> is the number of that type of GPU you need. Note that without parallelization, requesting more than one GPU
# will not use more than one. Parallelization is also required for requesting more GPUs than available on a single node.
# The aforementioned command should show you what's available at most on a single node, so use that to fill out this option.
#SBATCH --gres=gpu:<TYPE>:<COUNT>

# --cpus-per-gpu are the number of cores you want for your job, per GPU requested.
# SLURM often conflates the terms 'cpu' and 'core', so keep that in mind as you adjust these settings.
# Each core can have a maximum of 16GB of memory assigned to it. If you request more memory than the maximum supported by the
# core count, the system will automatically increase the number of cores to meet your required memory allocation.
#SBATCH --cpus-per-gpu=4

# --mem-per-gpu is the total amount of memory (RAM) you wish to have for your job, per GPU requested.
# This is NOT VRAM. Rather, this is the total DRAM for your CPU cores. Use G for gigabytes, M for megabytes.
# VRAM is hardwired to each GPU type; you cannot request more than what the specific type of GPU requested offers on its own.
# Failure to specify this will leave you with the default 8GB of TOTAL memory; thus, make sure to specify as much as you need.
# Should you prefer specifying the total overall memory for the entire job, feel free to use --mem instead.
# At the same time, be reasonable with your requested amounts. Higher amounts of memory requested will reduce your jobs' priority.
#SBATCH --mem-per-gpu=16G

# We now move onto four options that, while not required, are highly recommended for ease of debugging your jobs and staying
# informed about how your jobs are running.

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

# That is the extent of the recommended / required SBATCH options we suggest for your submission script. Once all of these are
# as you'd like, the section below without any pound symbols are the actual payload of your script; the code you'd like to run.
# Each line is akin to a command typed into the command line, and the script will perform these in order one after another.
# Once either all of your code has completed or your time limit has been reached (whichever is first), your job will finish.

# Most users will simply be running Python code across a node or a few nodes.
# Thus, this template has preloaded the Python 3 module and a line for you to run your Python file.
# Please replace [filepath] with the location of your Python file, either relative to the current directory or absolute.
# For other modules, use the command "module avail" to see a full list of modules. Add a new line below after the load
# instruction stating "module load [name of desired module]" to have access to that module in the code you wish to run.
module load python3
python3 [filepath]

# Once you're happy with everything here, save it in nano (CRTL+O), exit nano (CRTL+X), and submit it 
# using the command "sbatch [filename].sh".
# If you haven't changed the filename, it would be "sbatch job_submit_template.sh".

# To check on the status of a job either queued (pending, "PD") or in progress (running, "R"), use the command squeue.
# To check on the status of a job that has finished (either completed or failed), use the command sacct -j [job_number].