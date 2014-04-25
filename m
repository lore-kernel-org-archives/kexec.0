Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WdVAp-00085c-7D
 for kexec@lists.infradead.org; Fri, 25 Apr 2014 01:43:31 +0000
From: Arthur Zou <zzou@redhat.com>
Subject: [PATCH] makedumpfile: fix free partial_bitmap2 error
Date: Fri, 25 Apr 2014 09:43:02 +0800
Message-Id: <1398390182-8480-1-git-send-email-zzou@redhat.com>
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
In create_dump_bitmap, after prepare_bitmap2_buffer_cyclic was invoked,
info->partial_bitmap2 will pointed to a block of contiguous memory. But
free it in a wrong way because what free_bitmap2_buffer() free is
info->bitmap2 not info->partial_bitmap2.

Signed-off-by: Arthur Zou <zzou@redhat.com>
---
 makedumpfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ce4a866..f0d2997 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5143,7 +5143,8 @@ create_dump_bitmap(void)
 
 			info->num_dumpable = get_num_dumpable_cyclic();
 
-			free_bitmap2_buffer();
+			if (info->partial_bitmap2 != NULL)
+				free(info->partial_bitmap2);
 		}
 
 	} else {
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
