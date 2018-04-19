Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f953E-00066d-RJ
 for kexec@lists.infradead.org; Thu, 19 Apr 2018 08:36:23 +0000
Received: from penelope.horms.nl (unknown [217.111.208.18])
 by kirsty.vergenet.net (Postfix) with ESMTPA id A25E425B75B
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2018 18:36:09 +1000 (AEST)
Date: Thu, 19 Apr 2018 10:36:07 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.17
Message-ID: <20180419083607.tkeevskl3ksg44hm@verge.net.au>
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

I am happy to announce the release of kexec-tools 2.0.17.

This is a feature release coinciding with the release of v4.16 of the Linux
Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.17.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.

Non-merge commits since v2.0.16

969ca80be8cf kexec-tools 2.0.17
7ce0d4a67c1c arm64: Set -fno-PIC along with -mcmodel=large
090e8eceed79 kexec-tools 2.0.17-rc1
a0c27338252d Fix a segmentation fault when trying to run "kexec -p"
5c08af7a068d arm64: fix an issue with kaslr-enabled vmlinux
b2b05352ae5e kexec: Document -s, -c and -a options in the man page
20fea93e6caf kexec: Add option to fall back to KEXEC_LOAD when KEXEC_FILE_LOAD is not supported
b58d076a6ed3 kexec: Add option to revert -s
cb434cbe6f40 kexec: Do not special-case the -s option
6259b12f5cc8 kexec: Fix option checks to take KEXEC_FILE_LOAD into account
61a03fe9795c kexec: Return -ENOSYS when kexec does not know how to call KEXEC_FILE_LOAD
3720b743ae3c kexec/ppc64: leverage kexec_file_load support
f57f0bf8975d ARM: Include stack and malloc space in zImage size
b4bd5dd7f207 ARM: add further debug
e414889e731f ARM: read kernel size from zImage
b10924a7da3c kexec/ppc64: add support to parse ibm, dynamic-memory-v2 property
c740fdb20482 kexec: add a helper function to add ranges
060eee589dd1 x86: use old screen_info if needed
282ff2a5e613 kexec-tools: Make xc_dlhandle static
58c225a6d762 kexec-tools: Call dlclose() from within __xc_interface_close()
894bea9335f5 kexec-tools: Perform run-time linking of libxenctrl.so
401e096166ce kexec-tools 2.0.16.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
