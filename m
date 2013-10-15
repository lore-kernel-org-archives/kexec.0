Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from juliette.telenet-ops.be ([195.130.137.74])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VW8mD-0008Ci-RC
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 17:51:26 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/3] kexec support for Linux/m68k (tools part)
Date: Tue, 15 Oct 2013 19:50:57 +0200
Message-Id: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org

kexec support for Linux/m68k (tools part)

This is a set of patches to add kexec support for m68k to kexec-tools.

  - Kexec only, no kdump support yet (do you have enough RAM to keep a
    crashdump kernel in memory at all times? ;-)

Patches:
  - [PATCH 1/3] kexec: Let slurp_file_len() return the number of bytes
      - v2: no changes
  - [PATCH 2/3] kexec: Extract slurp_fd()
      - v2: new patch
  - [PATCH 3/3] kexec: Add m68k support
      - v2:
	  - Fix handling of virtual and physical addresses, for machines where
	    memory doesn't start at zero,
	  - Print a warning if the kernel size exceeds 4 MiB, as current kernels
	    cannot handle that,
	  - Check struct bootversion at the start of the kernel, and print a
	    warning if it cannot be found or doesn't match,
	  - Replace literal 4096 by PAGE_SIZE,
	  - Handle removal of page zero at the ELF program segment level, as
	    m68kboot does,
	  - Remove -PAGE_SIZE for the ramdisk location now the bug in
            locate_hole() is fixed,
	  - Use endian-correct types for bootinfo,
	  - Remove unused -? option handling, cfr. commit
	    bf9d0f055c791a26b2237b5a12b48ae1b7e0d550 ("kexec: Remove unused -?
	    option handling"),
	  - Use <asm/bootinfo.h> instead of our own definitions.

Notes:
  - Based on git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

  - Tagged bootinfo is read from /proc/bootinfo by default, but this can be
    overridden using --bootinfo. No bootinfo editor is provided.
    The kexec command will replace/delete command line and ramdisk tags in the
    bootinfo.

Have fun!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
