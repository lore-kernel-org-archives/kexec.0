Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TRP7T-0003oo-UV
 for kexec@lists.infradead.org; Thu, 25 Oct 2012 15:13:17 +0000
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
From: Lisa Mitchell <lisa.mitchell@hp.com>
In-Reply-To: <20121024164508.a2707a96b532a6766228bec5@mxc.nes.nec.co.jp>
References: <1350912018.13097.54.camel@lisamlinux.fc.hp.com>
 <20121024164508.a2707a96b532a6766228bec5@mxc.nes.nec.co.jp>
Date: Thu, 25 Oct 2012 05:09:44 -0600
Message-ID: <1351163384.13097.116.camel@lisamlinux.fc.hp.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Hoemann,
 Jerry" <jerry.hoemann@hp.com>

On Wed, 2012-10-24 at 07:45 +0000, Atsushi Kumagai wrote:
> Hello Lisa,
> 
> On Mon, 22 Oct 2012 07:20:18 -0600
> Lisa Mitchell <lisa.mitchell@hp.com> wrote:
> 
> > Jerry Hoemann and I tested the new makedumpfile 1.5.0 on a DL980 with 4
> > TB of memory, which is the maximum supported for this system.  We tested
> > it on top of a 2.6.32 kernel plus patches, had the dump level set to 31
> > for smallest dump,  and  found that the dump would not complete in a
> > reasonable time frame, basically staying for over 16 hours in the state
> > where it cycled through "Excluding Free pages" (would go from 0-100%)
> > and "Excluding unnecessary pages" (0-100%). It just alternated between
> > these two all night. I did not try waiting longer than 17 hours to see
> > if it ever completed, because with an earlier makedumpfile on this same
> > system, the dump would complete in a few hours.  Console logs can be
> > provided if desired.
> > 
> > Are we are seeing known issues that will be addressed in the next
> > makedumpfile?  
> > 
> > >From this email chain, it sounds like others see similar issues, but we
> > want to be sure we are not seeing something different.
> 
> I think you're seeing the known issue which we discussed, I will address it
> in v1.5.1 and v1.5.2.
>  
> > I can arrange for access to a DL980 with 4 TB of memory later when the
> > new makedumpfile v1.5.1 is available, and we would very much like to
> > test any fixes on our 4 TB system. Please let me know when it is
> > available to try.
> 
> I will release the next version by the end of this year.
> If you need some workarounds now, please use the workaroud described in
> the release note:
> 
>   http://lists.infradead.org/pipermail/kexec/2012-September/006768.html
> 
>      At least in v1.5.0, if you feel the cyclic mode is slow, you can try 2 workaronds:
>      
>        1. Use old running mode with "--non-cyclic" option.
>      
>        2. Decrease the number of cycles by increasing BUFSIZE_CYCLIC with 
>           "--cyclic-buffer" option.
>      
>      Please refer to the manual page for how to use these options.
> 
> > Meanwhile, if there are debug steps we could take to better understand
> > the performance issue, and help get this new solution working (so dumps
> > can scale to larger memory, and we can keep crashkernel size limited to
> > 384 MB), please let me know.
> 
> At first, the behavior of makedumpfile can be described as two steps:
> 
>   Step1. analysis
>     Analyzing vmcore and creating the bitmap which represent whether each pages
>     should be excluded or not. 
>     v1.4.4 or before save the bitmap into a file and it grows with the size of
>     vmcore, while v1.5.0 saves it in memory and the size of it is constant
>     based on BUFSIZE_CYCLIC parameter.
>     The bitmap is the biggest memory footprint and that's why v1.5.0 can work
>     in constant memory space.
> 
>   Step2. writing
>     Writing each pages to a disk according to the bitmap created in step1.
> 
> Second, I show the process image below:
> 
>  a. v1.4.4 or before
> 
>    [process image]
> 
>      cycle                       1
>                    +-----------------     -----+
>      vmcore        |                  ...      | 
>                    +-----------------     -----+
> 
>    [execution sequence]
> 
>       cycle  |   1   
>     ---------+-------
>       step1  |   1
>              |
>       step2  |   2
> 
>   [bitmap]
>   
>      Save the bitmap for the whole of vmcore at a time.
> 
> 
>  b. v1.5.0
>  
>   [process image]
>    
>     cycle           1   2   3   4    ...    N
>                   +-----------------     -----+
>     vmcore        |   |   |   |   |  ...  |   | 
>                   +-----------------     -----+
> 
>   [execution sequence]
> 
>       cycle  |   1   2   3   4    ...     N
>     ---------+------------------------------------
>       step1  |   1  /3  /5  /7  /      (2N-1)
>              |   | / | / | / | /          |
>       step2  |   2/  4/  6/  8/         (2N)
> 
>   [bitmap]
> 
>      Save the bitmap only for a cycle at a time.
> 
> 
> Step1 should scan only the constant region of vmcore correspond to each cycle, 
> but the current logic needs to scan all free pages every cycle.
> To sum it up, the more the number of cycle, the more redundant scans will be done. 
> 
> The default BUFSIZE_CYCLIC of v1.5.0 is too small for terabytes of memory,
> the number of cycle will be so large. (e.g. N is 32 in 1TB machines.)
> As a result, a lot of time will be spend for step1.
> 
> Therefore, I will implement the feature to reduce the number of cycle as few as
> possible automatically in v1.5.1.
> Now, you can get the same benefit by allocating enough memory with --cyclic-buffer
> option. For 4TB machines, you should specify "--cyclic-buffer 131072" if it's possible.
> (In this case, 256MB is required actually. Please see the man page for the
> details of this option.)
> 
> Additionally, I will resolve the issue included in the logic of excluding
> free pages in v1.5.2.
> 
> 
> Thanks
> Atsushi Kumagai

