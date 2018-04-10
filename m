Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5pYN-0003aE-3m
 for kexec@lists.infradead.org; Tue, 10 Apr 2018 09:27:06 +0000
Received: from penelope.horms.nl (unknown [217.111.208.18])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 7964125B7A3
 for <kexec@lists.infradead.org>; Tue, 10 Apr 2018 19:26:44 +1000 (AEST)
Date: Tue, 10 Apr 2018 11:26:42 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.17-rc1
Message-ID: <20180410092642.gbawusvilhgctz4l@verge.net.au>
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

I am happy to announce the release of kexec-tools 2.0.17-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.17
in a weeks time. Testing of 2.0.17-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.17 at this time.
And I would like to only accept bug fixes at this time and take take
features patches once 2.0.17 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.17-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.16 are:

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
