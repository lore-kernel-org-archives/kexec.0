Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yr4i1-0000Zm-QN
 for kexec@lists.infradead.org; Sat, 09 May 2015 13:22:26 +0000
Date: Sat, 9 May 2015 15:21:59 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: More on kexec/purgatory handover
Message-ID: <20150509152159.6b391c2b@hananiah.suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <JBeulich@suse.com>, xen-devel@lists.xen.org

Hi all,

note that I'm not subscribed to the xen-devel mailing list, but Jan
quoted from this mail of Andrew's in SUSE Bugzilla:

> This is all from a while ago.  It is quite possible that we didn't
> actually tested the compatibility case with a 64bit dom0 kernel,
> although I certainly did test earlier versions of the series with a
> 32bit dom0 kernel.  The work was done long before XenServer moved to a
> 64bit dom0, and was done by deleting everything and starting from scratch.
> 
> IIRC, the low 640k mappings is a purgatory bug rather than Linux, and
> has been fixed upstream in kexec-tools since.  (I recall that it used to
> take a backup copy of the IVT for some reason)

This is not entirely correct.

Originally, kexec (in Linux kernel) was supposed to provide an
environment which is equivalent to the boot loader, i.e. kexec is just
another bootloader like LILO or GRUB. The first implementation indeed
switched back to 16-bit real mode before passing control to the
secondary kernel's boot code...

It was at that time that the need arose to save the low 640K of RAM
somewhere else, because the 16-bit bootloader had to use parts of this
memory range, not the least because it also made BIOS calls, and BIOS
used this range for its data.

This solution was suboptimal for numerous reasons, e.g. very limited
location of the purgatory code in physical RAM, or incompatibility with
UEFI booting. As an improvement, a 32-bit boot protocol was introduced.
At entry, the CPU must be in 32-bit protected mode with paging
disabled. This explains why you never noticed any issues related to
pagetables with 32-bit kernels. Since paging is disabled, there are
none. ;-)

The 32-bit protocol limits the location of the secondary kernel to low
4G in physical RAM (for obvious reason). This is now solved by a 64-bit
boot protocol. Since paging must be always enabled in Long Mode, it
must be set up somehow. The Linux documentation says: "The range with
setup_header.init_size from start address of loaded kernel and zero
page and command line buffer get ident mapping".

The problematic part here is that Linux kexec code is split between
kernel and purgatory. Unfortunately, the handover between the old
kernel and the purgatory is not so well defined, so the actual kexec
code is probably the best documentation available.

There are currently two versions of the Linux purgatory: in kexec-tools
and in the kernel. None of them sets CR3. On the other hand, the Linux
kernel does set CR3 (see arch/x86/kernel/relocate_kernel_64.S). This
makes me believe that the 64-bit kexec entry point expects that paging
is set up by the old kernel. If Xen plays the role of the old kernel,
it must also set up paging. The question is how.

Let's start a discussion on the kexec mailing list (in Cc) to clarify
what should be done by the old kernel and what should be done by the
purgatory code.

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
