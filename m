Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WehEz-0005zX-U1
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 08:48:46 +0000
From: Arthur Zou <zzou@redhat.com>
Subject: [PATCH v2] Fix free bitmap_buffer_cyclic error
Date: Mon, 28 Apr 2014 16:48:19 +0800
Message-Id: <1398674899-1308-1-git-send-email-zzou@redhat.com>
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
Cc: Arthur Zou <zzou@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp

Description:
In create_dump_bitmap() and write_kdump_pages_and_bitmap_cyclic(),
What should be freed is info->partial_bitmap instead of info->bitmap.

Solution:
Add two functions to free the bitmap_buffer_cyclic. info->partial_bitmap1
is freed by free_bitmap1_buffer_cyclic(). info->partial_bitmap2 is
freed by free_bitmap2_buffer_cyclic(). At the same time, remove
thoes frees that free partial_bitmap1 or partial_bitmap2 at the end
of main() because partial_bitmap1 and partial_bitmap2 has been freed
at the end of write_kdump_pages_and_bitmap_cyclic(), so there is no
need to free it again at the end of main.

Signed-off-by: Arthur Zou <zzou@redhat.com>
---
 makedumpfile.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0b31932..5ca0021 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5130,6 +5130,22 @@ free_bitmap_buffer(void)
 	free_bitmap2_buffer();
 }
 
+void free_bitmap1_buffer_cyclic()
+{
+	if (info->partial_bitmap1 != NULL){
+		free(info->partial_bitmap1);
+		info->partial_bitmap1 = NULL;
+	}
+}
+
+void free_bitmap2_buffer_cyclic()
+{
+	if (info->partial_bitmap2 != NULL){
+		free(info->partial_bitmap2);
+		info->partial_bitmap2 = NULL;
+	}
+}
+
 int
 create_dump_bitmap(void)
 {
@@ -5147,8 +5163,7 @@ create_dump_bitmap(void)
 				goto out;
 
 			info->num_dumpable = get_num_dumpable_cyclic();
-
-			free_bitmap2_buffer();
+			free_bitmap2_buffer_cyclic();
 		}
 
 	} else {
@@ -6947,7 +6962,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	}
 
 
-	free_bitmap1_buffer();
+	free_bitmap1_buffer_cyclic();
 
 	if (!prepare_bitmap2_buffer_cyclic())
 		return FALSE;
@@ -6970,7 +6985,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 			return FALSE;
 	}
 
-
+	free_bitmap2_buffer_cyclic();
 
 	gettimeofday(&tv_start, NULL);
 
@@ -9349,10 +9364,6 @@ out:
 			free(info->splitting_info);
 		if (info->p2m_mfn_frame_list != NULL)
 			free(info->p2m_mfn_frame_list);
-		if (info->partial_bitmap1 != NULL)
-			free(info->partial_bitmap1);
-		if (info->partial_bitmap2 != NULL)
-			free(info->partial_bitmap2);
 		free(info);
 	}
 	free_elf_info();
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
