Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lauLP-00FkmU-Eo
 for kexec@lists.infradead.org; Mon, 26 Apr 2021 06:03:45 +0000
Received: from madeliefje.horms.nl (tulip.horms.nl [83.161.246.101])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 44DCB25B817
 for <kexec@lists.infradead.org>; Mon, 26 Apr 2021 16:03:34 +1000 (AEST)
Date: Mon, 26 Apr 2021 08:03:31 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.22-rc1
Message-ID: <20210426060331.GA28942@vergenet.net>
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

I am happy to announce the release of kexec-tools 2.0.22-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.22
in a weeks time. Testing of 2.0.22-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.22 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.23 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.22-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.21 are:

b4d0710 kexec-tools 2.0.22-rc1
9817ec8 arm: do not copy magic 4 bytes of appended DTB in zImage
bb6f6f1 kexec: Remove the error prone kernel_version function
0b69943 Shrink segments to fit alignment instead of throwing them away
774a16b Fix where the real mode interrupt vector ends
28b0491 github: initial workflow
e0a17a2 build: add distcheck target
0eb0154 build: simplify uninstall target
93c1e9d build: use DESTDIR in uninstall target
fa1d7d5 build: uninstall kexec_test
66d2b1a build: add dist make target
41b77ed build: create tarball without self-referential hard links
1bc7bc7 crashdump/x86: increase CRASH_MAX_MEMORY_RANGES to 32k
77ff3d6 crashdump/x86: iterate only over actual crash memory ranges
7175859 crashdump/x86: dump any kind of "System RAM"
85721bd kexec-xen: Use correct image type for Live Update
4b97ff9 kexec: Make --status work with normal kexec images
2c30aa5 kexec: Fix description of --status exit code
82f7de2 printk: Use %zu to format size_t
07b272a printk: Use ULL suffix for 64-bit constants
8519b01 kexec: Use %llu/%llx and casts to format uint64_t
84a6ef0 mips: Fix the increased mem parameter size
d73822b i386: fix build on pre 4.4 kernels
6093532 mips: Fix typo in comment
15ee19f mips: Add '--reuse-cmdline' optional parameter support
b4feb36 kexec-tools 2.0.21.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
