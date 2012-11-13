Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYJ9j-0006dn-1T
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 16:16:07 +0000
Date: Tue, 13 Nov 2012 17:15:47 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 5/5] xen: Use cpu_present_map instead of cpu_online_map
Message-ID: <20121113161547.GF2942@host-192-168-1-59.local.net-space.pl>
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

Newer Xen versions (at least 4.2) clear cpu_online_map during crash.
In this case it is not possible to check which CPUs were available.
cpu_present_map contains such information but it has different meaning.
However, we do not have a choice and we must use cpu_present_map instead
of cpu_online_map.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.1.0.orig/xen_hyper.c crash-6.1.0/xen_hyper.c
--- crash-6.1.0.orig/xen_hyper.c	2012-11-13 15:08:41.000000000 +0100
+++ crash-6.1.0/xen_hyper.c	2012-11-13 15:09:03.000000000 +0100
@@ -1912,11 +1912,10 @@ xen_hyper_get_cpu_info(void)
 	if((xht->cpumask = malloc(XEN_HYPER_SIZE(cpumask_t))) == NULL) {
 		error(FATAL, "cannot malloc cpumask space.\n");
 	}
-	/* kakuma: It may be better to use cpu_present_map. */
-	addr = symbol_value("cpu_online_map");
+	addr = symbol_value("cpu_present_map");
 	if (!readmem(addr, KVADDR, xht->cpumask,
-		XEN_HYPER_SIZE(cpumask_t), "cpu_online_map", RETURN_ON_ERROR)) {
-		error(FATAL, "cannot read cpu_online_map.\n");
+		XEN_HYPER_SIZE(cpumask_t), "cpu_present_map", RETURN_ON_ERROR)) {
+		error(FATAL, "cannot read cpu_present_map.\n");
 	}
 	if (xht->cpu_idxs) {
 		free(xht->cpu_idxs);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
