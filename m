Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V6zNh-0000Co-B0
 for kexec@lists.infradead.org; Wed, 07 Aug 2013 08:46:10 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] kexec: remove unnecessary return
Date: Wed,  7 Aug 2013 17:45:36 +0900
Message-Id: <1375865136-21006-1-git-send-email-horms@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Xishi Qiu <qiuxishi@huawei.com>

From: Xishi Qiu <qiuxishi@huawei.com>

Code can not run here forever, so remove the unnecessary return.

Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
Suggested-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kernel/kexec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Andrew, could you consider picking up this patch?

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 59f7b55..2a74f30 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1474,11 +1474,8 @@ static int __init __parse_crashkernel(char *cmdline,
 	if (first_colon && (!first_space || first_colon < first_space))
 		return parse_crashkernel_mem(ck_cmdline, system_ram,
 				crash_size, crash_base);
-	else
-		return parse_crashkernel_simple(ck_cmdline, crash_size,
-				crash_base);
 
-	return 0;
+	return parse_crashkernel_simple(ck_cmdline, crash_size, crash_base);
 }
 
 /*
-- 
1.8.3.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
