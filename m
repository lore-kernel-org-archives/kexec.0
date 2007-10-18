Return-path: <kexec-bounces@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IiTMp-0001u2-BZ
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 12:16:46 +0100
Message-Id: <20071018111535.356215664@strauss.suse.de>
Date: Thu, 18 Oct 2007 13:15:35 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 0/3] Protect crashkernel against BSS overlap
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: akpm@linux-foundation.org, vgoyal@in.ibm.com, ak@suse.de

I observed the problem that even when you choose the default 16M as
crashkernel base address and the kernel is very big, the reserved area may
overlap with the kernel BSS. Currently, this is not checked at runtime, so the
kernel just crashes when you load the panic kernel in the sys_kexec call.

This three patches check this at runtime. The patches are against current git,
but with the patches

    extended-crashkernel-command-line.patch
    extended-crashkernel-command-line-update.patch
    extended-crashkernel-command-line-comment-fix.patch
    extended-crashkernel-command-line-improve-error-handling-in-parse_crashkernel_mem.patch
    use-extended-crashkernel-command-line-on-i386.patch
    use-extended-crashkernel-command-line-on-i386-update.patch
    use-extended-crashkernel-command-line-on-x86_64.patch
    use-extended-crashkernel-command-line-on-x86_64-update.patch
    use-extended-crashkernel-command-line-on-ia64.patch
    use-extended-crashkernel-command-line-on-ia64-fix.patch
    use-extended-crashkernel-command-line-on-ia64-update.patch
    use-extended-crashkernel-command-line-on-ppc64.patch
    use-extended-crashkernel-command-line-on-ppc64-update.patch
    use-extended-crashkernel-command-line-on-sh.patch
    use-extended-crashkernel-command-line-on-sh-update.patch

from -mm tree applied since they are marked to be merged in 2.6.24.

I know that the implementation of both patches is only x86 (i386 and x86-64),
but if you agree that it's the way to go, I'll modify the patch for all
architectures.

Changes compared to last submit:

   1) use BOOTMEM_DEFAULT instead of 0 to improve code readability
      (suggested by Dave Hansen <haveblue@us.ibm.com>)

   2) unreserve memory that got reserved until we detect a duplicate
      reservation (discovered by Vivek Goyal <vgoyal@in.ibm.com>)

   3) fix IA64 (didn't compile)


Signed-off-by: Bernhard Walle <bwalle@suse.de>

-- 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
