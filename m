Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from acsinet15.oracle.com ([141.146.126.227])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SzpFH-0004eS-OT
 for kexec@lists.infradead.org; Fri, 10 Aug 2012 13:27:20 +0000
Date: Fri, 10 Aug 2012 15:25:56 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 2/6] xen: Read only crash notes for onlined CPUs
Message-ID: <20120810132556.GC2576@host-192-168-1-59.local.net-space.pl>
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

Read only crash notes for onlined CPUs. Crash notes for not running
CPUs does not exist in core file. Do not try to read them.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.0.8.orig/xen_hyper.c crash-6.0.8/xen_hyper.c
--- crash-6.0.8.orig/xen_hyper.c	2012-07-05 15:34:45.000000000 +0200
+++ crash-6.0.8/xen_hyper.c	2012-07-05 15:35:05.000000000 +0200
@@ -633,18 +633,18 @@ xen_hyper_dumpinfo_init(void)
 	}
 
 	/* allocate a context area */
-	size = sizeof(struct xen_hyper_dumpinfo_context) * XEN_HYPER_MAX_CPUS();
+	size = sizeof(struct xen_hyper_dumpinfo_context) * machdep->get_smp_cpus();
 	if((xhdit->context_array = malloc(size)) == NULL) {
 		error(FATAL, "cannot malloc dumpinfo table context space.\n");
 	}
 	BZERO(xhdit->context_array, size);
-	size = sizeof(struct xen_hyper_dumpinfo_context_xen_core) * XEN_HYPER_MAX_CPUS();
+	size = sizeof(struct xen_hyper_dumpinfo_context_xen_core) * machdep->get_smp_cpus();
 	if((xhdit->context_xen_core_array = malloc(size)) == NULL) {
 		error(FATAL, "cannot malloc dumpinfo table context_xen_core_array space.\n");
 	}
 	BZERO(xhdit->context_xen_core_array, size);
 	addr = symbol_value("per_cpu__crash_notes");
-	for (i = 0; i < XEN_HYPER_MAX_CPUS(); i++) {
+	for (i = 0; i < machdep->get_smp_cpus(); i++) {
 		ulong addr_notes;
 
 		addr_notes = xen_hyper_per_cpu(addr, i);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
