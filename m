Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1hl8N9-0002E7-Fu
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 08:54:45 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id D18D625B7D5
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2019 18:54:41 +1000 (AEST)
Date: Wed, 10 Jul 2019 10:54:39 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.20-rc1
Message-ID: <20190710085439.dgrkfc3zrdszmei5@verge.net.au>
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

I am happy to announce the release of kexec-tools 2.0.20-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.20
in a weeks time. Testing of 2.0.20-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.20 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.20 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.20-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.19 are:

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
