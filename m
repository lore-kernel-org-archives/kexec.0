Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V7hSz-0005Ds-Hj
 for kexec@lists.infradead.org; Fri, 09 Aug 2013 07:50:35 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: [PATCH] kexec: Disable at runtime if the kernel enforces module
 signing
Date: Fri,  9 Aug 2013 03:36:37 -0400
Message-Id: <1376033797-24970-1-git-send-email-matthew.garrett@nebula.com>
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
To: ebiederm@xmission.com
Cc: Matthew Garrett <matthew.garrett@nebula.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

kexec permits the loading and execution of arbitrary code in ring 0, which
is something that module signing enforcement is meant to prevent. It makes
sense to disable kexec in this situation.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
---
 include/linux/module.h |  4 ++++
 kernel/kexec.c         | 10 ++++++++++
 kernel/module.c        |  4 ++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 46f1ea0..2871ab2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -29,6 +29,10 @@
 
 #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
 
+#ifdef CONFIG_MODULE_SIG
+extern bool sig_enforce;
+#endif
+
 struct modversion_info
 {
 	unsigned long crc;
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 59f7b55..297a268a 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -32,6 +32,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
 #include <linux/syscore_ops.h>
+#include <linux/module.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -1645,6 +1646,15 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+#ifdef CONFIG_MODULE_SIG
+	/*
+	 * Kexec makes it trivial to evade module signing, so forbid it when
+	 * the kernel requires signatures
+	 */
+	if (sig_enforce)
+		return -EPERM;
+#endif
+
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
 		lock_system_sleep();
diff --git a/kernel/module.c b/kernel/module.c
index 2069158..58f6e21 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -109,9 +109,9 @@ struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
 
 #ifdef CONFIG_MODULE_SIG
 #ifdef CONFIG_MODULE_SIG_FORCE
-static bool sig_enforce = true;
+bool sig_enforce = true;
 #else
-static bool sig_enforce = false;
+bool sig_enforce = false;
 
 static int param_set_bool_enable_only(const char *val,
 				      const struct kernel_param *kp)
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
