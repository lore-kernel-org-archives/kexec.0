Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTiFE-0004MJ-KG
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 03:16:24 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id CCE2751
 for <kexec@lists.infradead.org>; Mon, 24 Aug 2015 03:16:06 +0000 (UTC)
From: Chao Fan <cfan@redhat.com>
Subject: [PATCH] sadump_info.c: unsigned_compare: This less-than-zero
 comparison of an unsigned value is never true.
Date: Mon, 24 Aug 2015 11:15:53 +0800
Message-Id: <1440386153-21638-3-git-send-email-cfan@redhat.com>
In-Reply-To: <1440386153-21638-1-git-send-email-cfan@redhat.com>
References: <1440386153-21638-1-git-send-email-cfan@redhat.com>
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
Cc: Chao Fan <cfan@redhat.com>

In sadump_info.c:432: unsigned long block_size =
SADUMP_DEFAULT_BLOCK_SIZE.
So block_size is unsigned long value and it is bigger than zero.
And this comparison is useful.

Signed-off-by: Chao Fan <cfan@redhat.com>
---
 sadump_info.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sadump_info.c b/sadump_info.c
index e2c4f03..e8154f4 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -465,9 +465,6 @@ read_sadump_header(char *filename)
 	smh = si->smh_memory;
 
 restart:
-	if (block_size < 0)
-		return FALSE;
-
 	if (!read_device(sph, block_size, &offset))
 		return ERROR;
 
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
