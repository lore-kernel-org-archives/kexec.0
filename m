Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from acsinet15.oracle.com ([141.146.126.227])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SmnaJ-0004Mb-Bg
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 15:03:12 +0000
Date: Thu, 5 Jul 2012 17:02:09 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 3/5] x86/xen: Read variables from dynamically allocated
 per_cpu data
Message-ID: <20120705150209.GE2007@host-192-168-1-59.local.net-space.pl>
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

per_cpu data is dynamically allocated since 21416 changeset (x86: Dynamically
allocate percpu data area when a CPU comes online). Take into account that
and read variables from correct address.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.0.8.orig/xen_hyper.c crash-6.0.8/xen_hyper.c
--- crash-6.0.8.orig/xen_hyper.c	2012-07-05 15:47:09.000000000 +0200
+++ crash-6.0.8/xen_hyper.c	2012-07-05 15:50:19.000000000 +0200
@@ -64,7 +64,6 @@ xen_hyper_init(void)
 	machdep->get_smp_cpus();
 	machdep->memory_size();
 
-#ifdef IA64
 	if (symbol_exists("__per_cpu_offset")) {
 		xht->flags |= XEN_HYPER_SMP;
 		if((xht->__per_cpu_offset = malloc(sizeof(ulong) * XEN_HYPER_MAX_CPUS())) == NULL) {
@@ -76,7 +75,6 @@ xen_hyper_init(void)
 			error(FATAL, "cannot read __per_cpu_offset.\n");
 		}
 	}
-#endif
 
 #if defined(X86) || defined(X86_64)
 	if (symbol_exists("__per_cpu_shift")) {
diff -Npru crash-6.0.8.orig/xen_hyper_defs.h crash-6.0.8/xen_hyper_defs.h
--- crash-6.0.8.orig/xen_hyper_defs.h	2012-06-29 16:59:18.000000000 +0200
+++ crash-6.0.8/xen_hyper_defs.h	2012-07-05 15:50:19.000000000 +0200
@@ -136,7 +136,13 @@ typedef uint32_t	Elf_Word;
 
 #if defined(X86) || defined(X86_64)
 #define xen_hyper_per_cpu(var, cpu)  \
-	((ulong)(var) + (((ulong)(cpu))<<xht->percpu_shift))
+	({ ulong __var_addr; \
+	   if (xht->__per_cpu_offset) \
+		__var_addr = (xht->flags & XEN_HYPER_SMP) ? \
+			((ulong)(var) + xht->__per_cpu_offset[cpu]) : (ulong)(var); \
+	   else \
+		__var_addr = (ulong)(var) + ((ulong)(cpu) << xht->percpu_shift); \
+	   __var_addr; })
 #elif defined(IA64)
 #define xen_hyper_per_cpu(var, cpu)  \
 	((xht->flags & XEN_HYPER_SMP) ? \

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
