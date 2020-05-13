Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYtC9-0000xp-E9
 for kexec@lists.infradead.org; Wed, 13 May 2020 15:21:22 +0000
Received: by mail-pf1-f193.google.com with SMTP id y25so8140897pfn.5
 for <kexec@lists.infradead.org>; Wed, 13 May 2020 08:21:17 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/3] fs: move kernel_read*() calls to its own symbol namespace
Date: Wed, 13 May 2020 15:21:08 +0000
Message-Id: <20200513152108.25669-4-mcgrof@kernel.org>
In-Reply-To: <20200513152108.25669-1-mcgrof@kernel.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
To: viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com, stephen.smalley.work@gmail.com, eparis@parisplace.org, nayna@linux.ibm.com, zohar@linux.ibm.com
Cc: scott.branden@broadcom.com, selinux@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, geert@linux-m68k.org, dan.carpenter@oracle.com, skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org, tglx@linutronix.de, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/main.c | 1 +
 fs/exec.c                           | 6 +++---
 kernel/kexec_file.c                 | 2 ++
 kernel/module.c                     | 1 +
 security/integrity/digsig.c         | 3 +++
 security/integrity/ima/ima_fs.c     | 3 +++
 security/integrity/ima/ima_main.c   | 2 ++
 security/loadpin/loadpin.c          | 2 ++
 security/security.c                 | 2 ++
 security/selinux/hooks.c            | 2 ++
 10 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 5296aaca35cf..a5ed796a9166 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -44,6 +44,7 @@
 MODULE_AUTHOR("Manuel Estrada Sainz");
 MODULE_DESCRIPTION("Multi purpose firmware loading support");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CORE_FS_READ);
 
 struct firmware_cache {
 	/* firmware_buf instance will be added into the below list */
diff --git a/fs/exec.c b/fs/exec.c
index 30bd800ab1d6..bbe2a35ea2e0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1008,7 +1008,7 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	fput(file);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
+EXPORT_SYMBOL_NS_GPL(kernel_read_file_from_path, CORE_FS_READ);
 
 int kernel_read_file_from_path_initns(const char *path, void **buf,
 				      loff_t *size, loff_t max_size,
@@ -1034,7 +1034,7 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	fput(file);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
+EXPORT_SYMBOL_NS_GPL(kernel_read_file_from_path_initns, CORE_FS_READ);
 
 int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 			     enum kernel_read_file_id id)
@@ -1050,7 +1050,7 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	fdput(f);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
+EXPORT_SYMBOL_NS_GPL(kernel_read_file_from_fd, CORE_FS_READ);
 
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bb05fd52de85..d96b7c05b0a5 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -28,6 +28,8 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+MODULE_IMPORT_NS(CORE_FS_READ);
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /*
diff --git a/kernel/module.c b/kernel/module.c
index 8973a463712e..f14868980080 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -60,6 +60,7 @@
 #include "module-internal.h"
 
 MODULE_IMPORT_NS(SECURITY_READ);
+MODULE_IMPORT_NS(CORE_FS_READ);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e9cbadade74b..d68ef41a3987 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -13,11 +13,14 @@
 #include <linux/key-type.h>
 #include <linux/digsig.h>
 #include <linux/vmalloc.h>
+#include <linux/module.h>
 #include <crypto/public_key.h>
 #include <keys/system_keyring.h>
 
 #include "integrity.h"
 
+MODULE_IMPORT_NS(CORE_FS_READ);
+
 static struct key *keyring[INTEGRITY_KEYRING_MAX];
 
 static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e3fcad871861..41fd03281ae1 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -20,6 +20,9 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/module.h>
+
+MODULE_IMPORT_NS(CORE_FS_READ);
 
 #include "ima.h"
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f96f151294e6..ffa7a14deef1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -28,6 +28,8 @@
 
 #include "ima.h"
 
+MODULE_IMPORT_NS(CORE_FS_READ);
+
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
 #else
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ee5cb944f4ad..ca2022ad5f88 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -17,6 +17,8 @@
 #include <linux/sched.h>	/* current */
 #include <linux/string_helpers.h>
 
+MODULE_IMPORT_NS(CORE_FS_READ);
+
 static void report_load(const char *origin, struct file *file, char *operation)
 {
 	char *cmdline, *pathname;
diff --git a/security/security.c b/security/security.c
index bdbd1fc5105a..c865f1de4b03 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,8 @@
 #include <linux/msg.h>
 #include <net/flow.h>
 
+MODULE_IMPORT_NS(CORE_FS_READ);
+
 #define MAX_LSM_EVM_XATTR	2
 
 /* How many LSMs were built into the kernel? */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9979b45e0a34..6dc4abfbfb78 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -103,6 +103,8 @@
 #include "audit.h"
 #include "avc_ss.h"
 
+MODULE_IMPORT_NS(CORE_FS_READ);
+
 struct selinux_state selinux_state;
 
 /* SECMARK reference count */
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
