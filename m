Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V6ckb-0005sV-Ud
 for kexec@lists.infradead.org; Tue, 06 Aug 2013 08:36:19 +0000
Message-ID: <5200B534.7000202@huawei.com>
Date: Tue, 6 Aug 2013 16:35:00 +0800
From: Xishi Qiu <qiuxishi@huawei.com>
MIME-Version: 1.0
Subject: [PATCH V2] kexec: remove unnecessary return
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com
Cc: Xishi Qiu <qiuxishi@huawei.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>

Code can not run here forever, so remove the unnecessary return.

Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
Suggested-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kernel/kexec.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

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
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
