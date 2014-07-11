Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5V4s-0004Ow-Qa
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 07:17:07 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 6/7] implement a function to print the memory usage
Date: Fri, 11 Jul 2014 15:16:03 +0800
Message-Id: <1405062964-11406-6-git-send-email-bhe@redhat.com>
In-Reply-To: <1405062964-11406-1-git-send-email-bhe@redhat.com>
References: <1405062964-11406-1-git-send-email-bhe@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

Introduce print_mem_usage to print the result of analysis of /proc/kcore.
The page number of memory in different use are printed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index b67ede1..a170dd3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7830,6 +7830,46 @@ print_report(void)
 	REPORT_MSG("\n");
 }
 
+static void
+print_mem_usage(void)
+{
+	mdf_pfn_t pfn_original, pfn_excluded, shrinking;
+
+	/*
+	* /proc/vmcore doesn't contain the memory hole area.
+	*/
+	pfn_original = info->max_mapnr - pfn_memhole;
+
+	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
+	    + pfn_user + pfn_free + pfn_hwpoison;
+	shrinking = (pfn_original - pfn_excluded) * 100;
+	shrinking = shrinking / pfn_original;
+
+	MSG("\n");
+	MSG("Page number of memory in different use\n");
+	MSG("--------------------------------------------------\n");
+	MSG("TYPE			PAGES			EXCLUDABLE	DESCRIPTION\n");
+
+	MSG("pfn_zero		0x%016llx	yes		Pages filled with zero\n", pfn_zero);
+	MSG("pfn_cache		0x%016llx	yes		Cache pages\n", pfn_cache);
+	MSG("pfn_cache_private	0x%016llx	yes		Cache pages + private\n",
+	    pfn_cache_private);
+	MSG("pfn_user		0x%016llx	yes		User process data pages\n", pfn_user);
+	MSG("pfn_free		0x%016llx	yes		Free pages\n", pfn_free);
+	MSG("pfn_hwpoison		0x%016llx	yes		Hwpoison pages\n", pfn_hwpoison);
+	MSG("pfn_kernel_data		0x%016llx	no		Dumpable kernel data \n",
+	    pfn_original - pfn_excluded);
+
+	MSG("\n");
+
+	MSG("Total pages on system:	0x%016llx\n", pfn_original);
+	MSG("Excludable pages:	0x%016llx\n", pfn_excluded);
+	MSG("Memory Hole: 		0x%016llx\n", pfn_memhole);
+	MSG("--------------------------------------------------\n");
+	MSG("Total pages:		0x%016llx\n", info->max_mapnr);
+	MSG("\n");
+}
+
 int
 writeout_dumpfile(void)
 {
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
