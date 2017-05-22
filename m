Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dClpk-0002lm-02
 for kexec@lists.infradead.org; Mon, 22 May 2017 11:49:13 +0000
Received: from penelope.horms.nl (unknown [217.111.208.18])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E79C825B816
 for <kexec@lists.infradead.org>; Mon, 22 May 2017 21:48:46 +1000 (AEST)
Date: Mon, 22 May 2017 13:48:44 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.15 preparation
Message-ID: <20170522114844.GH16822@verge.net.au>
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

I am planning to release kexec-tools v2.0.15 in the next two weeks.

The normal cadence would have seen it released around the time of the v4.11
kernel. I apologise that I am kicking off this process several weeks behind
that schedule.

I would like to ask interested parties to send any patches they would like
included in v2.0.15 within one week so that I can make an rc release.

For reference the patches queued up since v2.0.14 are as follows:

fab91841c717 Handle additional e820 memmap type strings
c504ff5d85aa arm64: kdump: Add support for binary image files
5f955585c7c9 arm64: kdump: add DT properties to crash dump kernel's dtb
defad947feff arm64: kdump: set up other segments
1591926df5a6 arm64: kdump: set up kernel image segment
0bd5219da953 arm64: kdump: add elf core header segment
c0672c93edcb arm64: kdump: identify memory regions
a17234fe94bc arm64: change return values on error to negative
ef26cc33b8d6 arm64: identify PHYS_OFFSET correctly
325804055e99 kexec: generalize and rename get_kernel_stext_sym()
c95df0e099b1 kexec: extend the semantics of kexec_iomem_for_each_line
59d3e5b5ad6f Fix broken Xen support in configure.ac
4a6d67d9e938 x86: Support large number of memory ranges
0516f46adbf3 crashdump: Remove stray get_crashkernel_region() declaration
82a49747e5ad ppc: Fix format warning with die()
1550f81bf188 x86/x86_64: Fix format warning with die()
47cc70157c66 Don't use %L width specifier with integer values
2f6f6d6fef78 vmcore-dmesg: Define _GNU_SOURCE
896fb2aa30c6 arm64: add uImage support
a0c575793b86 uImage: use 'char *' instead of 'unsigned char *' for uImage_probe()
f25146afc5a9 uImage: use 'char *' instead of 'unsigned char *' for uImage_load()
b3d533c1f499 uImage: Add new IH_ARCH_xxx definitions
67234243bb91 uImage: Fix uImage_load() for little-endian machines
0cc1891c4dc8 uImage: fix realloc() pointer confusion
ed15ba1b9977 build_mem_phdrs(): check if p_paddr is invalid
263e45ccf27b Only print debug message when failed to serach for kernel symbol from /proc/kallsyms
7dac152d5b47 gitignore: add two generated files in purgatory
05ae4fb2e354 crashdump/sh: Add get_crash_kernel_load_range() function
796f0ffa134d crashdump/s390: Add get_crash_kernel_load_range() function
e4280e22c8c4 crashdump/ppc64: Add get_crash_kernel_load_range() function
7fc80cfcd913 crashdump/ppc: Add get_crash_kernel_load_range() function
d2caf4c4c43b crashdump/mips: Add get_crash_kernel_load_range() function
14d71e51e5c9 crashdump/m68k: Add get_crash_kernel_load_range() function
5c80bd9be295 crashdump/ia64: Add get_crash_kernel_load_range() function
b6af22826f60 crashdump/cris: Add get_crash_kernel_load_range() function
d43610084164 crashdump/arm64: Add get_crash_kernel_load_range() function
cfcf60c38182 crashdump/arm: Add get_crash_kernel_load_range() function
76b31203222a kexec: Add option to get crash kernel region size
e49623b0787d purgatory: Add purgatory.map and purgatory.ro.sym to clean recipe
ceedb33e6cd3 kexec: Remove redundant space from help message
2cf7cb9a6080 kexec: implemented XEN KEXEC STATUS to determine if an image is loaded
4eaa36cd01a9 alpha: add missing __NR_kexec_load definition
24aa2d93cac3 kexec: Increase the upper limit for RAM segments
f63d8530b9b6 ppc64: Reduce number of ELF LOAD segments
9da19c0a6f49 kexec-tools 2.0.14.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
