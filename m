Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYV53-0006Zm-HZ
 for kexec@lists.infradead.org; Mon, 29 Sep 2014 07:09:09 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8T78ORQ024425
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 15:08:24 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 2/5] makedumpfile: Add tools for reading and writing from
 block table
Date: Mon, 29 Sep 2014 15:06:24 +0800
Message-ID: <1411974387-10839-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1411974387-10839-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1411974387-10839-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

The function added in this patch, is used for writing and reading value
from the char array in struct Block.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 2feda01..a4cb9b6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5708,6 +5708,29 @@ calculate_entry_size(void){
 	return entry_size;
 }
 
+void
+write_value_into_block_table(char *block_inner, unsigned long long content)
+{
+	char temp;
+	int i=0;
+	while (i++ < block->entry_size) {
+		temp = content & 0xff;
+		content = content >> BITPERBYTE;
+		*block_inner++ = temp;
+	}
+}
+unsigned long long
+read_value_from_block_table(char *block_inner)
+{
+	unsigned long long ret = 0;
+	int i;
+	for (i = block->entry_size; i > 0; i--) {
+		ret = ret << BITPERBYTE;
+		ret += *(block_inner + i - 1) & 0xff;
+	}
+	return ret;
+}
+
 mdf_pfn_t
 get_num_dumpable(void)
 {
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
