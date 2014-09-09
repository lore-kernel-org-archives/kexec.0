Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XRC6J-0001rT-IP
 for kexec@lists.infradead.org; Tue, 09 Sep 2014 03:28:16 +0000
Date: Tue, 9 Sep 2014 11:26:24 +0800
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/2] message printing cleanup for option --mem-usage
Message-ID: <20140909032624.GA1229@dhcp-16-105.nay.redhat.com>
References: <1409735588-2430-1-git-send-email-bhe@redhat.com>
 <1409735588-2430-2-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409735588-2430-2-git-send-email-bhe@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, vgoyal@redhat.com

Adjust the message printing when specify option --mem-usage. Try to
avoid the unrelated printing.

And add the page size info and the total size of system memory on byte.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index c965745..8667791 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4939,7 +4939,8 @@ exclude_unnecessary_pages_cyclic(struct cycle *cycle)
 
 		for (mm = 0; mm < info->num_mem_map; mm++) {
 
-			print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
+			if (!info->flag_mem_usage)
+				print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
 
 			mmd = &info->mem_map_data[mm];
 
@@ -4957,8 +4958,10 @@ exclude_unnecessary_pages_cyclic(struct cycle *cycle)
 		/*
 		 * print [100 %]
 		 */
-		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
-		print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
+		if (!info->flag_mem_usage) {
+			print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
+			print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
+		}
 	}
 
 	return TRUE;
@@ -7948,6 +7951,7 @@ static void
 print_mem_usage(void)
 {
 	mdf_pfn_t pfn_original, pfn_excluded, shrinking;
+	unsigned long long total_size;
 
 	/*
 	* /proc/vmcore doesn't contain the memory hole area.
@@ -7958,11 +7962,11 @@ print_mem_usage(void)
 	    + pfn_user + pfn_free + pfn_hwpoison;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
+	total_size = info->page_size * pfn_original;
 
 	MSG("\n");
-	MSG("\n");
-	MSG("----------------------------------------------------------------------\n");
 	MSG("TYPE		PAGES			EXCLUDABLE	DESCRIPTION\n");
+	MSG("----------------------------------------------------------------------\n");
 
 	MSG("ZERO		%-16llu	yes		Pages filled with zero\n", pfn_zero);
 	MSG("CACHE		%-16llu	yes		Cache pages\n", pfn_cache);
@@ -7975,7 +7979,9 @@ print_mem_usage(void)
 
 	MSG("\n");
 
+	MSG("page size:		%-16ld\n", info->page_size);
 	MSG("Total pages on system:	%-16llu\n", pfn_original);
+	MSG("Total size on system:	%-16llu Byte\n", total_size);
 }
 
 int
@@ -9614,10 +9620,10 @@ main(int argc, char *argv[])
 	retcd = COMPLETED;
 out:
 	MSG("\n");
-	if (retcd == COMPLETED)
-		MSG("makedumpfile Completed.\n");
-	else
+	if (retcd != COMPLETED)
 		MSG("makedumpfile Failed.\n");
+	else if (!info->flag_mem_usage)
+		MSG("makedumpfile Completed.\n");
 
 	if (info) {
 		if (info->dh_memory)
-- 
1.8.5.3



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
