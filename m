Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qm3gj-0006TT-0j
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 12:58:13 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6RCw9Xx009943
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 12:58:09 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
	[9.149.37.229])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6RCw8Nc2621652
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 13:58:08 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6RCw88t001586
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 06:58:08 -0600
Message-Id: <20110727125808.028895659@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 14:55:08 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 04/10] kdump: Trigger kdump via panic notifier chain on s390
References: <20110727125504.491183728@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-shutdown-action.patch
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

On s390 we have the possibility to configure actions that are executed in
case of a kernel panic. E.g. it is possible to automatically trigger an s390
stand-alone dump. The actions are called via a panic notifier.  We also want
to trigger kdump via the notifier call chain. Therefore this patch disables
for s390 the direct kdump invocation in the panic() function.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/panic.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -84,9 +84,12 @@ NORET_TYPE void panic(const char * fmt,
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
+	 * For s390 kdump is triggered via the panic notifier call chain.
 	 * Do we want to call this before we try to display a message?
 	 */
+#if !defined(CONFIG_S390)
 	crash_kexec(NULL);
+#endif
 
 	kmsg_dump(KMSG_DUMP_PANIC);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
