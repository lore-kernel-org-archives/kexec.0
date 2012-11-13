Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYJ8r-0006Qs-SQ
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 16:15:14 +0000
Date: Tue, 13 Nov 2012 17:14:54 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 4/5] xen: Try hard to get max_cpus value
Message-ID: <20121113161454.GE2942@host-192-168-1-59.local.net-space.pl>
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

This patch improves max_cpus value calculation. First
xen_hyper_get_cpu_info() tries to get it from nr_cpu_ids
variable. If nr_cpu_ids does not exist then it attempts
to read max_cpus variable. If it is not available estimate
max_cpus value on the base of cpumask_t size.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.1.0.orig/xen_hyper.c crash-6.1.0/xen_hyper.c
--- crash-6.1.0.orig/xen_hyper.c	2012-11-13 15:02:34.000000000 +0100
+++ crash-6.1.0/xen_hyper.c	2012-11-13 15:07:40.000000000 +0100
@@ -1883,13 +1883,28 @@ xen_hyper_get_uptime_hyper(void)
 void
 xen_hyper_get_cpu_info(void)
 {
-	ulong addr;
+	ulong addr, init_begin, init_end;
 	ulong *cpumask;
 	uint *cpu_idx;
 	int i, j, cpus;
 
 	XEN_HYPER_STRUCT_SIZE_INIT(cpumask_t, "cpumask_t");
-	xht->max_cpus = XEN_HYPER_SIZE(cpumask_t) * 8;
+
+	if (symbol_exists("nr_cpu_ids"))
+		get_symbol_data("nr_cpu_ids", sizeof(uint), &xht->max_cpus);
+	else {
+		init_begin = symbol_value("__init_begin");
+		init_end = symbol_value("__init_end");
+		addr = symbol_value("max_cpus");
+
+		if (addr >= init_begin && addr < init_end)
+			xht->max_cpus = XEN_HYPER_SIZE(cpumask_t) * 8;
+		else {
+			get_symbol_data("max_cpus", sizeof(xht->max_cpus), &xht->max_cpus);
+			if (XEN_HYPER_SIZE(cpumask_t) * 8 > xht->max_cpus)
+				xht->max_cpus = XEN_HYPER_SIZE(cpumask_t) * 8;
+		}
+	}
 
 	if (xht->cpumask) {
 		free(xht->cpumask);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
