Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpaR-0006pZ-Ms
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:35:36 +0000
Received: by mail-pb0-f54.google.com with SMTP id rr4so1252838pbb.27
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:35:34 -0700 (PDT)
Message-ID: <5140B8DE.1000701@gmail.com>
Date: Thu, 14 Mar 2013 01:35:26 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 13/13] kexec: x86_64: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could be more clear.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/x86_64/kexec-bzImage64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index 1496573..86e6d13 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -197,7 +197,7 @@ static int do_bzImage64_load(struct kexec_info *info,
 	k_size = kernel_len - kern16_size;
 	/* need to use run-time size for buffer searching */
 	dbgprintf("kernel init_size 0x%x\n", real_mode->init_size);
-	size = (real_mode->init_size + (4096 - 1)) & ~(4096 - 1);
+	size = _ALIGN(real_mode->init_size, 4096);
 	align = real_mode->kernel_alignment;
 	addr = add_buffer(info, kernel + kern16_size, k_size,
 			  size, align, 0x100000, -1, -1);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
