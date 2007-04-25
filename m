Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv1.oss.ntt.co.jp ([222.151.198.98])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hgg1i-0007T7-HS
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 07:51:15 -0400
Subject: [PATCH 10/10] Use safe_apic_wait_icr_idle in __send_IPI_dest_field
	- x86_64
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
In-Reply-To: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
References: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
Date: Wed, 25 Apr 2007 20:51:12 +0900
Message-Id: <1177501872.17974.56.camel@sebastian.intellilink.co.jp>
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

Use safe_apic_wait_icr_idle to check ICR idle bit if the vector is
NMI_VECTOR to avoid potential hangups in the event of crash when kdump
tries to stop the other CPUs.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-2.6.21-rc7-orig/include/asm-x86_64/ipi.h linux-2.6.21-rc7/include/asm-x86_64/ipi.h
--- linux-2.6.21-rc7-orig/include/asm-x86_64/ipi.h	2007-04-23 17:34:56.000000000 +0900
+++ linux-2.6.21-rc7/include/asm-x86_64/ipi.h	2007-04-25 19:15:01.000000000 +0900
@@ -87,7 +87,10 @@ static inline void __send_IPI_dest_field
 	/*
 	 * Wait for idle.
 	 */
-	apic_wait_icr_idle();
+	if (unlikely(vector == NMI_VECTOR))
+		safe_apic_wait_icr_idle();
+	else
+		apic_wait_icr_idle();
 
 	/*
 	 * prepare target chip field



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
