Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kf82b-00019o-JX
	for kexec@lists.infradead.org; Mon, 15 Sep 2008 06:58:40 +0000
Date: Mon, 15 Sep 2008 16:58:31 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] IA64: kexec allocates too few memory for kdump kernel
	itself
Message-ID: <20080915065830.GB3160@verge.net.au>
References: <48BEFB47.20004@sgi.com> <20080904000100.GD8974@verge.net.au>
	<48BF3BE8.2050806@sgi.com> <48C028D0.4050202@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48C028D0.4050202@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org

On Thu, Sep 04, 2008 at 11:28:32AM -0700, Jay Lan wrote:
> Jay Lan wrote:
> > Simon Horman wrote:
> >> On Wed, Sep 03, 2008 at 02:01:59PM -0700, Jay Lan wrote:
> >>> Sometimes the kexec would allocate not enough memory for kdump kernel
> >>> itself on IA64 and caused kdump kernel to panic at boot.
> >>>
> >>> When it happens, the /proc/iomem would show a kernel RAM segment like
> >>> this:
> >>> 3014000000-3015294fff : System RAM
> >>>   3014000000-3014823ccf : Kernel code
> >>>   3014823cd0-3014dee8ef : Kernel data
> >>>   3014dee8f0-301529448f : Kernel bss
> >>> 3015295000-307bffdfff : System RAM
> >>>   3018000000-3037ffffff : Crash kernel
> >>>
> >>> But kexec would allocate memory 3018000000-3019290000 for the kernel,
> >>> which is 0x5000 smaller than the regular kernel. In my cases, the
> >>> physical_node_map and kern_memmap of the kdump kernel overlaped and
> >>> caused data corruption.
> >>>
> >>> This patch fixes the problem. The patch was generated against
> >>> kexec-tools 2.0.0 and tested in 2.6.27-rc4.
> >> Hi Jay,
> >>
> >> I am unclear about why this underallocation occurs.
> > 
> > Hi Simon,
> > 
> > The routine add_loaded_segments_info() set up "loaded_segment" array
> > that is needed by purgatory code, based on data stored in the
> > mem_ehdr array passed in as the second parameter.
> > 
> > Upon entrance of the routine, the crash_memory_range[] contains
> > information about the regular kernel:
> > crash_memory_range[ 0]: start=  3000080000, end=  30003fffff
> > crash_memory_range[ 1]: start=  3003000000, end=  3005ffffff
> > crash_memory_range[ 2]: start=  3006000000, end=  3013ffffff
> > crash_memory_range[ 3]: start=  3014000000, end=  3015294fff
> > 
> > The #3 entry is the kernel memory segment.
> > 
> > And the mem_ehdr array would contain data as such:
> 
> Hi,
> 
> It should be mem_phdr, got it from mem_ehdr->e_phdr.
> 
> > i=0, p_paddr=3018000000, p_memsz=d04480, p_offset=10000, p_type=1
> > i=1, p_paddr=3018d20000, p_memsz=9620, p_offset=d20000, p_type=1
> > i=2, p_paddr=3018d30000, p_memsz=564490, p_offset=d30000, p_type=1
> > i=3, p_paddr=0, p_memsz=0, p_offset=0, p_type=4
> 
> Does anyone understand how the array were created and why there
> was a gap between i=0 and i=1 entries? I think this is the problem
> but i do not know how to fix it, so tried to work around it.
> 
> The statement my patch replaced was totally broken:
>  -			if (loaded_segments[loaded_segments_num].end !=
>  -				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
>  -				break;
>  +			if (loaded_segments[loaded_segments_num].end <
>  +			    (phdr->p_paddr & ~(ELF_PAGE_SIZE-1)) )
>  +				loaded_segments[loaded_segments_num].end
>  +				  = phdr->p_paddr & ~(ELF_PAGE_SIZE-1);
> 
> My debugging showed that when "loaded_segments[loaded_segments_num].end"
> != "phdr->p_paddr & ~(ELF_PAGE_SIZE-1)", they were treated as equal
> and continue to next statement.  However, if i assign both expression
> to local variables and do comparison, the 'break' statement is
> executed correctly when two values are not the same. Unfortunately,
> consequently the kdump kernel would _alawys_ hang.
> 
> I believe the intent of the original statement is to ensure there is
> no gap between entries of mem_phdr array. But if there is a gap,
> kexec should simply exit with failure. The 'break' statement just
> created a loaded_segment[] array that broke the kernel memory segment
> into multiple entries and resulted in the kdump kernel hang in
> find_memory(). The IA64 (at least 2.6.27-rc4) kdump kernel works in
> some cases today are simply out of luck.
> 
> I believe the real fix is to fix the contents of the mem_phdr array.
> Since i do not know how to fix it, my patch would close up the
> gap where there is the a gap between entries of the mem_phdr array.
> 
> Does it make more sense to you now, Simon?
> 
> Regards,
>  - jay
> 
> 
> 
> > 
> > The code wants the new loaded_segments contain starting address
> > all aligned at page boundary, which is 0x10000 in IA64.
> > 
> > Note that the p_memsz of mem_ehdr does not match to entries in
> > /proc/iomem:
> > 3014000000-3015294fff : System RAM
> >   3014000000-3014823ccf : Kernel code
> >   3014823cd0-3014dee8ef : Kernel data
> >   3014dee8f0-301529448f : Kernel bss
> > 
> > The original code of add_loaded_segments_info() would go through
> > the mem_ehdr array and use the p_paddr of the first entry (the
> > beginning of the reserved memory) as the start address, add
> > the p_memsz of three entries to calculate the end address of
> > the kernel segment.
> > 
> > But the p_paddr of i=0 plus p_memsz of i=0 should result in
> > 3018d10000 as the p_paddr of i=1 entry, but actually the
> > p_paddr of i=1 is 3018d20000. The logic of that routine
> > can not explain the discrepency.
> > 
> > So, where the data of mem_ehdr array come from?
> > 
> > add_loaded_segments_info
> > <-  load_crashdump_segments
> >   <-  elf_ia64_load
> >     <- file_type[i].load
> >       <- my_load
> > 
> > The elf_ia64_load set up mem_ehdr, probabaly based on data
> > pointed by *buf, which i think comes from vmlinuz.

Yes, I believe that is the case too.

> > So, i failed to find out how the p_memsz were set up initially.
> > But, i think we did it the way too complicated, IMHO.


I think that the relevant code path is:

build_mem_elf64_phdr()
called by: build_mem_phdrs()
called by: build_elf_info()
called by: build_elf_exec_info()
called by: elf_ia64_load(), before calling load_crashdump_segments()

As the PT_LOAD segments in mem_ehdr should correlate with data
read from vmlinux, perhaps you can see something interesting by running

readelf -l vmlinux

> > The crash_memory_range[] array showed the kernel segment consumed
> > 0x1295000 bytes of memory and we only need to tell the purgatory
> > code to reserve that amount of memory. The logic in
> > add_loaded_segments_info() came out with 0x1290000 and caused the
> > crashkernel to panic on boot.
> > 
> > Hmmm, as i types now, i may not consider the situation where
> > the crashkernel is not the same as the first kernel...
> > 
> > Note that the underallocation does not _ALWAYS_ happen! It depends
> > on the vmlinux we build. Honestly i do not understand some part of
> > the kexec-tools code well enough to make major surgery to the code.
> > So, i just compare the end address after calculation of i=0 entry
> > of mem_ehdr array with the start address of the second entry. If it
> > is too small, i just bring it up to align with the start address of
> > the second entry. I am happy to allocate one extra page, may not be
> > needed in some cases, of memory than to panic. Yes, my patch is
> > a work-around.
> > 
> > If you can find the true cause of the problem and fix it, it
> > would be great and appreciated!

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
