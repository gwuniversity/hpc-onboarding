# How to: Submit Jobs on Clusters using SLURM

This article provides a tutorial for submitting jobs with SLURM, the scheduler used on George Washington University’s high-performance computing (HPC) clusters. It will go over the difference between batch jobs and interactive jobs, the relative strengths and weaknesses of each, and the process involved for submitting each type onto your desired queue for execution.

## Background Information on Jobs and Job Types

In the context of clusters, a “job” is simply a task that is sent to a compute node to complete. The job can contain anywhere from a single piece of code to be run independent of user input, or comprise a period of time for more complex tasks requiring a GUI or user interaction.

Jobs are typically divided into two types: batch jobs and interactive jobs. Our HPC infrastructure is optimized for the former compared to the latter, as is usually the case with shared-system clusters. Thus, where possible, **try to submit your code as a batch job if you can**. Only use interactive jobs if your research absolutely requires you to, and the solutions for interactive software provided on Open OnDemand are insufficient. Please do not submit an interactive job simply to run code directly in the terminal that could be done via batch submission—it will not only be less efficient for your own research, but will cause backups in the queuing system that can impact access to resources for other users\! Be cognizant of others and use the clusters wisely.

**NOTE:** If your code has dependencies or input datasets, make sure that you load or install the former at the start of your script and upload the latter to a location in Pegasus (and adjust the filepaths in your code to refer to said location—your code on Pegasus can only see files on Pegasus, not on your local device\!).

---

## Submitting Batch Jobs with sbatch

We begin with the preferred method of submitting jobs on our HPC systems, that being using a job submission script to submit a batch job with the **sbatch** command. Code submitted via this manner should require no user input in the middle of the process, and ensure that results are saved to a location on Pegasus. Failure to accommodate these factors will mean your job will either not complete properly, or results will be calculated but not saved.

Every batch job has a script you must submit with it. Within this page, you should see a “job\_submission\_template.sh” file that you can download and read through all the comments; they explain each of the options and how to set/use them. The only required options are *\-t* and *\-p*, to set the time limit and queue for your job respectively, but the other options present in that file are strongly recommended to assist with debugging your code and being alerted without needing to log onto the cluster regularly.

Once your script has been adjusted for your needs, save your edits, type “sbatch \[filepath\]” and press enter to send your job to the queue via SLURM, where the filepath is the submission script. You will get a job ID if it’s been successfully submitted; keep note of it, in case you need to file a ticket for a problem you can’t diagnose. From there, you can check your job as it’s pending or running using *squeue* or after it's done with *sacct*.

A good analogy for this style of job submission is that of traditional snail mail. Your sbatch options within the script are the address and housing details, ensuring that it gets to the correct type of node you need your code to run on. The code after the options is the content you wish to be run on the node once it has been assigned to you; much like with traditional mail, what you send is what they get. You can’t edit it or interact with it once it’s there, so make sure the code works with small test jobs on the debug queue prior to submitting your larger, full job\!

Batch jobs will finish when your code has ended (either successfully by running fully or upon encountering an error) or when your time limit has been reached, whichever comes first. If your job is still running at the end of your set time limit, it will terminate at that very moment, regardless of if there is still more to finish. Thus, make sure your time limit is long enough for your code to finish within while still being under the maximum time allowed for your desired queue\!

---

## Submitting Interactive Jobs with salloc

We now move onto the command for reserving a node for interactive work, known as an interactive job, using the **salloc** command. As a reminder, this method of interacting with compute nodes should only be used as a last resort once all other options have been exhausted. Interactive jobs, both those obtained using salloc and those present on Open OnDemand, are still jobs submitted via SLURM, thus they have an associated impact on your overall priority. In general, interactive jobs tend to have worse priority than batch jobs—this means that in a queue with several pending jobs, batch jobs tend to get resources sooner than interactive jobs do.

Unlike batch jobs, interactive jobs do not need a script to be submitted alongside the command. In essence, you are requesting a node from a queue to be reserved for your personal use for a certain period of time by using this command. Our current policy is that the maximum amount of time permitted in an interactive job of any sort is 24 hours, or one day. Though some system changes have made implementing it difficult in recent months, please ensure you do not submit interactive jobs longer than a day. We may terminate jobs that go for longer than that manually.

With that in mind, to try and reserve a node for an interactive job, type “salloc \-t \[timelimit\] \-p \[queuename\]” and press enter, where the time limit is in the format dd-hh:mm:ss and the queue name is the name of the queue you want a node from, as shown in the output of *sinfo*. You need to have an idle node available for the process to properly finish, since the process doesn’t finish without that. If there is a proper idle node available, you should see a job ID and the name of the node you got assigned; type “ssh \[nodename\]” and hit enter to access that node, with \[nodename\] being the node as displayed in the aforementioned line.

Once there, you can run code directly through the command line as you’d like until your time limit has hit. Make sure that you aren’t doing so on the login node, as running code on the login nodes is strictly prohibited\! If you’re done doing what you want with time still remaining on your reservation, exit the node by typing “exit” and hitting enter, followed by “scancel \[jobID\]” \+ enter, with the job ID you saw earlier in this process. That will free the node, allowing it to be used by another user, so make sure you cancel your interactive jobs once you’ve done everything you want to on them\!

**NOTE:** The interactive jobs that go through Open OnDemand (this will be the next tutorial, still being written at the moment\!) also have this same process, where you will need to make sure to cancel the job once you are done with it. Please be sure to cancel, as leaving nodes unused for hours on end slows down the queue system for everybody, not just yourself.

---

## Further Assistance

Should you have any issues using any of these commands, such as difficulties with loading certain modules or running your code non-interactively, please email [hpchelp@gwu.edu](mailto:hpchelp@gwu.edu) and detail the problems you encountered. Someone at Research Technology Services (RTS) will assist you as available\!
