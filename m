Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.oss.ntt.co.jp ([222.151.198.98] helo=serv1.oss.ntt.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hgg42-0007XR-Rh
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 07:54:03 -0400
Subject: [PATCH 6/10] inquire_remote_apic: use safe_apic_wait_icr_idle - x86_64
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
In-Reply-To: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
References: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
Date: Wed, 25 Apr 2007 20:27:26 +0900
Message-Id: <1177500446.17974.30.camel@sebastian.intellilink.co.jp>
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

inquire_remote_apic is used for APIC debugging, so use
safe_apic_wait_icr_idle  instead of apic_wait_icr_idle to avoid possible
lockups when APIC delivery fails.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-2.6.21-rc7-orig/arch/x86_64/kernel/smpboot.c linux-2.6.21-rc7/arch/x86_64/kernel/smpboot.c
--- linux-2.6.21-rc7-orig/arch/x86_64/kernel/smpboot.c	2007-04-18 15:53:11.000000000 +0900
+++ linux-2.6.21-rc7/arch/x86_64/kernel/smpboot.c	2007-04-18 16:39:20.000000000 +0900
@@ -392,7 +392,8 @@ static void inquire_remote_apic(int apic
 {
 	unsigned i, regs[] = { APIC_ID >> 4, APIC_LVR >> 4, APIC_SPIV >> 4 };
 	char *names[] = { "ID", "VERSION", "SPIV" };
-	int timeout, status;
+	int timeout;
+	unsigned int status;
 
 	printk(KERN_INFO "Inquiring remote APIC #%d...\n", apicid);
 
@@ -402,7 +403,9 @@ static void inquire_remote_apic(int apic
 		/*
 		 * Wait for idle.
 		 */
-		apic_wait_icr_idle();
+		status = safe_apic_wait_icr_idle();
+		if (status)
+			printk("a previous APIC delivery may have failed\n");
 
 		apic_write(APIC_ICR2, SET_APIC_DEST_FIELD(apicid));
 		apic_write(APIC_ICR, APIC_DM_REMRD | regs[i]);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
