Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]
	helo=TX2EHSOBE008.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P3Cpk-0005q4-Qn
	for kexec@lists.infradead.org; Tue, 05 Oct 2010 19:05:53 +0000
Received: from mail71-tx2 (localhost.localdomain [127.0.0.1])	by
	mail71-tx2-R.bigfish.com (Postfix) with ESMTP id 547AED883C6	for
	<kexec@lists.infradead.org>; Tue,  5 Oct 2010 19:05:50 +0000 (UTC)
Received: from TX2EHSMHS042.bigfish.com (unknown [10.9.14.241])	by
	mail71-tx2.bigfish.com (Postfix) with ESMTP id DBE30B18060	for
	<kexec@lists.infradead.org>; Tue,  5 Oct 2010 19:05:38 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id
	o95J5aXY026017	for <kexec@lists.infradead.org>; Tue, 5 Oct 2010 12:05:36
	-0700 (MST)
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH] kexec/ppc: Use -O0 instead of -Os for purgatory
Date: Tue, 5 Oct 2010 14:17:23 -0500
Message-ID: <1286306243-14236-1-git-send-email-msm@freescale.com>
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
To: kexec@lists.infradead.org
Cc: Matthew McClintock <msm@freescale.com>

Purgatory code with -Os is not working on certain compilers,
instead of finding out the hard way, just compile with -O0

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
Tried to get a dicussion going on this issue, but for now I
suspect it is better to have a working kexec on ppc instead of
waiting

 purgatory/arch/ppc/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/purgatory/arch/ppc/Makefile b/purgatory/arch/ppc/Makefile
index 72289a0..319870e 100644
--- a/purgatory/arch/ppc/Makefile
+++ b/purgatory/arch/ppc/Makefile
@@ -2,6 +2,8 @@
 # Purgatory ppc
 #
 
+ppc_PURGATORY_EXTRA_CFLAGS = -O0
+
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/v2wrap_32.S
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/misc.S
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/purgatory-ppc.c
-- 
1.6.6.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
