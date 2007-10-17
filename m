Return-path: <kexec-bounces@lists.infradead.org>
Received: from dsl022.labridge.com ([206.117.136.22] helo=perches.com)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ii1A8-0001hm-3c
	for kexec@lists.infradead.org; Wed, 17 Oct 2007 06:09:47 +0100
Subject: Re: [PATCH] [275/2many] MAINTAINERS - KDUMP
From: Joe Perches <joe@perches.com>
In-Reply-To: <20071017034840.GA28414@verge.net.au>
References: <46bffa99.nQ27DQOgkKo2uOy+%joe@perches.com>
	<46bffa8e.NHuk7h7puR+3eDXo%joe@perches.com>
	<20071017021902.GB6709@verge.net.au>
	<1192589134.9998.93.camel@localhost>
	<20071017034840.GA28414@verge.net.au>
Date: Tue, 16 Oct 2007 21:56:19 -0700
Message-Id: <1192596979.9998.143.camel@localhost>
Mime-Version: 1.0
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
Errors-To: kexec-bounces@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, ebiederm@xmission.com, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Wed, 2007-10-17 at 12:48 +0900, Simon Horman wrote:
> Do you have a criteria for including files.

A file or file pattern specific to a maintained "subsystem".

Any time a subsystem file pattern matches a file,
maintainers would be cc'd.  The matching is non-exclusive.
Multiple subsystems can include the same file pattern.

For KDUMP, maybe a file pattern should be:

F:	arch/*/kernel/crash_dump.c
F:	include/linux/crash_dump.h

> Are they files that only apply to KEXEC/KDUMP,
> or files that have KEXEC/KDUMP code and other code?

I think it should be files specific to KDUMP and not
files shared with other subsystems but perhaps it's
maintainer taste.

If the files patterns are not specific to kdump,
the kdump maintainers will be cc'd on patches that
change files where kdump functions aren't modified.

The list of files that include crash_dump.h is pretty long.

        $ grep -P -l -r --include=*.[ch] crash_dump.h *
        arch/i386/kernel/crash_dump.c
        arch/i386/kernel/setup.c
        arch/ia64/hp/common/sba_iommu.c
        arch/ia64/kernel/crash.c
        arch/ia64/kernel/setup.c
        arch/powerpc/kernel/crash.c
        arch/powerpc/kernel/crash_dump.c
        arch/sh/kernel/crash_dump.c
        arch/x86_64/kernel/crash_dump.c
        arch/x86_64/kernel/setup.c
        drivers/char/mem.c
        fs/proc/proc_misc.c
        fs/proc/vmcore.c
        
The list of files that use CONFIG_CRASH_DUMP is also
pretty long and seemingly unrelated.

        $ grep -P -l -r --include=*.[ch] CONFIG_CRASH_DUMP *
        arch/i386/kernel/apic.c
        arch/i386/kernel/e820.c
        arch/ia64/hp/common/sba_iommu.c
        arch/ia64/kernel/efi.c
        arch/powerpc/kernel/iommu.c
        arch/powerpc/platforms/cell/ras.c
        arch/powerpc/platforms/pseries/iommu.c
        arch/x86_64/kernel/e820.c
        drivers/char/mem.c
        include/asm-powerpc/kdump.h
        include/linux/bootmem.h
        include/linux/crash_dump.h
        mm/bootmem.c




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
