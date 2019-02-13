Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtq7L-0006UD-7c
 for kexec@lists.infradead.org; Wed, 13 Feb 2019 08:42:08 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 4132D25B76D
 for <kexec@lists.infradead.org>; Wed, 13 Feb 2019 19:42:06 +1100 (AEDT)
Date: Wed, 13 Feb 2019 09:42:04 +0100
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.19 preparation
Message-ID: <20190213084204.lhd3sjhyia6hvshh@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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

Hi all,

I am planning to release kexec-tools v2.0.19 in the next two weeks
to roughly coincide with the release of the v5.0 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.18 within one week so that I can make an rc release.

For reference the patches queued up since v2.0.18 are as follows:

f1f2f9edf8d4 arm64: wipe old initrd addresses when patching the DTB
c493af72ac79 purgatory: Use standalond CFLAGS
a98b4da4fd4f x86: Handle 64bit framebuffer memory address properly
002b608f3669 multiboot-x86: pass framebuffer information when requested
2880a35f38cd multiboot-x86: pass ACPI reserved memory information in memory map
8776bf88e50d multiboot-x86: support for non-elf kernels
b23d0f8cf049 arm64: add kexec_file_load support
64c49f27d880 arm64: Add support to read PHYS_OFFSET from 'kcore' - pt_note or pt_load (if available)
f4ce0706d957 util_lib: Add functionality to read elf notes
f56cbcf4c276 kexec/dt-ops.c: Fix '/chosen' v/s 'chosen' node being passed to fdt helper functions
5570b4244466 kexec/dt-ops.c: Fix adding '/chosen' node for cases where it is not available in dtb passed via --dtb option
9dcf363f509a kexec/kexec-arm64.c: Add error handling check against return value of 'set_bootargs()'
583dbd57f997 kexec/dt-ops.c: Fix check against 'fdt_add_subnode' return value
e5dfb3540219 kexec-tools 2.0.18.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
