Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dbrNO-0004op-Sv
 for kexec@lists.infradead.org; Sun, 30 Jul 2017 16:47:36 +0000
Received: by mail-pf0-f169.google.com with SMTP id q85so112107737pfq.1
 for <kexec@lists.infradead.org>; Sun, 30 Jul 2017 09:47:17 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH] makedumpfile: x86: Take care of init_level4_pgt rename in
 kernel
Date: Sun, 30 Jul 2017 22:11:10 +0530
Message-Id: <b5a4b87480473137478313355b0a6fd9f197f945.1501432848.git.panand@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>

Following commit renamed init_level4_pgt to init_top_pgt in kernel.

commit 65ade2f872b474fa8a04c2d397783350326634e6
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Tue Jun 6 14:31:27 2017 +0300

    x86/boot/64: Rename init_level4_pgt and early_level4_pgt

This patch takes care of above kernel modification in makedumpfile.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 makedumpfile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index f85003a33551..e875f4bb539e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1486,6 +1486,8 @@ get_symbol_info(void)
 	SYMBOL_INIT(_stext, "_stext");
 	SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
 	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
+	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
+		SYMBOL_INIT(init_level4_pgt, "init_top_pgt");
 	SYMBOL_INIT(vmlist, "vmlist");
 	SYMBOL_INIT(vmap_area_list, "vmap_area_list");
 	SYMBOL_INIT(node_online_map, "node_online_map");
@@ -2104,7 +2106,10 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("init_uts_ns", init_uts_ns);
 	WRITE_SYMBOL("_stext", _stext);
 	WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
-	WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
+	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
+		WRITE_SYMBOL("init_top_pgt", init_level4_pgt);
+	else
+		WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
 	WRITE_SYMBOL("vmlist", vmlist);
 	WRITE_SYMBOL("vmap_area_list", vmap_area_list);
 	WRITE_SYMBOL("node_online_map", node_online_map);
@@ -2500,6 +2505,8 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("_stext", _stext);
 	READ_SYMBOL("swapper_pg_dir", swapper_pg_dir);
 	READ_SYMBOL("init_level4_pgt", init_level4_pgt);
+	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
+		READ_SYMBOL("init_top_pgt", init_level4_pgt);
 	READ_SYMBOL("vmlist", vmlist);
 	READ_SYMBOL("vmap_area_list", vmap_area_list);
 	READ_SYMBOL("node_online_map", node_online_map);
-- 
2.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
