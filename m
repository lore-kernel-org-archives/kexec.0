Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5wM7-0002jU-14
 for kexec@lists.infradead.org; Thu, 26 May 2016 14:33:48 +0000
Date: Thu, 26 May 2016 15:33:15 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH kexec-tools 04/32] kdump: fix kdump mapping
Message-ID: <20160526143315.GJ19428@n2100.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSF-0004hH-Oo@e0050434b2927.dyn.arm.linux.org.uk>
 <CAHB_GurQ44ybkxaYJJQeGgnuw=3tKOk7xyB6FTAursMLuZGrJg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_GurQ44ybkxaYJJQeGgnuw=3tKOk7xyB6FTAursMLuZGrJg@mail.gmail.com>
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
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, May 25, 2016 at 11:47:33AM +0530, Pratyush Anand wrote:
> On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> > diff --git a/kdump/kdump.c b/kdump/kdump.c
> > index 1f5b984..34d2149 100644
> > --- a/kdump/kdump.c
> > +++ b/kdump/kdump.c
> > @@ -284,7 +284,8 @@ int main(int argc, char **argv)
> >         }
> >
> >         /* Get the program header */
> > -       phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum), ehdr->e_phoff);
> > +       phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum),
> > +                       start_addr + ehdr->e_phoff);
> 
> This is fine. But at the same time should n't we also fix the offset
> for mmap of memory segments?  For memory segments, offset is
> phdr[i].p_offset, and I do not see generate_new_headers() taking care
> of start_addr.

Unfortunately not.  The reason is, p_offset is not an offset, but an
absolute address - see kexec/crashdump-elf.c, which is the bit of
code which creates the table and writes it into kernel memory when
loading the panic kernel:

                phdr->p_offset  = phdr->p_paddr = notes_addr;

                phdr->p_offset  = phdr->p_paddr = vmcoreinfo_addr;

                phdr->p_offset  = phdr->p_paddr = elf_info->kern_paddr_start;

                mstart = range->start;
                phdr->p_offset  = mstart;
                phdr->p_paddr = mstart;

etc.  So, p_offset is also the physical address, not the file offset.
Of course, that could be a bug in crashdump-elf.c.  To change that,
we would also need to fix crashdump-elf.c in lock-step as well.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
