Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYtC9-0000xm-5m
 for kexec@lists.infradead.org; Wed, 13 May 2020 15:21:22 +0000
Received: by mail-pj1-f68.google.com with SMTP id a5so11247473pjh.2
 for <kexec@lists.infradead.org>; Wed, 13 May 2020 08:21:16 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/3] security: add symbol namespace for reading file data
Date: Wed, 13 May 2020 15:21:07 +0000
Message-Id: <20200513152108.25669-3-mcgrof@kernel.org>
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

Certain symbols are not meant to be used by everybody, the security
helpers for reading files directly is one such case. Use a symbol
namespace for them.

This will prevent abuse of use of these symbols in places they were
not inteded to be used, and provides an easy way to audit where these
types of operations happen as a whole.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c | 1 +
 fs/exec.c                               | 2 ++
 kernel/kexec.c                          | 2 ++
 kernel/module.c                         | 2 ++
 security/security.c                     | 6 +++---
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index d9ac7296205e..b088886dafda 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -19,6 +19,7 @@
  */
 
 MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);
+MODULE_IMPORT_NS(SECURITY_READ);
 
 extern struct firmware_fallback_config fw_fallback_config;
 
diff --git a/fs/exec.c b/fs/exec.c
index 9791b9eef9ce..30bd800ab1d6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -72,6 +72,8 @@
 
 #include <trace/events/sched.h>
 
+MODULE_IMPORT_NS(SECURITY_READ);
+
 int suid_dumpable = 0;
 
 static LIST_HEAD(formats);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index f977786fe498..8d572b41a157 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -19,6 +19,8 @@
 
 #include "kexec_internal.h"
 
+MODULE_IMPORT_NS(SECURITY_READ);
+
 static int copy_user_segment_list(struct kimage *image,
 				  unsigned long nr_segments,
 				  struct kexec_segment __user *segments)
diff --git a/kernel/module.c b/kernel/module.c
index 80faaf2116dd..8973a463712e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -59,6 +59,8 @@
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
+MODULE_IMPORT_NS(SECURITY_READ);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
diff --git a/security/security.c b/security/security.c
index 8ae66e4c370f..bdbd1fc5105a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1654,7 +1654,7 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
 		return ret;
 	return ima_read_file(file, id);
 }
-EXPORT_SYMBOL_GPL(security_kernel_read_file);
+EXPORT_SYMBOL_NS_GPL(security_kernel_read_file, SECURITY_READ);
 
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
@@ -1666,7 +1666,7 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 		return ret;
 	return ima_post_read_file(file, buf, size, id);
 }
-EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
+EXPORT_SYMBOL_NS_GPL(security_kernel_post_read_file, SECURITY_READ);
 
 int security_kernel_load_data(enum kernel_load_data_id id)
 {
@@ -1677,7 +1677,7 @@ int security_kernel_load_data(enum kernel_load_data_id id)
 		return ret;
 	return ima_load_data(id);
 }
-EXPORT_SYMBOL_GPL(security_kernel_load_data);
+EXPORT_SYMBOL_NS_GPL(security_kernel_load_data, SECURITY_READ);
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
