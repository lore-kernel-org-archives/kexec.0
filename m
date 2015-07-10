Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDO7u-0002sO-SV
 for kexec@lists.infradead.org; Fri, 10 Jul 2015 02:33:23 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6A2VBX7010661
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 10:31:11 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 4/4] Use write_kdump_page instead of write_cache in
 write_kdump_pages_cyclic
Date: Fri, 10 Jul 2015 10:28:53 +0800
Message-ID: <1436495333-22892-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
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

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 74bf83e..0f1aa94 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6515,17 +6515,11 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		pd.offset     = *offset_data;
 		*offset_data  += pd.size;
 
-                /*
-                 * Write the page header.
-                 */
-                if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
-                        goto out;
-
-                /*
-                 * Write the page data.
-                 */
-		if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
-                        goto out;
+               /*
+                * Write the page header and the page data
+                */
+               if (!write_kdump_page(cd_header, cd_page, &pd, pd.flags ? buf_out : buf))
+                       goto out;
         }
 
 	ret = TRUE;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
