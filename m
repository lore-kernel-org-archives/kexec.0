Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com
 ([40.107.223.74] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1O8M-00GAwm-A5
 for kexec@lists.infradead.org; Thu, 08 Jul 2021 07:07:44 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH v2 makedumpfile 1/3] Fix off by one error when checking
 cache_size
Date: Thu, 8 Jul 2021 16:06:09 +0900
Message-ID: <20210708070611.291260-2-bpoirier@nvidia.com>
In-Reply-To: <20210708070611.291260-1-bpoirier@nvidia.com>
References: <20210708070611.291260-1-bpoirier@nvidia.com>
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

Given the test in write_cache():
	if (cd->buf_size < cd->cache_size)
		return TRUE;
a write is done if buf_size == cache_size.
The test at the beginning of write_kdump_page() intends to detect cases
when write_cache() will do a write, however it was missing this boundary
condition. This would lead write_kdump_page() to ignore errors from
write_cache().

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 makedumpfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index fcb571f..aa05be7 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7993,8 +7993,8 @@ write_kdump_page(struct cache_data *cd_header, struct cache_data *cd_page,
 	 * write the buffer cd_header into dumpfile and then write the cd_page.
 	 * With that, when enospc occurs, we can save more useful information.
 	 */
-	if (cd_header->buf_size + sizeof(*pd) > cd_header->cache_size
-		|| cd_page->buf_size + pd->size > cd_page->cache_size){
+	if (cd_header->buf_size + sizeof(*pd) >= cd_header->cache_size ||
+	    cd_page->buf_size + pd->size >= cd_page->cache_size) {
 		if( !write_cd_buf(cd_header) ) {
 			memset(cd_header->buf, 0, cd_header->cache_size);
 			write_cd_buf(cd_header);
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
