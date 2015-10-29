Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrwwT-0003DM-KE
 for kexec@lists.infradead.org; Thu, 29 Oct 2015 23:49:14 +0000
Received: from penelope.kanocho.kobe.vergenet.net
 (121-80-213-238f1.hyg1.eonet.ne.jp [121.80.213.238])
 by kirsty.vergenet.net (Postfix) with ESMTPSA id 6F8C425B74E
 for <kexec@lists.infradead.org>; Fri, 30 Oct 2015 10:48:51 +1100 (AEDT)
Date: Fri, 30 Oct 2015 08:48:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.11-rc1
Message-ID: <20151029234849.GA28689@verge.net.au>
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

I am happy to announce the release of kexec-tools 2.0.11-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.11
shortly after the release of the v4.3 kernel, which I expect to occur in
the next week or so.  As such testing of 2.0.11-rc1 would be greatly
appreciated.

I do not have any outstanding changes for 2.0.11 at this time.
And I would like to only accept bug fixes at this time and take take
features patches once 2.0.11 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.11-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.10 are:

3e123f9419a5 kexec-tools 2.0.11-rc1
83a65e2e13af ppc64: add arch option --dt-no-old-root
1d13b61a6ae4 arm: add arch option --dt-no-old-root
a1ae68d19b6e fs2dt.c: move copy old root param as a new function
86866f6f7532 Revert "kexec: use mmap instead of read for slurp_file()"
faef3d02bb0d ppc64: Fix warnings
626b441109b6 configure: Set SUBARCH=BE for powerpc
0974c43a18ca kexec-tools: fix build error with glibc 2.19 and earlier version
4fbf781eb038 Load crash kernel high on x86
6fd80e245e38 fix kexec load hang in case crash notes addr read failure
7ab842d8a004 kexec: use mmap instead of read for slurp_file()
a304e2d82a8c ppc64: purgatory: Reset primary cpu endian to big-endian
97a07e2775ef Drop release date from kexec-tools version output
cb9a818ff2ac Add persistent memory support
c9c21cc107dc kexec: use _DEFAULT_SOURCE instead to remove compiling warning
973426e85377 kexec-tools 2.0.10.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
