Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z813p-0007Iw-JA
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 06:54:58 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5P6qrjQ011625
 for <kexec@lists.infradead.org>; Thu, 25 Jun 2015 14:52:53 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] makedumpfile: Delete useless codes
Date: Thu, 25 Jun 2015 14:51:01 +0800
Message-ID: <1435215062-31333-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>

From: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>

free_bitmap_buffer() in create_dump_bitmap() includes free_bitmap2_buffer().
So delete free_bitmap2_buffer().

Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index cc71f20..7f2949c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5933,9 +5933,6 @@ create_dump_bitmap(void)
 
 		info->num_dumpable = get_num_dumpable_cyclic();
 
-		if (!info->flag_elf_dumpfile)
-			free_bitmap2_buffer();
-
 	} else {
 		struct cycle cycle = {0};
 		first_cycle(0, info->max_mapnr, &cycle);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
