Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYJ6S-00064l-L7
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 16:12:45 +0000
Date: Tue, 13 Nov 2012 17:12:25 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 2/5] xen: Use init_tss array or per_cpu__init_tss
Message-ID: <20121113161225.GC2942@host-192-168-1-59.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
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
To: anderson@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Newer Xen versions (at least 4.2) use per_cpu__init_tss
instead of init_tss array. Take into account that.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.1.0.orig/x86.c crash-6.1.0/x86.c
--- crash-6.1.0.orig/x86.c	2012-11-13 14:45:58.000000000 +0100
+++ crash-6.1.0/x86.c	2012-11-13 14:48:13.000000000 +0100
@@ -5471,9 +5471,16 @@ x86_get_stackbase_hyper(ulong task)
 	if (!xen_hyper_test_pcpu_id(pcpu)) {
 		error(FATAL, "invalid pcpu number\n");
 	}
-	init_tss = symbol_value("init_tss");
+
+	if (symbol_exists("init_tss")) {
+		init_tss = symbol_value("init_tss");
+		init_tss += XEN_HYPER_SIZE(tss_struct) * pcpu;
+	} else {
+		init_tss = symbol_value("per_cpu__init_tss");
+		init_tss = xen_hyper_per_cpu(init_tss, pcpu);
+	}
+	
 	buf = GETBUF(XEN_HYPER_SIZE(tss_struct));
-	init_tss += XEN_HYPER_SIZE(tss_struct) * pcpu;
 	if (!readmem(init_tss, KVADDR, buf,
 			XEN_HYPER_SIZE(tss_struct), "init_tss", RETURN_ON_ERROR)) {
 		error(FATAL, "cannot read init_tss.\n");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
