Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYJ7u-0006DE-Hv
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 16:14:15 +0000
Date: Tue, 13 Nov 2012 17:13:54 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 3/5] xen: Use per_cpu__crash_notes or crash_notes array
Message-ID: <20121113161354.GD2942@host-192-168-1-59.local.net-space.pl>
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

Newer Xen versions (at least 4.2) use crash_notes array
instead of per_cpu__crash_notes. Take into account that.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.1.0.orig/xen_hyper.c crash-6.1.0/xen_hyper.c
--- crash-6.1.0.orig/xen_hyper.c	2012-09-27 21:19:15.000000000 +0200
+++ crash-6.1.0/xen_hyper.c	2012-11-12 15:56:17.000000000 +0100
@@ -645,15 +645,22 @@ xen_hyper_dumpinfo_init(void)
 		error(FATAL, "cannot malloc dumpinfo table context_xen_core_array space.\n");
 	}
 	BZERO(xhdit->context_xen_core_array, size);
-	addr = symbol_value("per_cpu__crash_notes");
+	if (symbol_exists("per_cpu__crash_notes"))
+		addr = symbol_value("per_cpu__crash_notes");
+	else
+		get_symbol_data("crash_notes", sizeof(ulong), &addr);
 	for (i = 0; i < machdep->get_smp_cpus(); i++) {
 		ulong addr_notes;
 
-		addr_notes = xen_hyper_per_cpu(addr, i);
+		if (symbol_exists("per_cpu__crash_notes"))
+			addr_notes = xen_hyper_per_cpu(addr, i);
+		else
+			addr_notes = addr + i * STRUCT_SIZE("crash_note_range_t") +
+					MEMBER_OFFSET("crash_note_range_t", "start");
 		if (xhdit->note_ver == XEN_HYPER_ELF_NOTE_V4) {
 			if (!readmem(addr_notes, KVADDR, &(xhdit->context_array[i].note),
-			sizeof(ulong), "per_cpu__crash_notes", RETURN_ON_ERROR)) {
-				error(WARNING, "cannot read per_cpu__crash_notes.\n");
+			sizeof(ulong), "crash_notes", RETURN_ON_ERROR)) {
+				error(WARNING, "cannot read crash_notes.\n");
 				return;
 			}
 		} else {
@@ -678,7 +685,7 @@ xen_hyper_dumpinfo_init(void)
 	xhdit->xen_info_cpu = samp_cpuid;
 	if (!xen_hyper_fill_elf_notes(xhdit->context_array[samp_cpuid].note,
 	buf, XEN_HYPER_ELF_NOTE_FILL_T_NOTE)) {
-		error(FATAL, "cannot read per_cpu__crash_notes.\n");
+		error(FATAL, "cannot read crash_notes.\n");
 	}
 	bp = buf;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
