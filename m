Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3qNg-0002nT-EV
 for kexec@lists.infradead.org; Tue, 21 Aug 2012 15:28:37 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9399EA3DDE
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2012 17:28:35 +0200 (CEST)
Resent-To: kexec@lists.infradead.org
Resent-Message-ID: <201208211728.35310.ptesarik@suse.cz>
Message-Id: <20120821084451.843240466@azariah.suse.cz>
Date: Tue, 21 Aug 2012 10:44:52 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [patch 1/9] Make max_pfn symbol optional for Xen dumps
References: <20120821084451.587187471@azariah.suse.cz>
Content-Disposition: inline; filename=01-xen-max_pfn-optional.patch
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
Cc: Petr Tesarik <ptesarik@suse.cz>, Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

After commit ec5b5835a113cf62a168d4a7354564a38de6b52c, makedumpfile fails
on Xen dumps unless the "max_pfn" symbol is known. This happens even when
the dump level is 0 and 1, where it worked previously. This is especially
bad for kernels which do not put the "max_pfn" symbol into its VMCOREINFO.

With this patch, the "max_pfn" symbol is required only if the specified
dump level needs it.

Note that we cannot call get_dom0_mapnr() from initial_xen(), because
"max_pfn" is a Linux symbol, which means that:
1. its address is determined in initial() (called after initial_xen)
2. it tries to read a Dom0 symbol, and Dom0 physical->machine mapping is
   initialized in get_machdep_info (called from initial).

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 makedumpfile.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

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
@@ -2706,6 +2700,9 @@ out:
 			return FALSE;
 	}
 
+	if (is_xen_memory() && !get_dom0_mapnr())
+		return FALSE;
+
 	return TRUE;
 }
 
@@ -3475,6 +3472,10 @@ exclude_free_page(void)
 		ERRMSG("Can't get necessary structures for excluding free pages.\n");
 		return FALSE;
 	}
+	if (is_xen_memory() && !info->dom0_mapnr) {
+		ERRMSG("Can't get max domain-0 PFN for excluding free pages.\n");
+		return FALSE;
+	}
 
 	/*
 	 * Detect free pages and update 2nd-bitmap.
@@ -3749,6 +3750,11 @@ exclude_unnecessary_pages(void)
 	struct mem_map_data *mmd;
 	struct timeval tv_start;
 
+	if (is_xen_memory() && !info->dom0_mapnr) {
+		ERRMSG("Can't get max domain-0 PFN for excluding pages.\n");
+		return FALSE;
+	}
+
 	gettimeofday(&tv_start, NULL);
 
 	for (mm = 0; mm < info->num_mem_map; mm++) {



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
