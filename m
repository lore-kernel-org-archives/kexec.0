From: Huang Shijie <shijie@os.amperecomputing.com>
Date: Wed, 16 Feb 2022 09:28:49 +0000
Subject: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
In-Reply-To: <20220215164423.GB8458@willie-the-truck>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
 <20220215164423.GB8458@willie-the-truck>
Message-ID: <YgzD0ZfZF34u6whJ@hsj>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Will,
On Tue, Feb 15, 2022 at 04:44:23PM +0000, Will Deacon wrote:
> On Wed, Feb 09, 2022 at 09:26:42AM +0000, Huang Shijie wrote:
> > The following interrelated ranges are needed by the kdump crash tool:
> > 	MODULES_VADDR ~ MODULES_END,
> > 	VMALLOC_START ~ VMALLOC_END,
> > 	VMEMMAP_START ~ VMEMMAP_END
> > 
> > Since these values change from time to time, it is preferable to export
> > them via vmcoreinfo than to change the crash's code frequently.
> 
> Please can you explain _why_ they are needed?

The current Crash code is still based at kernel v4.9.
   The virtual memory layout looks like this:
   +--------------------------------------------------------------------+
   |    KASAN     |   MODULE   |   VMALLOC   | .... |     VMEMMAP       |
   +--------------------------------------------------------------------+

The Crash uses MODULES range to set the VMALLOC ranges.
If the ranges are wrong, Crash will _NOT_ works well for some latest kernel
,such as v5.11 later. (Please correct me if I am wrong).
It seems the VMEMMAP range is less important.


I list all the changes since v4.9 to now:

1.) The current crash code is based at kernel v4.9.
   The virtual memory layout looks like this:
   +--------------------------------------------------------------------+
   |    KASAN     |   MODULE   |   VMALLOC   | .... |     VMEMMAP       |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(VA_START + KASAN_SHADOW_SIZE)
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)

    #define VMEMMAP_START	(PAGE_OFFSET - VMEMMAP_SIZE)

2.) In the kernel v5.0, the patch will add a new BFP JIT region:
       "91fc957c9b1d arm64/bpf: don't allocate BPF JIT programs in module memory"

   The virtual memory layout looks like this:
   +--------------------------------------------------------------------+
   | KASAN | BPF_JIT | MODULE | VMALLOC |     ....     | VMEMMAP        |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(BPF_JIT_REGION_END)
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)

    #define VMEMMAP_START	(PAGE_OFFSET - VMEMMAP_SIZE)

    The layout does not changed until v5.4.

3.) In the kernel v5.4, several patches changes the layout, such as:
       "ce3aaed87344 arm64: mm: Modify calculation of VMEMMAP_SIZE"
       "14c127c957c1 arm64: mm: Flip kernel VA space"
    and the virtual memory layout looks like this:

   +--------------------------------------------------------------------+
   | KASAN | BPF_JIT | MODULE | VMALLOC |     ....     | VMEMMAP        |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(BPF_JIT_REGION_END)
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(- PUD_SIZE - VMEMMAP_SIZE - SZ_64K)

    #define VMEMMAP_START	(-VMEMMAP_SIZE - SZ_2M)

4.) In the kernel v5.11, several patches changes the layout, such as:
       "9ad7c6d5e75b arm64: mm: tidy up top of kernel VA space"
       "f4693c2716b3 arm64: mm: extend linear region for 52-bit VA configurations"
    and the virtual memory layout looks like this:

   +--------------------------------------------------------------------+
   |   BPF_JIT | MODULE  |  VMALLOC   |    ....    |     VMEMMAP        |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(BPF_JIT_REGION_END)
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(VMEMMAP_START - SZ_256M)

    #define VMEMMAP_START	(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
    #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)

5.) In the kernel v5.16, after the patch
      "b89ddf4cca43 arm64/bpf: Remove 128MB limit for BPF JIT programs"
    the virtual memory layout looks like this:

   +--------------------------------------------------------------------+
   |      MODULE     |   VMALLOC   |     ....     |      VMEMMAP        |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(_PAGE_END(VA_BITS_MIN))
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(VMEMMAP_START - SZ_256M)

    #define VMEMMAP_START	(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
    #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)


BTW:I am currently coding a patch for the Crash to update all the ranges to
the latest kernel version v5.17-rc4.

Thanks
Huang Shijie

