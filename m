From: Will Deacon <will@kernel.org>
Date: Wed, 16 Feb 2022 12:40:27 +0000
Subject: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
In-Reply-To: <YgzD0ZfZF34u6whJ@hsj>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
 <20220215164423.GB8458@willie-the-truck> <YgzD0ZfZF34u6whJ@hsj>
Message-ID: <20220216124026.GB9949@willie-the-truck>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Feb 16, 2022 at 09:28:49AM +0000, Huang Shijie wrote:
> Hi Will,
> On Tue, Feb 15, 2022 at 04:44:23PM +0000, Will Deacon wrote:
> > On Wed, Feb 09, 2022 at 09:26:42AM +0000, Huang Shijie wrote:
> > > The following interrelated ranges are needed by the kdump crash tool:
> > > 	MODULES_VADDR ~ MODULES_END,
> > > 	VMALLOC_START ~ VMALLOC_END,
> > > 	VMEMMAP_START ~ VMEMMAP_END
> > > 
> > > Since these values change from time to time, it is preferable to export
> > > them via vmcoreinfo than to change the crash's code frequently.
> > 
> > Please can you explain _why_ they are needed?
> 
> The current Crash code is still based at kernel v4.9.
>    The virtual memory layout looks like this:
>    +--------------------------------------------------------------------+
>    |    KASAN     |   MODULE   |   VMALLOC   | .... |     VMEMMAP       |
>    +--------------------------------------------------------------------+
> 
> The Crash uses MODULES range to set the VMALLOC ranges.
> If the ranges are wrong, Crash will _NOT_ works well for some latest kernel
> ,such as v5.11 later. (Please correct me if I am wrong).
> It seems the VMEMMAP range is less important.

[...]

> 5.) In the kernel v5.16, after the patch
>       "b89ddf4cca43 arm64/bpf: Remove 128MB limit for BPF JIT programs"
>     the virtual memory layout looks like this:
> 
>    +--------------------------------------------------------------------+
>    |      MODULE     |   VMALLOC   |     ....     |      VMEMMAP        |
>    +--------------------------------------------------------------------+
> 
>     The macros are:
>     #define MODULES_VADDR	(_PAGE_END(VA_BITS_MIN))
>     #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
> 
>     #define VMALLOC_START	(MODULES_END)
>     #define VMALLOC_END		(VMEMMAP_START - SZ_256M)
> 
>     #define VMEMMAP_START	(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
>     #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
> 
> 
> BTW:I am currently coding a patch for the Crash to update all the ranges to
> the latest kernel version v5.17-rc4.

Thanks for digging up all of the kernel memory map changes and taking the
time to explain the macros. However, all I'm really after is something in
the commit message of the patch which explains what is broken without this
patch. What does crash use this information for, and what doesn't work at
the moment?

Cheers,

Will

