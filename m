Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9h4h-000364-KP
 for kexec@lists.infradead.org; Mon, 16 Sep 2019 02:49:12 +0000
Received: by mail-pl1-x643.google.com with SMTP id bd8so16185276plb.6
 for <kexec@lists.infradead.org>; Sun, 15 Sep 2019 19:49:10 -0700 (PDT)
From: quanyang.w@gmail.com
Subject: [PATCH] kexec/arm: undefine __NR_kexec_file_load for arm
Date: Mon, 16 Sep 2019 10:49:05 +0800
Message-Id: <20190916024905.3100-1-quanyang.w@gmail.com>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

From: Quanyang Wang <quanyang.wang@windriver.com>

In the kernel upstream commit 4ab65ba7a5cb
("ARM: add kexec_file_load system call number"),
__NR_kexec_file_load for arm has been defined to be 401.
This results that even if kexec_file_load isn't implemented
for arm but the function is_kexec_file_load_implemented()
will still return true. So undef __NR_kexec_file_load for
arm architecture.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 kexec/kexec-syscall.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index dac1c1f..92d51d3 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -56,6 +56,10 @@
 #endif
 #endif /*ifndef __NR_kexec_load*/
 
+#ifdef __arm__
+#undef __NR_kexec_file_load
+#endif
+
 #ifndef __NR_kexec_file_load
 
 #ifdef __x86_64__
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
