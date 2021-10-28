Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg40p-007kBS-1K
 for kexec@lists.infradead.org; Thu, 28 Oct 2021 11:56:04 +0000
Received: from momiji.horms.nl (82-95-191-104.ip.xs4all.nl [82.95.191.104])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 1213525B260
 for <kexec@lists.infradead.org>; Thu, 28 Oct 2021 22:55:57 +1100 (AEDT)
Date: Thu, 28 Oct 2021 13:55:53 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.23-rc1
Message-ID: <20211028115553.GA16371@vergenet.net>
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

I am happy to announce the release of kexec-tools 2.0.23-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.23
in a weeks time. Testing of 2.0.23-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.23 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.23 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.23-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.22 are:

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
