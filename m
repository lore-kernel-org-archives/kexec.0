Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZmuFP-00050s-Hc
 for kexec@lists.infradead.org; Fri, 16 Oct 2015 01:55:56 +0000
Received: from penelope.kanocho.kobe.vergenet.net
 (g1-27-253-251-5.bmobile.ne.jp [27.253.251.5])
 by kirsty.vergenet.net (Postfix) with ESMTPSA id 471D525B7BE
 for <kexec@lists.infradead.org>; Fri, 16 Oct 2015 12:55:33 +1100 (AEDT)
Date: Fri, 16 Oct 2015 10:55:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.10 preparation
Message-ID: <20151016015525.GH20667@verge.net.au>
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

I am planning to release kexec-tools v2.0.11 around the time that
the v4.3 kernel is released.

As I estimate that the latter occur within the few weeks I
would like to ask interested parties to send any patches they would like
included in v2.0.10 within the next week so that I can make an rc release.

For reference the patches queued up since v2.0.10 are as follows:

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
