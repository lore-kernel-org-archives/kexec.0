Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHRwU-0002Fu-2O
 for kexec@lists.infradead.org; Tue, 30 Oct 2018 11:12:15 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 86AFF25B7C3
 for <kexec@lists.infradead.org>; Tue, 30 Oct 2018 22:11:26 +1100 (AEDT)
Date: Tue, 30 Oct 2018 12:11:23 +0100
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.18
Message-ID: <20181030111123.7okzbw6baai3r3em@verge.net.au>
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

I am happy to announce the release of kexec-tools 2.0.18.

This is a feature release coinciding with the release of v4.19 of the Linux
Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.18.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.

Commits since v2.0.17

5750980cdbbc kexec-tools 2.0.18
04c43b4e421f arm64: If 'getrandom' syscall fails, don't error out - just warn and proceed.
8db8b6613a00 x86: fix BAD_FREE in get_efi_runtime_map()
94159bc3c264 kexec-tools 2.0.18-rc1
1ac3e4a57000 kdump: fix an error that can not parse the e820 reserved region
b9de21ef51a7 kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error
ca4823aa2fc2 arm64: error out if kernel command line is too long
7198e899ddab arm64: increase command line size to 2048
c3f043241a86 arm64: Add support to supply 'kaslr-seed' to secondary kernel
7acd257ae67b Remove obsolete kdump tool
674b9b45876c Makefile.in: Add uninstall rule
e277fa9ec702 vmcore-dmesg: fix infinite loop if log buffer wraps around
d4a948c26827 kexec/s390: Add support for kexec_file_load
0481e9ed61ef kexec: Add --no-checks option
72c146c20588 purgatory/ppc64: Fix uninitialized warning
3f276f71f14d kexec-elf-rel-ppc64: Fix cast from pointer warning
7be89276db19 crashdump-ppc64: Fix integer truncation warning
798317c134b2 kexec: Fix printf warning
b43960c20dd2 kexec-tools 2.0.17.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
