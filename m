Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDO7u-0002sS-Ck
 for kexec@lists.infradead.org; Fri, 10 Jul 2015 02:33:22 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6A2V94L010652
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 10:31:09 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 2/4] Add get_pfn_offset
Date: Fri, 10 Jul 2015 10:28:51 +0800
Message-ID: <1436495333-22892-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

get_pfn_offset is used for generating incomplete kdump core.
When enospac occurs in writing the buf cd_page, it can be used to
get how many pages have been written.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5a53246..e8b52f4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6300,6 +6300,30 @@ write_cd_buf(struct cache_data *cd)
 }
 
 int
+get_pfn_offset(void *buf, struct cache_data *cd_page){
+	int size, file_end, offset;
+	page_desc_t *pd;
+
+	size = 0;
+	offset = 0;
+	file_end = lseek(cd_page->fd, 0, SEEK_END);
+	if (file_end < 0)
+		ERRMSG("Can't seek end of the dump file(%s).\n", cd_page->file_name);
+
+	while (TRUE) {
+		pd = (page_desc_t *)buf;
+		size += pd->size;
+		if (size > file_end - cd_page->offset)
+			break;
+
+		offset++;
+		buf += sizeof(page_desc_t);
+	}
+
+	return offset;
+}
+
+int
 write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
 			 struct page_desc *pd_zero, off_t *offset_data, struct cycle *cycle)
 {
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