Thanks, Atsushi!  

I tried the dump on the 4 TB system with --cyclic-buffer 131072, and the
dump completed overnight, and I collected a complete vmcore for dump
level 31.  It looks like from the console log the system "cycled" twice
with this setting, two passes of excluding and copying, before the dump
was completed. I am in the process of making a more precise timing
measurement of the dump time today.  Looks like each cycle takes about 1
hour for this system, with the majority of this time spent in "Excluding
unnecessary pages" phase of each cycle.  

However if I understand what you are doing with the cyclic-buffer
parameter, it seems we are taking up 128 MB  of the crash kernel memory
space for this buffer, and it may have to scale larger to get decent
performance on larger memory. 

Is that conclusion correct?

I was only successful with the new makedumpfile with cyclic-buffer set
to 128 MB when I set crashkernel=384 MB, but ran out of memory trying to
start dump  (Out of memory killer killed makedumpfile) when
crashkernel=256 MB, on this system. 

Will we be able to dump larger memory systems, up to 12 TB for instance,
with any kind of reasonable performance, with a crashkernel size limited
to 384 MB, as I understand all current upstream kernels are now?  

If the ratio of memory size to total bitmap space is assumed linear,
this would predict a 12 TB system would take about 6 cycles to dump. And
larger memory will need even more cycles, etc. I can see where
performance improvements in getting through each cycle will make this
better, so more cycles will not mean that much increase in dump time
over the copy time, but I am concerned for crashkernel size being able
to stay at 384MB, and still be able to accommodate a large enough
cyclic-buffer size to maintain a reasonable dump time on future large
memory systems.  

What other things on a large system will effect usable crashkernel size,
that will make it insufficient to support a 128 MB cyclic-buffer size? 

Or will the cycle performance fixes proposed for the future makedumpfile
versions improve things enough that performance penalties for having a
large number of cycles to dump will be small enough not to matter?

Thanks,
Lisa Mitchell 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
