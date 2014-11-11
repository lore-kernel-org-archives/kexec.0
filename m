Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoAGR-0001AM-PP
 for kexec@lists.infradead.org; Tue, 11 Nov 2014 12:09:41 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 34089ABE7
 for <kexec@lists.infradead.org>; Tue, 11 Nov 2014 12:09:14 +0000 (UTC)
Date: Tue, 11 Nov 2014 13:09:13 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: uniquely identifying KDUMP files that originate from QEMU
Message-ID: <20141111130913.11eec0a3@hananiah.suse.cz>
In-Reply-To: <5461F18C.2080400@redhat.com>
References: <5461F18C.2080400@redhat.com>
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
To: kexec@lists.infradead.org

On Tue, 11 Nov 2014 12:22:52 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> (Note: I'm not subscribed to either qemu-devel or the kexec list; please
> keep me CC'd.)
> 
> QEMU is able to dump the guest's memory in KDUMP format (kdump-zlib,
> kdump-lzo, kdump-snappy) with the "dump-guest-memory" QMP command.
> 
> The resultant vmcore is usually analyzed with the "crash" utility.
> 
> The original tool producing such files is kdump. Unlike the procedure
> performed by QEMU, kdump runs from *within* the guest (under a kexec'd
> kdump kernel), and has more information about the original guest kernel
> state (which is being dumped) than QEMU. To QEMU, the guest kernel state
> is opaque.
> 
> For this reason, the kdump preparation logic in QEMU hardcodes a number
> of fields in the kdump header. The direct issue is the "phys_base"
> field. Refer to dump.c, functions create_header32(), create_header64(),
> and "include/sysemu/dump.h", macro PHYS_BASE (with the replacement text
> "0").
> 
> http://git.qemu.org/?p=qemu.git;a=blob;f=dump.c;h=9c7dad8f865af3b778589dd0847e450ba9a75b9d;hb=HEAD
> 
> http://git.qemu.org/?p=qemu.git;a=blob;f=include/sysemu/dump.h;h=7e4ec5c7d96fb39c943d970d1683aa2dc171c933;hb=HEAD
> 
> This works in most cases, because the guest Linux kernel indeed tends to
> be loaded at guest-phys address 0. However, when the guest Linux kernel
> is booted on top of OVMF (which has a somewhat unusual UEFI memory map),
> then the guest Linux kernel is loaded at 16MB, thereby getting out of
> sync with the phys_base=0 setting visible in the KDUMP header.
> 
> This trips up the "crash" utility.
> 
> Dave worked around the issue in "crash" for ELF format dumps -- "crash"
> can identify QEMU as the originator of the vmcore by finding the QEMU
> notes in the ELF vmcore. If those are present, then "crash" employs a
> heuristic, probing for a phys_base up to 32MB, in 1MB steps.
> 
> Alas, the QEMU notes are not present in the KDUMP-format vmcores that
> QEMU produces (they cannot be),

Why? Since KDUMP format version 4, the complete ELF notes can be stored
in the file (see offset_note, size_note fields in the sub-header).

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
