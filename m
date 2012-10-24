Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQvfj-0002Mv-Ge
 for kexec@lists.infradead.org; Wed, 24 Oct 2012 07:46:42 +0000
Date: Wed, 24 Oct 2012 16:45:08 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
Message-Id: <20121024164508.a2707a96b532a6766228bec5@mxc.nes.nec.co.jp>
In-Reply-To: <1350912018.13097.54.camel@lisamlinux.fc.hp.com>
References: <1350912018.13097.54.camel@lisamlinux.fc.hp.com>
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
To: lisa.mitchell@hp.com
Cc: kexec@lists.infradead.org, jerry.hoemann@hp.com

Hello Lisa,

On Mon, 22 Oct 2012 07:20:18 -0600
Lisa Mitchell <lisa.mitchell@hp.com> wrote:

> Jerry Hoemann and I tested the new makedumpfile 1.5.0 on a DL980 with 4
> TB of memory, which is the maximum supported for this system.  We tested
> it on top of a 2.6.32 kernel plus patches, had the dump level set to 31
> for smallest dump,  and  found that the dump would not complete in a
> reasonable time frame, basically staying for over 16 hours in the state
> where it cycled through "Excluding Free pages" (would go from 0-100%)
> and "Excluding unnecessary pages" (0-100%). It just alternated between
> these two all night. I did not try waiting longer than 17 hours to see
> if it ever completed, because with an earlier makedumpfile on this same
> system, the dump would complete in a few hours.  Console logs can be
> provided if desired.
> 
> Are we are seeing known issues that will be addressed in the next
> makedumpfile?  
> 
> >From this email chain, it sounds like others see similar issues, but we
> want to be sure we are not seeing something different.

I think you're seeing the known issue which we discussed, I will address it
in v1.5.1 and v1.5.2.
 
> I can arrange for access to a DL980 with 4 TB of memory later when the
> new makedumpfile v1.5.1 is available, and we would very much like to
> test any fixes on our 4 TB system. Please let me know when it is
> available to try.

I will release the next version by the end of this year.
If you need some workarounds now, please use the workaroud described in
the release note:

  http://lists.infradead.org/pipermail/kexec/2012-September/006768.html

     At least in v1.5.0, if you feel the cyclic mode is slow, you can try 2 workaronds:
     
       1. Use old running mode with "--non-cyclic" option.
     
       2. Decrease the number of cycles by increasing BUFSIZE_CYCLIC with 
          "--cyclic-buffer" option.
     
     Please refer to the manual page for how to use these options.

> Meanwhile, if there are debug steps we could take to better understand
> the performance issue, and help get this new solution working (so dumps
> can scale to larger memory, and we can keep crashkernel size limited to
> 384 MB), please let me know.

At first, the behavior of makedumpfile can be described as two steps:

  Step1. analysis
    Analyzing vmcore and creating the bitmap which represent whether each pages
    should be excluded or not. 
    v1.4.4 or before save the bitmap into a file and it grows with the size of
    vmcore, while v1.5.0 saves it in memory and the size of it is constant
    based on BUFSIZE_CYCLIC parameter.
    The bitmap is the biggest memory footprint and that's why v1.5.0 can work
    in constant memory space.

  Step2. writing
    Writing each pages to a disk according to the bitmap created in step1.

Second, I show the process image below:

 a. v1.4.4 or before

   [process image]

     cycle                       1
                   +-----------------     -----+
     vmcore        |                  ...      | 
                   +-----------------     -----+

   [execution sequence]

      cycle  |   1   
    ---------+-------
      step1  |   1
             |
      step2  |   2

  [bitmap]
  
     Save the bitmap for the whole of vmcore at a time.


 b. v1.5.0
 
  [process image]
   
    cycle           1   2   3   4    ...    N
                  +-----------------     -----+
    vmcore        |   |   |   |   |  ...  |   | 
                  +-----------------     -----+

  [execution sequence]

      cycle  |   1   2   3   4    ...     N
    ---------+------------------------------------
      step1  |   1  /3  /5  /7  /      (2N-1)
             |   | / | / | / | /          |
      step2  |   2/  4/  6/  8/         (2N)

  [bitmap]

     Save the bitmap only for a cycle at a time.


Step1 should scan only the constant region of vmcore correspond to each cycle, 
but the current logic needs to scan all free pages every cycle.
To sum it up, the more the number of cycle, the more redundant scans will be done. 

The default BUFSIZE_CYCLIC of v1.5.0 is too small for terabytes of memory,
the number of cycle will be so large. (e.g. N is 32 in 1TB machines.)
As a result, a lot of time will be spend for step1.

Therefore, I will implement the feature to reduce the number of cycle as few as
possible automatically in v1.5.1.
Now, you can get the same benefit by allocating enough memory with --cyclic-buffer
option. For 4TB machines, you should specify "--cyclic-buffer 131072" if it's possible.
(In this case, 256MB is required actually. Please see the man page for the
details of this option.)

Additionally, I will resolve the issue included in the logic of excluding
free pages in v1.5.2.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
