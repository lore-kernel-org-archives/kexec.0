Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ULUbV-0007WV-Qg
 for kexec@lists.infradead.org; Fri, 29 Mar 2013 08:24:08 +0000
Date: Fri, 29 Mar 2013 17:13:11 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile: question about memory hole
Message-Id: <20130329171311.a6a58518c13a7a5dec600bd6@mxc.nes.nec.co.jp>
In-Reply-To: <20130319.174745.69663044.d.hatayama@jp.fujitsu.com>
References: <20130319104137.b8aff16a428e6393e32e9d20@mxc.nes.nec.co.jp>
 <20130319.114220.118274790.d.hatayama@jp.fujitsu.com>
 <20130319164926.2f5a8bff1b5ee4ab4857df65@mxc.nes.nec.co.jp>
 <20130319.174745.69663044.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello HATAYAMA-san,

Sorry for the delayed response.

On Tue, 19 Mar 2013 17:47:45 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> >> >> What I don't understand well is that the part here:
> >> >> 
> >> >>                 pfn_start = paddr_to_pfn(phys_start);
> >> >>                 pfn_end   = paddr_to_pfn(phys_end);
> >> >> 
> >> >>                 if (!is_in_segs(pfn_to_paddr(pfn_start)))
> >> >>                         pfn_start++;
> >> >> 
> >> >> phys_start and pfn_to_paddr(pfn_start) should belong to the same page
> >> >> frame, so I suspect the pfn_start should be included in vmcore.
> >> >> 
> >> >> Looking into kexec-tool side, I don't see additional modification made
> >> >> to phys_start after it's parsed from /proc/iomem or counterpart on EFI
> >> >> interface. Is there any assumption about memory holes behind kernel?
> >> > 
> >> > Here is a PT_LOAD segment of ia64 machine which I actually use:
> >> > 
> >> >   Type           Offset             VirtAddr           PhysAddr
> >> >                  FileSiz            MemSiz              Flags  Align
> >> > [...]
> >> >   LOAD           0x000000015fd0b490 0xe0000040ffda5000 0x00000040ffda5000
> >> >                  0x000000000005a000 0x000000000005a000  RWE    0
> >> > 
> >> > In this case, pfn_to_paddr(pfn_start) is aligned to 0x40ffda4000 
> >> > because the page size is 16KiB, and this address is out of PT_LOAD
> >> > segment.
> >> > 
> >> >          phys_start
> >> >          = 0x40ffda5000                        
> >> >             |------------- PT_LOAD ----------------
> >> >      ----+----------+----------+----------+--------
> >> >          |   pfn:N  |  pfn:N+1 | pfn:N+2  |  ...
> >> >      ----+----------+----------+----------+--------
> >> >          |
> >> >    pfn_to_paddr(pfn:N)
> >> >    = 0x40ffda4000
> >> > 
> >> > The statement you said is for care the case that phys_start isn't aligned
> >> > with the page size.
> >> > 
> >> > BTW, I'll add a comment to explain this intention into here.
> >> 
> >> Thanks for the pictorial explanation. It's easy to understand.
> >> 
> >> Still I think pfn:N should be included in vmcore. The current
> >> implementation drops [0x40ffda5000, 0x40ffda8000] that is contained in
> >> the PT_LOAD. Or, the range must be hole or other kinds of unnecessary
> >> memory from some kernel-side assumption?
> > 
> > Oh, I understand your question correctly now.
> > 
> > When Ohmichi-san wrote this code, he thought the page which include
> > memory hole isn't be used. This came from the fact that the basic
> > unit of memory management is *page*, but there is no detailed
> > investigation. 
> 
> You mean on at least IA64 case such parts are always holes?

I showed the IA64 case just to say that the statement can be executed
actually and it's meaningful code, and this is from my misunderstanding
of your question.
Whether such parts are holes or not is another matter, and I haven't
enough information to decide it now.
 
> > 
> > So, if there is any case where pfn:N is actually used, this statement
> > should be removed. Maybe, does this question come from an idea of such
> > cases ?
> 
> I'm wondering if such case can actually happens.

I checked a memory map on another IA64 machine and found the regions
that not be aligned by page-size:

  # cat /proc/iomem  | grep System
  ...
  4040000000-40fea09fff : System RAM
  40fea0a000-40fef5ffff : System RAM       // start address isn't page-aligned
  40fef60000-40fef63fff : System RAM

According to this, it seems that such regions can be exist normally
at least on IA64.　So, what we should investigate is how does kernel
manage such regions (e.g. [0x40fea0a000, 0x40fea0c000]).
And this is the "kernel-side assumption" you said first, right ?

Since multiple page sizes are supported, I suppose some cases like
below may happen, so I'll confirm it.


      |-------------------------- PT_LOAD ------------------------------

      | 4k page| 4k page|            16k page            |
  ----+--------+--------+--------------------------------+--------------
      | pfn:N  | pfn:N+1|            pfn:N+2             |  ...
  ----+--------+--------+--------------------------------+--------------
      |        |        |                                |
0x40fea0a000   |   0x40fea0c000                    0x40fea10000
               |
          0x40fea0b000

> Even apart from the IA64 case, the regions that is not page-size
> aligned can occur if some parts of System RAM are converted into other
> types of memory at runtime.
> 
> So, ideally, we should handle page frames that corresponds to start
> and end of each PT_LOAD entries specially, filling the ranges not
> covered by any PT_LOAD entries with 0.
 
If the cases like I showed above can happen, makedumpfile should be
fixed as you said.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
