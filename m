Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RT5jj-0007DM-F9
 for kexec@lists.infradead.org; Wed, 23 Nov 2011 05:51:13 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
 by song.cn.fujitsu.com (Postfix) with ESMTP id DA1B2170129
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 13:50:46 +0800 (CST)
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
 by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id pAN5oj2Q026250
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 13:50:46 +0800
Message-ID: <4ECC8A6F.3040606@cn.fujitsu.com>
Date: Wed, 23 Nov 2011 13:53:51 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] makedumpfile: fix off-by-one bug in page_to_pfn()
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

The pfn region in a mmd is [mmd->pfn_start, mmd->pfn_end).
So the max index should be mmd->pfn_end - mmd->pfn_start -1.
If index >=(not >) mmd->pfn_end - mmd->pfn_start, we should check
the next mmd.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>

---
 makedumpfile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7b7c266..db8e53f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2879,7 +2879,7 @@ page_to_pfn(unsigned long page)
 		if (page < mmd->mem_map)
 			continue;
 		index = (page - mmd->mem_map) / SIZE(page);
-		if (index > mmd->pfn_end - mmd->pfn_start)
+		if (index >= mmd->pfn_end - mmd->pfn_start)
 			continue;
 		pfn = mmd->pfn_start + index;
 		break;
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
