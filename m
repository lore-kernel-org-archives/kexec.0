Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7YyS-0006mE-PI
 for kexec@lists.infradead.org; Tue, 10 Sep 2019 05:45:58 +0000
Received: by mail-pf1-x442.google.com with SMTP id w22so10855044pfi.9
 for <kexec@lists.infradead.org>; Mon, 09 Sep 2019 22:45:55 -0700 (PDT)
From: quanyang.w@gmail.com
Subject: [PATCH] kexec/arm: undefine __NR_kexec_file_load for arm
Date: Tue, 10 Sep 2019 13:43:48 +0800
Message-Id: <20190910054348.26503-1-quanyang.w@gmail.com>
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
