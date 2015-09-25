Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x234.google.com ([2607:f8b0:400e:c03::234])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZfONe-0006Wm-Cy
 for kexec@lists.infradead.org; Fri, 25 Sep 2015 08:29:22 +0000
Received: by pablk4 with SMTP id lk4so2942342pab.3
 for <kexec@lists.infradead.org>; Fri, 25 Sep 2015 01:29:01 -0700 (PDT)
From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH V3] kexec: Use file name as the output message prefix
Date: Fri, 25 Sep 2015 16:28:53 +0800
Message-Id: <1443169733-20797-1-git-send-email-mnfhuang@gmail.com>
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
To: ebiederm@xmission.com, akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>

kexec output message misses the prefix "kexec", when Dave Young split
the kexec code. Now, we use file name as the output message prefix.

Currently, the format of output message:
[  140.290795] SYSC_kexec_load: hello, world
[  140.291534] kexec: sanity_check_segment_list: hello, world

Ideally, the format of output message:
[   30.791503] kexec: SYSC_kexec_load, Hello, world
[   79.182752] kexec_core: sanity_check_segment_list, Hello, world

Remove the custom prefix "kexec" in output message.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
v3:
- Move the macro to the top of the c file
v2:
- Use KBUILD_MODNAME as prefix, instead of custom string "kexec"
---
 kernel/kexec.c      | 2 ++
 kernel/kexec_core.c | 4 ++--
 kernel/kexec_file.c | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 4c5edc3..d873b64 100644
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
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 201b453..dd21c78 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -6,7 +6,7 @@
  * Version 2.  See the file COPYING for more details.
  */
 
-#define pr_fmt(fmt)	"kexec: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/capability.h>
 #include <linux/mm.h>
@@ -1027,7 +1027,7 @@ static int __init crash_notes_memory_init(void)
 
 	crash_notes = __alloc_percpu(size, align);
 	if (!crash_notes) {
-		pr_warn("Kexec: Memory allocation for saving cpu register states failed\n");
+		pr_warn("Memory allocation for saving cpu register states failed\n");
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 6a9a3f2..b70ada0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -9,6 +9,8 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
