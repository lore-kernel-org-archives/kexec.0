Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSO5o-0006Kz-1D
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 09:56:24 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 25 Mar 2014 09:55:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2B3DB1B08040
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 09:55:48 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2P9thQ749676378
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 09:55:43 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2P9tsub003166
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 03:55:54 -0600
Subject: [PATCH] ppc64/purgatory: Disabling GCC's stack protection
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 25 Mar 2014 10:55:53 +0100
Message-ID: <20140325095553.17118.47384.stgit@nimbus>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
Cc: dvaleev@suse.com

Some Linux distributions, like Suse, are turning on the GCC's stack
protection mechanism by default (-fstack-protector). When building the
purgatory with this option, this leads to link issues that are revealed at
runtime when the purgatory is loaded because symbols like __stack_chk_fail
are unresolved.

This patch forces this stack protection mechanism to be turned off when
building the purgatory on ppc64 BE and LE.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 purgatory/arch/ppc64/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 31076e9..712e2b1 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -9,7 +9,7 @@ ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
 
-ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float
+ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float -fno-stack-protector
 ppc64_PURGATORY_EXTRA_ASFLAGS += -m64
 ifeq ($(SUBARCH),BE)
 	ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
