Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.perches.com ([173.55.12.10])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MubqA-00017e-6S
	for kexec@lists.infradead.org; Mon, 05 Oct 2009 00:54:19 +0000
From: Joe Perches <joe@perches.com>
Subject: [PATCH 16/21] kernel/kexec.c: use pr_<level> and add pr_fmt(fmt)
Date: Sun,  4 Oct 2009 17:53:43 -0700
Message-Id: <40ffa7c5595f4afbba793919b397b5139cde901a.1254701151.git.joe@perches.com>
In-Reply-To: <cover.1254701151.git.joe@perches.com>
References: <cover.1254701151.git.joe@perches.com>
In-Reply-To: <cover.1254701151.git.joe@perches.com>
References: <cover.1254701151.git.joe@perches.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

Added #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
Converted printk(KERN_<level> to pr_<level>(
Added KERN_ERR to allocation failure message

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/kexec.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index f336e21..e805351 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -6,6 +6,8 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
@@ -245,13 +247,13 @@ static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
 	image->control_code_page = kimage_alloc_control_pages(image,
 					   get_order(KEXEC_CONTROL_PAGE_SIZE));
 	if (!image->control_code_page) {
-		printk(KERN_ERR "Could not allocate control_code_buffer\n");
+		pr_err("Could not allocate control_code_buffer\n");
 		goto out;
 	}
 
 	image->swap_page = kimage_alloc_control_pages(image, 0);
 	if (!image->swap_page) {
-		printk(KERN_ERR "Could not allocate swap buffer\n");
+		pr_err("Could not allocate swap buffer\n");
 		goto out;
 	}
 
@@ -320,7 +322,7 @@ static int kimage_crash_alloc(struct kimage **rimage, unsigned long entry,
 	image->control_code_page = kimage_alloc_control_pages(image,
 					   get_order(KEXEC_CONTROL_PAGE_SIZE));
 	if (!image->control_code_page) {
-		printk(KERN_ERR "Could not allocate control_code_buffer\n");
+		pr_err("Could not allocate control_code_buffer\n");
 		goto out;
 	}
 
@@ -1141,8 +1143,7 @@ static int __init crash_notes_memory_init(void)
 	/* Allocate memory for saving cpu registers. */
 	crash_notes = alloc_percpu(note_buf_t);
 	if (!crash_notes) {
-		printk("Kexec: Memory allocation for saving cpu register"
-		" states failed\n");
+		pr_err("Memory allocation for saving cpu register states failed\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -1192,8 +1193,7 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 		if (*cur != ':') {
 			end = memparse(cur, &tmp);
 			if (cur == tmp) {
-				pr_warning("crashkernel: Memory "
-						"value expected\n");
+				pr_warning("crashkernel: Memory value expected\n");
 				return -EINVAL;
 			}
 			cur = tmp;
@@ -1211,7 +1211,7 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 
 		size = memparse(cur, &tmp);
 		if (cur == tmp) {
-			pr_warning("Memory value expected\n");
+			pr_warning("crashkernel: Memory value expected\n");
 			return -EINVAL;
 		}
 		cur = tmp;
@@ -1234,8 +1234,7 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 			cur++;
 			*crash_base = memparse(cur, &tmp);
 			if (cur == tmp) {
-				pr_warning("Memory value expected "
-						"after '@'\n");
+				pr_warning("crashkernel: Memory value expected after '@'\n");
 				return -EINVAL;
 			}
 		}
@@ -1473,7 +1472,7 @@ int kernel_kexec(void)
 #endif
 	{
 		kernel_restart_prepare(NULL);
-		printk(KERN_EMERG "Starting new kernel\n");
+		pr_emerg("Starting new kernel\n");
 		machine_shutdown();
 	}
 
-- 
1.6.3.1.10.g659a0.dirty


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
