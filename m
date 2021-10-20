Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md8fe-0048bA-6F
 for kexec@lists.infradead.org; Wed, 20 Oct 2021 10:18:07 +0000
Received: from madeliefje.horms.nl (tulip.horms.nl [83.161.246.101])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 641AB25AED3
 for <kexec@lists.infradead.org>; Wed, 20 Oct 2021 21:18:04 +1100 (AEDT)
Date: Wed, 20 Oct 2021 12:18:02 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.23 preparation
Message-ID: <20211020101802.GC19898@vergenet.net>
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

I am planning to release kexec-tools v2.0.23 in the next two weeks
to roughly coincide with the release of the v5.15 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.23 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.22 are as follows.

Thanks to everyone who has contributed to kexec-tools!

5f8d632 arm: kdump: Add DT properties to crash dump kernel's DTB
bb1c95c kexec-tools: multiboot2: Correct BASIC_MEMINFO memory units
a4d49e8 Add some necessary free() calls
bcee4f2 Add some necessary fclose() calls
84ef6cb ppc64: Fix memory leak problem in zImage_ppc64_load()
35dec3d i386: Remove unused local variable in get_kernel_page_offset()
dbc151e multiboot2: Accept x86-64 images
e388195 multiboot2: Avoid first 0x500 bytes
1d02758 multiboot2: Use rel_min and rel_max for buffer destinations
4f8d667 multiboot2: Correct MBI size calculation
bfaebfb x86: Consolidate elf_x86_probe routines
091f9e9 Refer FDT tokens with symbolic names
61b8c79 arm64/crashdump-arm64: deduce the paddr of _text
5e7ce27 kexec-tools: Remove duplicate definition of ramdisk
a2ba3cd kexec-tools 2.0.21.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
