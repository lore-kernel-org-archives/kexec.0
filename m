Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cGLlF-0000XE-HO
 for kexec@lists.infradead.org; Mon, 12 Dec 2016 08:15:02 +0000
Received: from penelope.kanocho.kobe.vergenet.net (unknown [217.111.208.18])
 by kirsty.vergenet.net (Postfix) with ESMTPSA id A5B0B25BE72
 for <kexec@lists.infradead.org>; Mon, 12 Dec 2016 19:14:39 +1100 (AEDT)
Date: Mon, 12 Dec 2016 09:14:36 +0100
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.14-rc1
Message-ID: <20161212081436.GD10193@verge.net.au>
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

I am happy to announce the release of kexec-tools 2.0.14-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.14
in a weeks time. Testing of 2.0.14-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.14 at this time.
And I would like to only accept bug fixes at this time and take take
features patches once 2.0.14 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.14-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.13 are:

1e344e03a844 kexec-tools 2.0.14-rc1
c901bae8683c arm: do not build iomem.o target with no soruce
a73747863c60 ia64: ehdr is not UNUSED in machine_apply_elf_rel
a2451670230c arm64: Fix initrd requierements
6d972b95c6d9 mips: add option to load initrd from a specified file
83a53ce9248f mips: add dtb loading support
18bf48b15c28 mips: crashdump: add little-endian support
fecd481fbe61 mips: move arch option parsing from elf loader to common arch code
b5f715e98eac mips: use arch_options for both 32 and 64 bit variants
641a18e344c6 mips: remove incorrect arch_usage string
dbb99d938810 kexec-tools/x86: get_kernel_vaddr_and_size off-by-one fix
0a7fba8b1453 purgatory: Change default sha256 optimization to -O2
ec271d6c2988 arm64: Add support of R_AARCH64_PREL32 relocation in purgatory
c743758d77b8 arm64: Add support for additional relocations in the kexec purgatory code
e345e27417db arm64: Add missing kexec dist files
402cf1427293 arm64: Cleanup kexec Makefile
16fd64af363b kexec/fs2dt: Check for NULL pointer in dt_copy_old_root_param()
6e8804f9ca67 multiboot: Use the "reserved" type for non-ram zones
53634c3e9a0c multiboot: Fix length computation for the memory zones
97b6f5f78d95 kexec elf: Sanity check on the note header before accessing it
1574ff1aae4f arm: include phys_to_virt.h and iomem.h in distribution
29086f45a45f kexec: socket not released when error situation occur.
9fd57cad8a0f kexec: fix mem_regions_sort()
9f62cbddddfc kexec/arch/i386: Add support for KASLR memory randomization
abdfe97736f8 arm64: Add support for binary image files
522df5f7217f arm64: Add arm64 kexec support
217bcc00c930 kexec: Add common device tree routines
f7a0ff52e04d kexec-tools 2.0.13.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
