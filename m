Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V6cIE-0004vZ-Ka
 for kexec@lists.infradead.org; Tue, 06 Aug 2013 08:07:00 +0000
Message-ID: <5200AE50.2010108@huawei.com>
Date: Tue, 6 Aug 2013 16:05:36 +0800
From: Xishi Qiu <qiuxishi@huawei.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: remove unnecessary return
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
To: ebiederm@xmission.com
Cc: Xishi Qiu <qiuxishi@huawei.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>

Code can not run here forever, so remove the unnecessary return.

Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
---
 kernel/kexec.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 59f7b55..c14e3ea 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1477,8 +1477,6 @@ static int __init __parse_crashkernel(char *cmdline,
 	else
 		return parse_crashkernel_simple(ck_cmdline, crash_size,
 				crash_base);
-
-	return 0;
 }
 
 /*
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
