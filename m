Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEp3d-0001tm-NA
 for kexec@lists.infradead.org; Wed, 24 Feb 2021 07:58:07 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH] MIPS: Fix typo in comment
Date: Wed, 24 Feb 2021 15:57:57 +0800
Message-Id: <1614153477-13893-1-git-send-email-tangyouling@loongson.cn>
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
To: Simon Horman <horms@verge.net.au>
Cc: tangyouling@loongson.cn, kexec@lists.infradead.org

Fix typo in comment.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/arch/mips/kexec-mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index a9c6a09..5866e24 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
  * Copyright (C) 2007 Tvblob s.r.l.
  *
- * derived from ../ppc/kexec-mips.c
+ * derived from ../ppc/kexec-ppc.c
  * Copyright (C) 2004, 2005 Albert Herranz
  *
  * This source code is licensed under the GNU General Public License,
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
