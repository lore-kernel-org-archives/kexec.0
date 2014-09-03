Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XP6ec-0000eO-Je
 for kexec@lists.infradead.org; Wed, 03 Sep 2014 09:15:03 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] message printing cleanup for option --mem-usage
Date: Wed,  3 Sep 2014 17:13:08 +0800
Message-Id: <1409735588-2430-2-git-send-email-bhe@redhat.com>
In-Reply-To: <1409735588-2430-1-git-send-email-bhe@redhat.com>
References: <1409735588-2430-1-git-send-email-bhe@redhat.com>
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

Adjust the message printing when specify option --mem-usage. Try to
avoid the unrelated printing.

And add the page size info.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index c965745..f804079 100644
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
@@ -7960,9 +7963,8 @@ print_mem_usage(void)
 	shrinking = shrinking / pfn_original;
 
 	MSG("\n");
-	MSG("\n");
-	MSG("----------------------------------------------------------------------\n");
 	MSG("TYPE		PAGES			EXCLUDABLE	DESCRIPTION\n");
+	MSG("----------------------------------------------------------------------\n");
 
 	MSG("ZERO		%-16llu	yes		Pages filled with zero\n", pfn_zero);
 	MSG("CACHE		%-16llu	yes		Cache pages\n", pfn_cache);
@@ -7975,6 +7977,7 @@ print_mem_usage(void)
 
 	MSG("\n");
 
+	MSG("page size:		%-16ld\n", info->page_size);
 	MSG("Total pages on system:	%-16llu\n", pfn_original);
 }
 
@@ -9614,10 +9617,10 @@ main(int argc, char *argv[])
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
