Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xdc4Z-0007W1-7b
 for kexec@lists.infradead.org; Mon, 13 Oct 2014 09:37:47 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9D9alWn007501
 for <kexec@lists.infradead.org>; Mon, 13 Oct 2014 17:36:47 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v2 2/5] Add tools for reading and writing from splitblock table
Date: Mon, 13 Oct 2014 17:34:23 +0800
Message-ID: <1413192866-28140-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
from the char array in struct SplitBlock.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 95d553c..a8d86f6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5708,6 +5708,29 @@ calculate_entry_size(void){
 	return entry_size;
 }
 
+void
+write_value_into_splitblock_table(char *splitblock_inner, unsigned long long content)
+{
+	char temp;
+	int i=0;
+	while (i++ < splitblock->entry_size) {
+		temp = content & 0xff;
+		content = content >> BITPERBYTE;
+		*splitblock_inner++ = temp;
+	}
+}
+unsigned long long
+read_value_from_splitblock_table(char *splitblock_inner)
+{
+	unsigned long long ret = 0;
+	int i;
+	for (i = splitblock->entry_size; i > 0; i--) {
+		ret = ret << BITPERBYTE;
+		ret += *(splitblock_inner + i - 1) & 0xff;
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
