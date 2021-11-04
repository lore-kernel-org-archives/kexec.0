Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mieLQ-009Ck7-5T
 for kexec@lists.infradead.org; Thu, 04 Nov 2021 15:08:01 +0000
Received: from madeliefje.horms.nl (ip-80-113-23-202.ip.prioritytelecom.net
 [80.113.23.202])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 8142525AE8A
 for <kexec@lists.infradead.org>; Fri,  5 Nov 2021 02:07:48 +1100 (AEDT)
Date: Thu, 4 Nov 2021 16:07:46 +0100
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.23
Message-ID: <20211104150746.GA2452@vergenet.net>
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

I am happy to announce the release of kexec-tools 2.0.22.

This is a feature release coinciding with the release of v5.12
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.23.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.22:

91ff1e7 kexec-tools 2.0.23
41725a0 kexec-tools 2.0.23-rc1
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
