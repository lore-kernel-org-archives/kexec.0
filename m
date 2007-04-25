Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv1.oss.ntt.co.jp ([222.151.198.98])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hgg42-0007XS-Rs
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 07:54:01 -0400
Subject: [PATCH 4/10] smpboot: use safe_apic_wait_icr_idle - x86_64
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
In-Reply-To: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
References: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
Date: Wed, 25 Apr 2007 20:21:13 +0900
Message-Id: <1177500073.17974.21.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de, horms@verge.net.au, mbligh@google.com, Keith Owens <kaos@ocs.com.au>, akpm@linux-foundation.org

The functionality provided by the new safe_apic_wait_icr_idle is being
open-coded all over "kernel/smpboot.c". Use safe_apic_wait_icr_idle
instead to consolidate code and ease maintenance.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-2.6.21-rc7-orig/arch/x86_64/kernel/smpboot.c linux-2.6.21-rc7/arch/x86_64/kernel/smpboot.c
--- linux-2.6.21-rc7-orig/arch/x86_64/kernel/smpboot.c	2007-04-18 15:27:48.000000000 +0900
+++ linux-2.6.21-rc7/arch/x86_64/kernel/smpboot.c	2007-04-18 15:52:08.000000000 +0900
@@ -430,8 +430,8 @@ static void inquire_remote_apic(int apic
  */
 static int __cpuinit wakeup_secondary_via_INIT(int phys_apicid, unsigned int start_rip)
 {
-	unsigned long send_status = 0, accept_status = 0;
-	int maxlvt, timeout, num_starts, j;
+	unsigned long send_status, accept_status = 0;
+	int maxlvt, num_starts, j;
 
 	Dprintk("Asserting INIT.\n");
 
@@ -447,12 +447,7 @@ static int __cpuinit wakeup_secondary_vi
 				| APIC_DM_INIT);
 
 	Dprintk("Waiting for send to finish...\n");
-	timeout = 0;
-	do {
-		Dprintk("+");
-		udelay(100);
-		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
-	} while (send_status && (timeout++ < 1000));
+	send_status = safe_apic_wait_icr_idle();
 
 	mdelay(10);
 
@@ -465,12 +460,7 @@ static int __cpuinit wakeup_secondary_vi
 	apic_write(APIC_ICR, APIC_INT_LEVELTRIG | APIC_DM_INIT);
 
 	Dprintk("Waiting for send to finish...\n");
-	timeout = 0;
-	do {
-		Dprintk("+");
-		udelay(100);
-		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
-	} while (send_status && (timeout++ < 1000));
+	send_status = safe_apic_wait_icr_idle();
 
 	mb();
 	atomic_set(&init_deasserted, 1);
@@ -509,12 +499,7 @@ static int __cpuinit wakeup_secondary_vi
 		Dprintk("Startup point 1.\n");
 
 		Dprintk("Waiting for send to finish...\n");
-		timeout = 0;
-		do {
-			Dprintk("+");
-			udelay(100);
-			send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
-		} while (send_status && (timeout++ < 1000));
+		send_status = safe_apic_wait_icr_idle();
 
 		/*
 		 * Give the other CPU some time to accept the IPI.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
