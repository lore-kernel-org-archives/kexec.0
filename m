Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgFX6-0001Ql-JP
 for kexec@lists.infradead.org; Sat, 25 May 2013 14:33:21 +0000
Received: by mail-pd0-f182.google.com with SMTP id g10so5113114pdj.41
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 07:32:59 -0700 (PDT)
Message-ID: <51A0CB91.3090607@gmail.com>
Date: Sat, 25 May 2013 22:32:49 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] kexec/s390: cleanup: Fix a mistaken comment
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

When borrowing codes from ia64 architecture, this comment was
forgotten to be change. So fix it.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/s390/kexec-s390.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
index ee62888..ef53b11 100644
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -34,4 +34,4 @@ extern int get_memory_ranges_s390(struct memory_range range[], int *ranges,
 				  int with_crashk);
 extern int command_line_add(const char *str);
 
-#endif /* KEXEC_IA64_H */
+#endif /* KEXEC_S390_H */
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
