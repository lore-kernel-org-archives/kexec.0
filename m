Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.122.230] helo=mgw-mx03.nokia.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1O6hPA-0004Sl-Bt
	for kexec@lists.infradead.org; Tue, 27 Apr 2010 09:48:38 +0000
Date: Tue, 27 Apr 2010 12:47:38 +0300
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [PATCH 1/2] kexec: add phys_offset field
Message-ID: <20100427094738.GA12682@esdhcp04058.research.nokia.com>
References: <596100997.1053951272306593777.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<1338110291.1054301272306741075.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1338110291.1054301272306741075.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org

I'm not subscribed to the list so please CC me. I had to dig this message from
the archives.

On Mon, Apr 26, 2010 at 02:32:21PM -0400, Dave Anderson wrote:
> 
> ----- kexec-request at lists.infradead.org wrote:
> 
> > 
> > Message: 1
> > Date: Mon, 26 Apr 2010 12:03:30 +0300
> > From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > To: kexec@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH 1/2] kexec: add phys_offset field
> > Message-ID:
> > 
> > <e376969c3d29696ce11488af59605ada56fdccff.1272271391.git.ext-mika.1.westerberg@nokia.com>
> > 	
> > 
> > Add new field 'phys_offset' to struct elf_info. This field is used to calculate
> > virtual address of PT_LOAD segment on architectures where physical memory
> > doesn't always start at address 0 (namely ARM).
> > 
> > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > ---
> >  kexec/crashdump-elf.c |    9 ++++++++-
> >  kexec/crashdump.h     |    1 +
> >  2 files changed, 9 insertions(+), 1 deletions(-)
> > 
> > diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
> > index 6bcef8d..1291174 100644
> > --- a/kexec/crashdump-elf.c
> > +++ b/kexec/crashdump-elf.c
> > @@ -236,7 +236,14 @@ int FUNC(struct kexec_info *info,
> >  		 * memory region.
> >  		 */
> >  		phdr->p_paddr = mstart;
> > -		phdr->p_vaddr = mstart + elf_info->page_offset;
> > +		/*
> > +		 * In some architectures (namely ARM), physical memory doesn't
> > +		 * always start at 0 so we need to calculate virtual address
> > +		 * based on elf_info->phys_offset like:
> > +		 *     virt = phys + page_offset - phys_offset
> > +		 */
> > +		phdr->p_vaddr = mstart + elf_info->page_offset -
> > +				elf_info->phys_offset;
> >  		phdr->p_filesz	= phdr->p_memsz	= mend - mstart + 1;
> >  		/* Do we need any alignment of segments? */
> >  		phdr->p_align	= 0;
> > diff --git a/kexec/crashdump.h b/kexec/crashdump.h
> > index 30d6f29..8c0ccda 100644
> > --- a/kexec/crashdump.h
> > +++ b/kexec/crashdump.h
> > @@ -27,6 +27,7 @@ struct crash_elf_info {
> >  	unsigned long backup_src_end;
> >  
> >  	unsigned long long page_offset;
> > +	unsigned long long phys_offset;
> >  	unsigned long lowmem_limit;
> >  
> >  	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
> > -- 
> 
> Can you can possibly leave the p_vaddr field as-is on the other
> non-ARM architectures?

Sure. I assumed that all architectures declare struct crash_elf_info as static
data but x86_64 seems to allocate it from the stack.

If we change x86_64 part not to allocate it from the stack then this should
have no effect on architectures that don't specify elf_info->phys_offset. Does
that sound reasonable?

> The p_vaddr field in the ELF header has always been presumed
> to be a kernel unity-mapped virtual address.  As I understand
> it, this will create a "hybrid" virtual address that is no longer
> aligned with the kernel's concept of a unity-mapped address.

Idea here was to make sure that virtual addresses in PT_LOAD segments are
calculated correctly based on PHYS_OFFSET field. For example with OMAP3,
physical memory starts at 0x80000000 so for 0xc0000000 (PAGE_OFFSET) we get:

	phdr->p_vaddr = 0x80000000 + 0xc0000000 = 0x40000000

which is not correct. But taking PHYS_OFFSET into equation we get

	phdr->p_vaddr = 0x80000000 + 0xc0000000 - 0x80000000 = 0xc0000000

which is correct.

> The crash utility for other architectures calculates the phys_offset,
> or has the phys_base passed in the makedumpfile header.

OK. I'll have to check these. I had the impression that vmcore file could be
used also as-is without any post-processing.

Thanks,
MW

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
