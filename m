Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzaqN-00050N-MO
 for kexec@lists.infradead.org; Thu, 27 Oct 2016 02:55:05 +0000
Date: Thu, 27 Oct 2016 10:54:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized
 base enabled
Message-ID: <20161027025437.GA20670@dhcp-128-65.nay.redhat.com>
References: <cover.1477327674.git.panand@redhat.com>
 <20161027023743.GA20446@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161027023743.GA20446@dhcp-128-65.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: anderson@redhat.com, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, bhe@redhat.com

I put the cped-vmcore/vmlinux here:
https://people.redhat.com/~ruyang/test/

Adding Dave Anderson for any comments about the vmcore correctness from
crash point of view..

On 10/27/16 at 10:37am, Dave Young wrote:
> Hi Pratyush,
> 
> On 10/24/16 at 10:18pm, Pratyush Anand wrote:
> > Patch 1/4 fixes page_offset calculation, so that it is correctly calculated
> > on KASLR enabled kernel as well.
> > Patch 2/4 simplifies VA to PA translation. New code has been benchmarked
> > against old code on a 4T system.
> > Patch 3/4 and 4/4 is removal of (now) unnecessary code.
> > 
> > I think, we should find a way to kill find_vememmap() as well, so that
> > VMEMMAP_START can be removed. I have very limited idea about x86, so unable
> > to do that as of now.
> > 
> > Pratyush Anand (4):
> >   x86_64: Calculate page_offset from pt_load
> >   x86_64: translate all VA to PA using page table values
> >   x86_64: kill is_vmalloc_addr_x86_64()
> >   x86_64: kill some unused initialization
> > 
> >  arch/x86_64.c  | 84 ++++++++++++++++++++--------------------------------------
> >  makedumpfile.h |  9 +++----
> >  2 files changed, 32 insertions(+), 61 deletions(-)
> > 
> 
> According to our test, with these patches the dumped vmcore is correct
> which means simple crash test `bt` works. But the saved vmcore size is
> larger than before.
> 
> I collected two --message-level 31 logs with/without your patches, the
> kernel kaslr was disabled during my test so that we can focus on the
> vmcore size issue, it looks like mem_map address was not collected
> correctly.
> 
> [please ignore the patched log extra debug message I added] 
> 
> --- unpatched-makedumpfile.txt	2016-10-27 10:31:34.152962407 +0800
> +++ patched-makedumpfile.txt	2016-10-27 10:28:44.213952179 +0800
> @@ -1,4 +1,4 @@
> -[127.0.0.1-2016-10-27-10:27:03]# /tmp/makedumpfile -l -d 31 --message-level 31 vmcore vmcore.m.1
> +[127.0.0.1-2016-10-27-10:27:03]# /home/dyoung/git/makedumpfile/makedumpfile -l -d 31 --message-level 31 vmcore vmcore.m
>  sadump: does not have partition header
>  sadump: read dump device as unknown format
>  sadump: unknown format
> @@ -36,70 +36,76 @@
>  
>  Memory type  : SPARSEMEM_EX
>  
> +printing memmap .....
>  mem_map (0)
> -  mem_map    : ffffea0000000000
> +  mem_map    : 0
>    pfn_start  : 0
>    pfn_end    : 8000
> +printing memmap .....
>  mem_map (1)
> -  mem_map    : ffffea0000200000
> +  mem_map    : 0
>    pfn_start  : 8000
>    pfn_end    : 10000
> +printing memmap .....
>  mem_map (2)
> -  mem_map    : ffffea0000400000
> +  mem_map    : 0
>    pfn_start  : 10000
>    pfn_end    : 18000
> +printing memmap .....
>  mem_map (3)
> -  mem_map    : ffffea0000600000
> +  mem_map    : 0
>    pfn_start  : 18000
>    pfn_end    : 20000
> +printing memmap .....
>  mem_map (4)
> -  mem_map    : ffffea0000800000
> +  mem_map    : 0
>    pfn_start  : 20000
>    pfn_end    : 28000
> +printing memmap .....
>  mem_map (5)
> -  mem_map    : ffffea0000a00000
> +  mem_map    : 0
>    pfn_start  : 28000
>    pfn_end    : 30000
> +printing memmap .....
>  mem_map (6)
> -  mem_map    : ffffea0000c00000
> +  mem_map    : 0
>    pfn_start  : 30000
>    pfn_end    : 38000
> +printing memmap .....
>  mem_map (7)
> -  mem_map    : ffffea0000e00000
> +  mem_map    : 0
>    pfn_start  : 38000
>    pfn_end    : 3ffda
>  mmap() is available on the kernel.
>  Checking for memory holes          : [100.0 %] |STEP [Checking for memory holes  ] : 0.000030 seconds
> -Excluding unnecessary pages        : [100.0 %] \STEP [Excluding unnecessary pages] : 0.007547 seconds
> -Checking for memory holes          : [100.0 %] -STEP [Checking for memory holes  ] : 0.000016 seconds
> -Checking for memory holes          : [100.0 %] /STEP [Checking for memory holes  ] : 0.000009 seconds
> -Excluding unnecessary pages        : [100.0 %] |STEP [Excluding unnecessary pages] : 0.006623 seconds
> -Copying data                       : [100.0 %] \STEP [Copying data               ] : 0.184442 seconds
> -Copying data                       : [100.0 %] -STEP [Copying data               ] : 0.000041 seconds
> +Excluding unnecessary pages        : [100.0 %] \STEP [Excluding unnecessary pages] : 0.000007 seconds
> +Checking for memory holes          : [100.0 %] -STEP [Checking for memory holes  ] : 0.000014 seconds
> +Checking for memory holes          : [100.0 %] /STEP [Checking for memory holes  ] : 0.000008 seconds
> +Excluding unnecessary pages        : [100.0 %] |STEP [Excluding unnecessary pages] : 0.000007 seconds
> +Copying data                       : [100.0 %] /STEP [Copying data               ] : 1.421661 seconds
> +Copying data                       : [100.0 %] |STEP [Copying data               ] : 0.000036 seconds
>  
>  Writing erase info...
> -offset_eraseinfo: dd5c4e, size_eraseinfo: 0
> +offset_eraseinfo: 888c149, size_eraseinfo: 0
>  
>  Original pages  : 0x0000000000030c7d
> -  Excluded pages   : 0x000000000002cf58
> -    Pages filled with zero  : 0x00000000000002be
> -    Non-private cache pages : 0x0000000000006574
> -    Private cache pages     : 0x0000000000000f27
> -    User process data pages : 0x0000000000003481
> -    Free pages              : 0x000000000002237e
> +  Excluded pages   : 0x000000000001d534
> +    Pages filled with zero  : 0x000000000001d534
> +    Non-private cache pages : 0x0000000000000000
> +    Private cache pages     : 0x0000000000000000
> +    User process data pages : 0x0000000000000000
> +    Free pages              : 0x0000000000000000
>      Hwpoison pages          : 0x0000000000000000
> -  Remaining pages  : 0x0000000000003d25
> -  (The number of pages is reduced to 7%.)
> +  Remaining pages  : 0x0000000000013749
> +  (The number of pages is reduced to 39%.)
>  Memory Hole     : 0x000000000000f35d
>  --------------------------------------------------
>  Total pages     : 0x000000000003ffda
>  
> -Cache hit: 29946, miss: 47, hit rate: 99.8%
> +Cache hit: 196285, miss: 201, hit rate: 99.9%
>  
>  
> -The dumpfile is saved to vmcore.m.1.
> +The dumpfile is saved to vmcore.m.
>  
>  makedumpfile Completed.
> -[root@dhcp-128-65 127.0.0.1-2016-10-27-10:27:03]# ls -lth vmcore.m*
> --rw------- 1 root root  14M Oct 27 10:30 vmcore.m.1
> --rw------- 1 root root 137M Oct 27 10:28 vmcore.m
> +[root@dhcp-128-65 127.0.0.1-2016-10-27-10:27:03]# 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
