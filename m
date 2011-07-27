Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qm3gk-0006TW-Os
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 12:58:16 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6RCw816025144
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 12:58:08 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6RCw8k72461846
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 13:58:08 +0100
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6RCw7a9012160
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 13:58:08 +0100
Message-Id: <20110727125807.529303146@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 14:55:05 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 01/10] kdump: Add KEXEC_CRASH_CONTROL_MEMORY_LIMIT
References: <20110727125504.491183728@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-control-limit.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

On s390 there is a different KEXEC_CONTROL_MEMORY_LIMIT for the normal and
the kdump kexec case. Therefore this patch introduces a new macro
KEXEC_CRASH_CONTROL_MEMORY_LIMIT. This is set to
KEXEC_CONTROL_MEMORY_LIMIT for all architectures that do not define
KEXEC_CRASH_CONTROL_MEMORY_LIMIT.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 include/linux/kexec.h |    4 ++++
 kernel/kexec.c        |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,10 @@
 #error KEXEC_ARCH not defined
 #endif
 
+#ifndef KEXEC_CRASH_CONTROL_MEMORY_LIMIT
+#define KEXEC_CRASH_CONTROL_MEMORY_LIMIT KEXEC_CONTROL_MEMORY_LIMIT
+#endif
+
 #define KEXEC_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define KEXEC_CORE_NOTE_NAME "CORE"
 #define KEXEC_CORE_NOTE_NAME_BYTES ALIGN(sizeof(KEXEC_CORE_NOTE_NAME), 4)
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -498,7 +498,7 @@ static struct page *kimage_alloc_crash_c
 	while (hole_end <= crashk_res.end) {
 		unsigned long i;
 
-		if (hole_end > KEXEC_CONTROL_MEMORY_LIMIT)
+		if (hole_end > KEXEC_CRASH_CONTROL_MEMORY_LIMIT)
 			break;
 		if (hole_end > crashk_res.end)
 			break;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
