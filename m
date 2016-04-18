Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1as1Di-0008Df-9z
 for kexec@lists.infradead.org; Mon, 18 Apr 2016 04:55:35 +0000
Received: by mail-pf0-f175.google.com with SMTP id c20so76645859pfc.1
 for <kexec@lists.infradead.org>; Sun, 17 Apr 2016 21:55:14 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH] makedumpfile: fix module core base and size offset for kernel
 v4.5
Date: Mon, 18 Apr 2016 10:25:09 +0530
Message-Id: <ff5f22b5595d3801e8334a4e6b486838d499edc7.1460955261.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org

Following commit in kernel v4.5 changed struct module, which affects offset
calculation of core layout's base and size.

commit 7523e4dc5057e157212b4741abd6256e03404cf1
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Thu Nov 26 09:44:08 2015 +1030

    module: use a structure to encapsulate layout.

This patch fixes makedumpfile code to cater above kernel modification.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 makedumpfile.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 94c969c16ccc..12227ea1fbd8 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1669,7 +1669,25 @@ get_structure_info(void)
 	OFFSET_INIT(module.list, "module", "list");
 	OFFSET_INIT(module.name, "module", "name");
 	OFFSET_INIT(module.module_core, "module", "module_core");
+	if (OFFSET(module.module_core) == NOT_FOUND_STRUCTURE) {
+		/* for kernel version 4.5 and above */
+		long core_layout;
+
+		OFFSET_INIT(module.module_core, "module", "core_layout");
+		core_layout = OFFSET(module.module_core);
+		OFFSET_INIT(module.module_core, "module_layout", "base");
+		OFFSET(module.module_core) += core_layout;
+	}
 	OFFSET_INIT(module.core_size, "module", "core_size");
+	if (OFFSET(module.core_size) == NOT_FOUND_STRUCTURE) {
+		/* for kernel version 4.5 and above */
+		long core_layout;
+
+		OFFSET_INIT(module.core_size, "module", "core_layout");
+		core_layout = OFFSET(module.core_size);
+		OFFSET_INIT(module.core_size, "module_layout", "size");
+		OFFSET(module.core_size) += core_layout;
+	}
 	OFFSET_INIT(module.module_init, "module", "module_init");
 	OFFSET_INIT(module.init_size, "module", "init_size");
 
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
