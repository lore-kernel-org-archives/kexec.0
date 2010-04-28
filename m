Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O78SS-0003Ca-MG
	for kexec@lists.infradead.org; Wed, 28 Apr 2010 14:41:51 +0000
Date: Wed, 28 Apr 2010 10:41:46 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <57520522.1227211272465706080.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1097992663.1226991272465608243.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: [PATCH 1/2] kexec: add phys_offset field
MIME-Version: 1.0
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
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: kexec@lists.infradead.org


----- "Mika Westerberg" <ext-mika.1.westerberg@nokia.com> wrote:

> On Tue, Apr 27, 2010 at 03:08:54PM +0200, ext Dave Anderson wrote:
> > ----- "Mika Westerberg" <ext-mika.1.westerberg@nokia.com> wrote:
> > > 
> > > Idea here was to make sure that virtual addresses in PT_LOAD segments are
> > > calculated correctly based on PHYS_OFFSET field. For example with OMAP3,
> > > physical memory starts at 0x80000000 so for 0xc0000000 (PAGE_OFFSET) 
> > > we get:
> > > 
> > > 	phdr->p_vaddr = 0x80000000 + 0xc0000000 = 0x40000000
> > > 
> > > which is not correct. But taking PHYS_OFFSET into equation we get
> > > 
> > > 	phdr->p_vaddr = 0x80000000 + 0xc0000000 - 0x80000000 =  0xc0000000
> > > 
> > > which is correct.
> > 
> > Yes, I understand completely -- we've been there...  ;-)
> > 
> > The issue is that there would be a disconnect between the actual kernel
> > virtual addresses used in the vmlinux file vs. your "calculated" virtual
> > addresses in the header, and to me that goes against the grain of what
> > the p_vaddr field is supposed to mean. 
> > 
> > The ELF spec defines them:
> > 
> >   p_vaddr  This member gives the virtual address at which the first
> >            byte of the segment resides in memory.
> > 
> >   p_paddr  On systems for which physical addressing is relevant, this
> >            member is reserved for the segment's physical address.
> >            Because System V ignores physical addressing for application
> >            programs, this member has unspecified contents for executable
> >            files and shared objects.
> > 
> > To me, the term "virtual address" means the virtual addresses used by the
> > executable.  Your scheme "calculates" a p_vaddr based upon the p_paddr.
> 
> Sorry, I have to ask some clarifications to understand this.
> 
> If the kernel image is linked at virtual address 0xc0008000 which is the case
> with ARM kernel for example. Then how following is legitimate kernel virtual
> address?
> 
> 	phdr->p_vaddr = mstart + elf_info->page_offset;
> 
> if the first physical memory region starts for example at 0x80000000, and
> PAGE_OFFSET is 0xc0000000 we get:
> 
> 	phdr->p_vaddr = 0x80000000 + 0xc0000000
> 
> this results virtual address 0x40000000 (in 32-bit) for the kernel direct mapped
> region, which I think is not the same as used by the executable (the vmlinux
> file):
> 
> % objdump -h vmlinux
> 
> vmlinux:     file format elf32-little
> 
> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>   0 .note.gnu.build-id 00000024  00000000  00000000  00008000  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   1 .init         0001f6ed  c0008000  c0008000  00010000  2**5
>                   CONTENTS, ALLOC, LOAD, CODE
>   2 .text         0031706a  c0028000  c0028000  00030000  2**6
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> ...
> 
> Am I missing something?

I may be missing something w/respect to 32-bit x86, but AIUI, the
unity-mapped region can only map the first 1GB of physical memory,
starting at physical address 0.  So you couldn't do what you suggest,
i.e., where the resultant unity-mapped address wraps around into
the user-space region.

But for x86, their is no concept of a mapped kernel region in addition
to the unity-mapped region(s), as there is with x86_64 and ia64.  It's
presumed that the primary kernel is based at physical adress 0, so when
the PAGE_OFFSET is stripped off, you have the physical address.

Dave
 



 




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
