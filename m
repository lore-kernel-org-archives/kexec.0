Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoSvJ-0002h6-EM
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 08:05:06 +0000
Date: Wed, 12 Nov 2014 09:04:41 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: uniquely identifying KDUMP files that originate from QEMU
Message-ID: <20141112090441.3ee42632@hananiah.suse.cz>
In-Reply-To: <20141112.120838.303682123986142686.d.hatayama@jp.fujitsu.com>
References: <5461F18C.2080400@redhat.com>
 <20141111130913.11eec0a3@hananiah.suse.cz>
 <20141112.120838.303682123986142686.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, lersek@redhat.com

On Wed, 12 Nov 2014 12:08:38 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> From: Petr Tesarik <ptesarik@suse.cz>
> Subject: Re: uniquely identifying KDUMP files that originate from QEMU
> Date: Tue, 11 Nov 2014 13:09:13 +0100
> 
> > On Tue, 11 Nov 2014 12:22:52 +0100
> > Laszlo Ersek <lersek@redhat.com> wrote:
>[...]
> >> Dave worked around the issue in "crash" for ELF format dumps -- "crash"
> >> can identify QEMU as the originator of the vmcore by finding the QEMU
> >> notes in the ELF vmcore. If those are present, then "crash" employs a
> >> heuristic, probing for a phys_base up to 32MB, in 1MB steps.
> >> 
> >> Alas, the QEMU notes are not present in the KDUMP-format vmcores that
> >> QEMU produces (they cannot be),
> > 
> > Why? Since KDUMP format version 4, the complete ELF notes can be stored
> > in the file (see offset_note, size_note fields in the sub-header).
> > 
> 
> Yes, the QEMU notes is present in kdump-compressed format. But
> phys_base cannot be calculated only from qemu-side. We cannot do more

Yes, this part is obvious. I was referring to this sentence: "Alas,
the QEMU notes are not present in the KDUMP-format vmcores." My
understanding was that crash cannot detect a KDUMP file created by
QEMU, and so it does not apply the workaround. Sorry for confusion if
this was not your problem.

> than the efforts crash utility does for workaround. So, the phys_base
> value in kdump-sub header is now designed to have 0 now.
> 
> Anyway, phys_base is kernel information. To make it available for qemu
> side, there's need to prepare a mechanism for qemu to have any access
> to it.

Yes. I wonder if you can have access without some sort of co-operation
from the guest kernel itself. I guess not.

> One ad-hoc but simple way is to put phys_base value as part of
> VMCOREINFO note information on kernel.

YES! In fact, this has been on my TODO list for a few weeks now.

> Although there has already been a similar one in VMCOREINFO, like
> 
> arch/x86/kernel/
> ==
> void arch_crash_save_vmcoreinfo(void)
> {
>         VMCOREINFO_SYMBOL(phys_base); <---- This
>         VMCOREINFO_SYMBOL(init_level4_pgt);
> 
> ...
> ==
> 
> this is meangless, because this value is a virtual address assigned to
> phys_base symbol.

Yes, again. I have already done some research and *nobody* needs the
actual symbol value. For example, makedumpfile only checks if the
symbol exists and sets phys_base to 0 unconditionally if not. That's so
wrong...

> To refer to the value of phys_base itself, we need
> the phys_base value we are about to get now.
> 
> So, instead, if we change this to save the value, not value of symbol
> phys_base, we can get phys_base from the VMCOREINFO.

Yes, please do that. It should be sufficient to replace this line in
kernel's arch/x86/kernel/machine_kexec_64.c:

	VMCOREINFO_SYMBOL(phys_base);

with:

	VMCOREINFO_NUMBER(phys_base);

> The VMCOREINFO consists simply of string. So it's easy to search
> vmcore for it e.g. using strings and grep like this:
> 
> $ strings vmcore-3.10.0-121.el7.x86_64 | grep -E ".*VMCOREINFO.*" -A 100

If vmcore-3.10.0-121.el7.x86_64 is a standard kernel ELF dump file, you
can actually run elfutil's "readelf -n" on it and get the VMCOREINFO
directly (or use my libkdumpfile library to read the kernel core file,
see https://github.com/ptesarik/libkdumpfile).

If it is simply a QEMU dump file (without the VMCOREINFO ELF note),
then running strings on it seems like the only sensible workaround.
I tried to solve a similar problem in kdumpid
(http://sourceforge.net/projects/kdumpid/), and best I could do is
very similar to the workaround in the crash utility (scanning physical
memory for something that looks like kernel text).

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
