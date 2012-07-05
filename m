Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from acsinet15.oracle.com ([141.146.126.227])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SmnYN-0003qw-7F
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 15:01:17 +0000
Date: Thu, 5 Jul 2012 17:00:08 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 1/5] xen: Always calculate max_cpus value
Message-ID: <20120705150008.GC2007@host-192-168-1-59.local.net-space.pl>
References: <20120705145839.GB2007@host-192-168-1-59.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120705145839.GB2007@host-192-168-1-59.local.net-space.pl>
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
To: anderson@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

max_cpus is not available since 20374 changeset (Miscellaneous data
placement adjustments). It was moved to __initdata section. This section
is freed after Xen initialization. Assume that max_cpus is always
equal to XEN_HYPER_SIZE(cpumask_t) * 8.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.0.8.orig/xen_hyper.c crash-6.0.8/xen_hyper.c
--- crash-6.0.8.orig/xen_hyper.c	2012-06-29 16:59:18.000000000 +0200
+++ crash-6.0.8/xen_hyper.c	2012-07-05 14:52:59.000000000 +0200
@@ -1879,11 +1879,9 @@ xen_hyper_get_cpu_info(void)
 	uint *cpu_idx;
 	int i, j, cpus;
 
-	get_symbol_data("max_cpus", sizeof(xht->max_cpus), &xht->max_cpus);
 	XEN_HYPER_STRUCT_SIZE_INIT(cpumask_t, "cpumask_t");
-	if (XEN_HYPER_SIZE(cpumask_t) * 8 > xht->max_cpus) {
-		xht->max_cpus = XEN_HYPER_SIZE(cpumask_t) * 8;
-	}
+	xht->max_cpus = XEN_HYPER_SIZE(cpumask_t) * 8;
+
 	if (xht->cpumask) {
 		free(xht->cpumask);
 	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
