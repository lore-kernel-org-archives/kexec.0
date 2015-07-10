Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDO7t-0002sS-Df
 for kexec@lists.infradead.org; Fri, 10 Jul 2015 02:33:21 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6A2V8Ow010646
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 10:31:08 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 1/4] Add write_cd_buf
Date: Fri, 10 Jul 2015 10:28:50 +0800
Message-ID: <1436495333-22892-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

write_cd_buf is used to write the data of cache_data into file.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index cc71f20..5a53246 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6286,6 +6286,20 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 }
 
 int
+write_cd_buf(struct cache_data *cd)
+{
+	if (cd->buf_size == 0)
+		return TRUE;
+
+	if (!write_buffer(cd->fd, cd->offset, cd->buf,
+			cd->buf_size, cd->file_name)) {
+		return FALSE;
+	}
+
+	return TRUE;
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
