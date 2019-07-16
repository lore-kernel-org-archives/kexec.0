Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1hnM8r-0007DO-9K
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 12:01:10 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id EC4EB25AD78
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2019 22:01:07 +1000 (AEST)
Date: Tue, 16 Jul 2019 14:01:05 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.20-rc2
Message-ID: <20190716120105.qt2jtyd7s55xf7kn@verge.net.au>
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

I am happy to announce the release of kexec-tools 2.0.20-rc2.

This is an incremental feature pre-release.

I had planed to release v2.0.20 at this time but have, instead,
decided to add Bhupesh Sharma's support for zlib compressed kernel
images for ARM64 and release 2.0.20-rc2.

So long as no serious problems arise I intend to release kexec-tools 2.0.20
in a weeks time. Testing of 2.0.20-rc2 would be greatly appreciated.

I do not have any outstanding changes for 2.0.20 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.20 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.20-rc2.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.19 are:

419716b151e8 kexec-tools 2.0.20-rc2
f4c1caaa97a2 kexec/arm64: Add support for handling zlib compressed (Image.gz) image
0e709571bfe7 kexec/kexec-zlib.h: Add 'is_zlib_file()' helper function
6ef59c03bf2c kexec-uImage-arm64.c: Fix return value of uImage_arm64_probe()
019d8258f15c kexec/kexec.c: Add the missing close() for fd used for kexec_file_load()
ffdc7feceea3 kexec-tools 2.0.20-rc1
d9cd81a39b59 x86: Include kexec-mb2-x86.c and multiboot2.h in distribution
7018e436cd34 x86: re-order includes to avoid duplicate struct e820entry
22a2ed55132e x86: Support multiboot2 images
d6bc88c06962 elf: Support ELF loading with relocation
40805e393b2f crashdump/x86: Use new introduce helper for getting RSDP
b071fc084bda x86: Always try to fill acpi_rsdp_addr in boot params
cedeee0a3007 x86: Introduce helpers for getting RSDP address
402351390f31 x86: Update boot parameters defination
c072bd13abbe x86: Find mounts by FS type, not name
23aaa44614a0 x86: Check /proc/mounts before mtab for mounts
eff53089523c xen: Avoid overlapping segments in low memory
fb5a8792e6e4 x86: Introduce a new option --reuse-video-type
3757ef630b72 kexec-tools 2.0.19.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
