Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qrs6r-0001vC-O4
	for kexec@lists.infradead.org; Fri, 12 Aug 2011 13:49:16 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7CDn9Xx021269
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 13:49:09 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7CDn9bg2408682
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 14:49:09 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7CDn8BS003143
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 07:49:08 -0600
Message-Id: <20110812134907.816664005@linux.vnet.ibm.com>
Date: Fri, 12 Aug 2011 15:48:55 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 6/8] s390: Do first kdump checksum test before really
	starting kdump
References: <20110812134849.748973593@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-arch-backend-entry.patch
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

With this patch first the kdump checksums in purgatory are verified (with
start_kdump(0)) before kdump is started. This allows us to do the shutdown
actions defined under /sys/firmware as recovery action in case kdump is
overwritten. The main use case is to define stand-alone dump as recovery
action.

We have to split the purgatory function into "checksum test" and "real
execution", because we have to switch to the IPL CPU when we execute kdump.
After the switch it is not possible to return from the called function.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/kernel/machine_kexec.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -325,8 +325,16 @@ void machine_kexec(struct kimage *image)
 {
 	tracer_disable();
 #ifdef CONFIG_CRASH_DUMP
-	if (image->type == KEXEC_TYPE_CRASH)
+	if (image->type == KEXEC_TYPE_CRASH) {
+		int (*start_kdump)(int) = (void *)image->start;
+		int rc;
+		__arch_local_irq_stnsm(0xfb); /* disable DAT */
+		rc = start_kdump(0);
+		__arch_local_irq_stosm(0x04); /* enable DAT */
+		if (rc)
+			return;
 		smp_switch_to_ipl_cpu(__machine_kdump, image);
+	}
 #endif
 	smp_send_stop();
 	smp_switch_to_ipl_cpu(__machine_kexec, image);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
