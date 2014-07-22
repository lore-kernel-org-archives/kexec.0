Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X9cqG-0003pj-0n
 for kexec@lists.infradead.org; Tue, 22 Jul 2014 16:23:05 +0000
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 22 Jul 2014 17:22:32 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A63611B08040
 for <kexec@lists.infradead.org>; Tue, 22 Jul 2014 17:23:12 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6MGMTqY34472032
 for <kexec@lists.infradead.org>; Tue, 22 Jul 2014 16:22:29 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6MGMTBJ010815
 for <kexec@lists.infradead.org>; Tue, 22 Jul 2014 12:22:29 -0400
Subject: [PATCH] kexec/ppc64: disabling exception handling when building the
 purgatory
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 22 Jul 2014 18:22:28 +0200
Message-ID: <20140722162228.12506.28076.stgit@nimbus>
In-Reply-To: <20140722104255.GF13924@dhcp-17-37.nay.redhat.com>
References: <20140722104255.GF13924@dhcp-17-37.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, chaowang@redhat.com
Cc: kexec@lists.infradead.org

Some Linux distributions would like to turn on the GCC exception handling
by default. As this option introduces symbols in the built code that are
defined in a separate shared library, this is not a good idea to have such
an option activated when building the purgatory.

This patch forces the exception handling to be turned off when building the
purgatory on ppc64 BE and LE.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 purgatory/arch/ppc64/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 712e2b194bee..6c58fa20dad9 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -9,7 +9,8 @@ ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
 
-ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float -fno-stack-protector
+ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float -fno-stack-protector	\
+				-fno-exceptions
 ppc64_PURGATORY_EXTRA_ASFLAGS += -m64
 ifeq ($(SUBARCH),BE)
 	ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
