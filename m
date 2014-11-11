Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xo7ES-0005LY-NU
 for kexec@lists.infradead.org; Tue, 11 Nov 2014 08:55:25 +0000
From: Minfei Huang <mhuang@redhat.com>
Subject: [PATCH] makedumpfile: Fix the variable pfn_needed leaking
Date: Tue, 11 Nov 2014 16:54:39 +0800
Message-Id: <1415696079-29701-1-git-send-email-mhuang@redhat.com>
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
Cc: Minfei Huang <mhuang@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp

If the page pfn calculated by read_from_splitblock_table is bigger than
pfn_needed, the variable pfn_needed will leak.

makedumpfile cannot assign the pfn averagely bacause of condition
pfn_needed invalid.

Signed-off-by: Minfei Huang <mhuang@redhat.com>
---
 makedumpfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 59c4952..8807a90 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8415,7 +8415,7 @@ calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
 		return info->max_mapnr;
 
 	mdf_pfn_t end_pfn;
-	long long pfn_needed, offset;
+	long long pfn_needed, offset, per_splitblock_pfn;
 	char *splitblock_value_offset;
 
 	pfn_needed = info->num_dumpable / info->num_dumpfile;
@@ -8424,7 +8424,8 @@ calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
 	end_pfn = start_pfn;
 
 	while (*cur_splitblock_num < splitblock->num && pfn_needed > 0) {
-		pfn_needed -= read_from_splitblock_table(splitblock_value_offset);
+		per_splitblock_pfn = read_from_splitblock_table(splitblock_value_offset); 
+		pfn_needed = pfn_needed < per_splitblock_pfn ? 0 : pfn_needed - per_splitblock_pfn;
 		splitblock_value_offset += splitblock->entry_size;
 		++*cur_splitblock_num;
 	}
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
