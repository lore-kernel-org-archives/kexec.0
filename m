Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T55x9-0003me-Ti
 for kexec@lists.infradead.org; Sat, 25 Aug 2012 02:18:26 +0000
Received: by qcsu28 with SMTP id u28so1662981qcs.36
 for <kexec@lists.infradead.org>; Fri, 24 Aug 2012 19:18:20 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 25 Aug 2012 10:18:20 +0800
Message-ID: <CAPgLHd_ndLkDD7Q1WyqHifMYek9U3-cY0xrNdWfu+tfiDtiHdw@mail.gmail.com>
Subject: [PATCH] kdump: remove unused including <generated/utsrelease.h>
From: Wei Yongjun <weiyj.lk@gmail.com>
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
To: ebiederm@xmission.com
Cc: yongjun_wei@trendmicro.com.cn, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>


Remove including <generated/utsrelease.h> that don't need it.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 kernel/kexec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 0668d58..5e4bd78 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -21,7 +21,6 @@
 #include <linux/hardirq.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
-#include <generated/utsrelease.h>
 #include <linux/utsname.h>
 #include <linux/numa.h>
 #include <linux/suspend.h>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
