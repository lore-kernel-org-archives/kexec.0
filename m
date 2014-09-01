Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOI7s-0001IE-VY
 for kexec@lists.infradead.org; Mon, 01 Sep 2014 03:17:53 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 7/8] implement a function to print the memory usage
Date: Mon,  1 Sep 2014 11:15:39 +0800
Message-Id: <1409541340-2719-8-git-send-email-bhe@redhat.com>
In-Reply-To: <1409541340-2719-1-git-send-email-bhe@redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

Introduce print_mem_usage to print the result of analysis of /proc/kcore.
The page number of memory in different use are printed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a511179..c3d45de 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7939,6 +7939,40 @@ print_report(void)
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
+	MSG("\n");
+	MSG("----------------------------------------------------------------------\n");
+	MSG("TYPE		PAGES			EXCLUDABLE	DESCRIPTION\n");
+
+	MSG("ZERO		%-16llu	yes		Pages filled with zero\n", pfn_zero);
+	MSG("CACHE		%-16llu	yes		Cache pages\n", pfn_cache);
+	MSG("CACHE_PRIVATE	%-16llu	yes		Cache pages + private\n",
+	    pfn_cache_private);
+	MSG("USER		%-16llu	yes		User process pages\n", pfn_user);
+	MSG("FREE		%-16llu	yes		Free pages\n", pfn_free);
+	MSG("KERN_DATA	%-16llu	no		Dumpable kernel data \n",
+	    pfn_original - pfn_excluded);
+
+	MSG("\n");
+
+	MSG("Total pages on system:	%-16llu\n", pfn_original);
+}
+
 int
 writeout_dumpfile(void)
 {
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
