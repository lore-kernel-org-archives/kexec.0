Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYJ5l-00062X-Rs
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 16:12:02 +0000
Date: Tue, 13 Nov 2012 17:11:40 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 1/5] xen: Fix page tables caching issues
Message-ID: <20121113161140.GB2942@host-192-168-1-59.local.net-space.pl>
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

Xen specific functions reading page tables utilize a form
of cache to speed up reading process. However, some of them
do not properly update info about cached data. In specific
cases it leads to the situation in which functions attempting
to use cached data in real read freshly loaded garbage. This
patch fixes this issue by adding relevant updates
for cached info data.

Linux Kernel commit 250a41e0ecc433cdd553a364d0fc74c766425209
(xen/p2m: Reuse existing P2M leafs if they are filled
with 1:1 PFNs or INVALID) helped to discover this issue.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.1.0.orig/x86.c crash-6.1.0/x86.c
--- crash-6.1.0.orig/x86.c	2012-09-27 21:19:15.000000000 +0200
+++ crash-6.1.0/x86.c	2012-11-12 15:29:45.000000000 +0100
@@ -4684,6 +4684,7 @@ use_cr3:
 
         machdep->last_ptbl_read = BADADDR;
         machdep->last_pmd_read = BADADDR;
+        machdep->last_pgd_read = BADADDR;
 
         for (i = 0; i < xkd->p2m_frames; i++) {
                 xkd->p2m_mfn_frame_list[i] = x86_xen_kdump_page_mfn(kvaddr);
@@ -4698,6 +4699,7 @@ use_cr3:
 
         machdep->last_ptbl_read = 0;
         machdep->last_pmd_read = 0;
+        machdep->last_pgd_read = 0;
 	pc->readmem = read_kdump;
 	if (CRASHDEBUG(1)) 
 		fprintf(fp, "readmem (restore): read_kdump()\n");
@@ -4910,6 +4912,8 @@ x86_xendump_p2m_create(struct xendump_da
 	if (!xc_core_mfn_to_page(mfn, machdep->pgd))
 		error(FATAL, "cannot read/find cr3 page\n");
 
+	machdep->last_pgd_read = mfn;
+
 	if (CRASHDEBUG(1)) {
 		fprintf(xd->ofp, "contents of page directory page:\n");	
 
@@ -5008,6 +5012,8 @@ x86_pvops_xendump_p2m_create(struct xend
 	if (!xc_core_mfn_to_page(mfn, machdep->pgd))
 		error(FATAL, "cannot read/find cr3 page\n");
 
+	machdep->last_pgd_read = mfn;
+
 	if (CRASHDEBUG(1)) {
 		fprintf(xd->ofp, "contents of page directory page:\n");	
 
diff -Npru crash-6.1.0.orig/x86_64.c crash-6.1.0/x86_64.c
--- crash-6.1.0.orig/x86_64.c	2012-09-27 21:19:15.000000000 +0200
+++ crash-6.1.0/x86_64.c	2012-11-09 14:41:29.000000000 +0100
@@ -5653,6 +5653,8 @@ x86_64_xen_kdump_load_page(ulong kvaddr,
         if (!readmem(PTOB(mfn), PHYSADDR, machdep->pgd, PAGESIZE(),
             "xen kdump pud page", RETURN_ON_ERROR))
 		error(FATAL, "cannot read/find pud page\n");
+
+	machdep->last_pgd_read = mfn;
         
         if (CRASHDEBUG(7))
 		x86_64_debug_dump_page(fp, machdep->pgd, 
@@ -5670,6 +5672,8 @@ x86_64_xen_kdump_load_page(ulong kvaddr,
             "xen kdump pmd page", RETURN_ON_ERROR))
                 error(FATAL, "cannot read/find pmd page\n");
 
+	machdep->last_pmd_read = mfn;
+
         if (CRASHDEBUG(7)) 
 		x86_64_debug_dump_page(fp, machdep->pmd, 
 			"contents of page middle directory page:");
@@ -5686,6 +5690,8 @@ x86_64_xen_kdump_load_page(ulong kvaddr,
             "xen kdump page table page", RETURN_ON_ERROR))
                 error(FATAL, "cannot read/find page table page\n");
 
+	machdep->last_ptbl_read = mfn;
+
         if (CRASHDEBUG(7)) 
 		x86_64_debug_dump_page(fp, machdep->ptbl, 
 			"contents of page table page:");
@@ -6304,6 +6310,8 @@ x86_64_xendump_load_page(ulong kvaddr, s
 	if (!xc_core_mfn_to_page(mfn, machdep->pgd))
 		error(FATAL, "cannot read/find pud page\n");
 
+	machdep->last_pgd_read = mfn;
+
         if (CRASHDEBUG(7))
 		x86_64_debug_dump_page(xd->ofp, machdep->pgd, 
                 	"contents of page upper directory page:");
@@ -6319,6 +6327,8 @@ x86_64_xendump_load_page(ulong kvaddr, s
         if (!xc_core_mfn_to_page(mfn, machdep->pmd))
                 error(FATAL, "cannot read/find pmd page\n");
 
+	machdep->last_pmd_read = mfn;
+
         if (CRASHDEBUG(7)) 
 		x86_64_debug_dump_page(xd->ofp, machdep->pmd, 
 			"contents of page middle directory page:");
@@ -6334,6 +6344,8 @@ x86_64_xendump_load_page(ulong kvaddr, s
         if (!xc_core_mfn_to_page(mfn, machdep->ptbl))
                 error(FATAL, "cannot read/find page table page\n");
 
+	machdep->last_ptbl_read = mfn;
+
         if (CRASHDEBUG(7)) 
 		x86_64_debug_dump_page(xd->ofp, machdep->ptbl, 
 			"contents of page table page:");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
