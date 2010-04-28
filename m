Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.122.233] helo=mgw-mx06.nokia.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1O77qH-0000sc-UG
	for kexec@lists.infradead.org; Wed, 28 Apr 2010 14:02:23 +0000
Date: Wed, 28 Apr 2010 17:01:33 +0300
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [PATCH 1/2] kexec: add phys_offset field
Message-ID: <20100428140133.GD12682@esdhcp04058.research.nokia.com>
References: <2142045805.1116661272373114053.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<686245124.1118581272373734052.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <686245124.1118581272373734052.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
To: ext Dave Anderson <anderson@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Apr 27, 2010 at 03:08:54PM +0200, ext Dave Anderson wrote:
> ----- "Mika Westerberg" <ext-mika.1.westerberg@nokia.com> wrote:
> > 
> > Idea here was to make sure that virtual addresses in PT_LOAD segments are
> > calculated correctly based on PHYS_OFFSET field. For example with OMAP3,
> > physical memory starts at 0x80000000 so for 0xc0000000 (PAGE_OFFSET) 
> > we get:
> > 
> > 	phdr->p_vaddr = 0x80000000 + 0xc0000000 = 0x40000000
> > 
> > which is not correct. But taking PHYS_OFFSET into equation we get
> > 
> > 	phdr->p_vaddr = 0x80000000 + 0xc0000000 - 0x80000000 = 0xc0000000
> > 
> > which is correct.
> 
> Yes, I understand completely -- we've been there...  ;-)
> 
> The issue is that there would be a disconnect between the actual kernel
> virtual addresses used in the vmlinux file vs. your "calculated" virtual
> addresses in the header, and to me that goes against the grain of what
> the p_vaddr field is supposed to mean. 
> 
> The ELF spec defines them:
> 
>   p_vaddr  This member gives the virtual address at which the first
>            byte of the segment resides in memory.
> 
>   p_paddr  On systems for which physical addressing is relevant, this
>            member is reserved for the segment's physical address.
>            Because System V ignores physical addressing for application
>            programs, this member has unspecified contents for executable
>            files and shared objects.
> 
> To me, the term "virtual address" means the virtual addresses used by the
> executable.  Your scheme "calculates" a p_vaddr based upon the p_paddr.

Sorry, I have to ask some clarifications to understand this.

If the kernel image is linked at virtual address 0xc0008000 which is the case
with ARM kernel for example. Then how following is legitimate kernel virtual
address?

	phdr->p_vaddr = mstart + elf_info->page_offset;

if the first physical memory region starts for example at 0x80000000, and
PAGE_OFFSET is 0xc0000000 we get:

	phdr->p_vaddr = 0x80000000 + 0xc0000000

this results virtual address 0x40000000 (in 32-bit) for the kernel direct mapped
region, which I think is not the same as used by the executable (the vmlinux
file):

% objdump -h vmlinux

vmlinux:     file format elf32-little

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .note.gnu.build-id 00000024  00000000  00000000  00008000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .init         0001f6ed  c0008000  c0008000  00010000  2**5
                  CONTENTS, ALLOC, LOAD, CODE
  2 .text         0031706a  c0028000  c0028000  00030000  2**6
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
...

Am I missing something?

Thanks again,
MW

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
