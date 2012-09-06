Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9YD8-0003RN-Ah
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 09:17:19 +0000
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 6 Sep 2012 19:15:54 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8697teu23265528
 for <kexec@lists.infradead.org>; Thu, 6 Sep 2012 19:07:56 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q869Gtdp017697
 for <kexec@lists.infradead.org>; Thu, 6 Sep 2012 19:16:55 +1000
Subject: [PATCH] kexec: Fix the purgatory Makefile to build arch specific
 purgatory code.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 06 Sep 2012 14:43:55 +0530
Message-ID: <20120906091332.11848.70361.stgit@mars>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The latest commit 5e48916 has removed a line from purgatory/Makefile that was
responsible for building arch specific purgatory code. This causes kexec -p
(loading of panic kernel) to fail. This patch reverts the deleted line.

Verified this fix on x86_64 and ppc64.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 purgatory/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 711799b..ee1679c 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -27,6 +27,8 @@ include $(srcdir)/purgatory/arch/s390/Makefile
 include $(srcdir)/purgatory/arch/sh/Makefile
 include $(srcdir)/purgatory/arch/x86_64/Makefile
 
+PURGATORY_SRCS+=$($(ARCH)_PURGATORY_SRCS)
+
 PURGATORY_OBJS = $(call objify, $(PURGATORY_SRCS)) purgatory/sha256.o
 PURGATORY_DEPS = $(call depify, $(PURGATORY_OBJS))
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
