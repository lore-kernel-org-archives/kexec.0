Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat.scz.novell.com ([213.151.88.252] helo=nathan.suse.cz)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StHdU-0001op-GL
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 12:21:17 +0000
Message-Id: <20120723113255.542502123@suse.cz>
Date: Mon, 23 Jul 2012 13:32:52 +0200
From: ptesarik@suse.cz
Subject: [PATCH 8/8] Make max_pfn symbol optional for Xen dumps
References: <20120723113244.751777873@suse.cz>
Content-Disposition: inline; filename=makedumpfile-xen-max_pfn-optional.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>

After commit ec5b5835a113cf62a168d4a7354564a38de6b52c, makedumpfile fails on
Xen dumps unless the "max_pfn" symbol is known. This happens even when the
dump level is 0 and 1, where it worked previously. This is especially bad for
kernels which do not put the "max_pfn" symbol into its ELF VMCOREINFO.

With this patch, the "max_pfn" symbol is required only if the specified
dump level needs it.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 makedumpfile.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -143,13 +143,15 @@ get_dom0_mapnr()
 {
 	unsigned long max_pfn;
 
-	if (SYMBOL(max_pfn) == NOT_FOUND_SYMBOL)
-		return FALSE;
-
-	if (!readmem(VADDR, SYMBOL(max_pfn), &max_pfn, sizeof max_pfn))
-		return FALSE;
+	if (SYMBOL(max_pfn) != NOT_FOUND_SYMBOL) {
+		if (!readmem(VADDR, SYMBOL(max_pfn), &max_pfn, sizeof max_pfn)) {
+			ERRMSG("Can't read domain-0 max_pfn.\n");
+			return FALSE;
+		}
 
-	info->dom0_mapnr = max_pfn;
+		info->dom0_mapnr = max_pfn;
+		DEBUG_MSG("domain-0 pfn : %llx\n", info->dom0_mapnr);
+	}
 
 	return TRUE;
 }
@@ -2430,14 +2432,6 @@ get_mem_map(void)
 {
 	int ret;
 
-	if (is_xen_memory()) {
-		if (!get_dom0_mapnr()) {
-			ERRMSG("Can't domain-0 pfn.\n");
-			return FALSE;
-		}
-		DEBUG_MSG("domain-0 pfn : %llx\n", info->dom0_mapnr);
-	}
-
 	switch (get_mem_type()) {
 	case SPARSEMEM:
 		DEBUG_MSG("\n");
@@ -3475,6 +3469,10 @@ exclude_free_page(void)
 		ERRMSG("Can't get necessary structures for excluding free pages.\n");
 		return FALSE;
 	}
+	if (is_xen_memory() && !info->dom0_mapnr) {
+		ERRMSG("Can't get max domain-0 PFN for excluding free pages.\n");
+		return FALSE;
+	}
 
 	/*
 	 * Detect free pages and update 2nd-bitmap.
@@ -3749,6 +3747,11 @@ exclude_unnecessary_pages(void)
 	struct mem_map_data *mmd;
 	struct timeval tv_start;
 
+	if (is_xen_memory() && !info->dom0_mapnr) {
+		ERRMSG("Can't get max domain-0 PFN for excluding pages.\n");
+		return FALSE;
+	}
+
 	gettimeofday(&tv_start, NULL);
 
 	for (mm = 0; mm < info->num_mem_map; mm++) {
@@ -5816,6 +5819,8 @@ initial_xen(void)
 out:
 	if (!get_max_mapnr())
 		return FALSE;
+	if (!get_dom0_mapnr())
+		return FALSE;
 
 	return TRUE;
 #endif



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
