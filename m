Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-f175.google.com ([209.85.223.175])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dcpG3-0006Jh-NI
 for kexec@lists.infradead.org; Wed, 02 Aug 2017 08:44:04 +0000
Received: by mail-io0-f175.google.com with SMTP id o9so17870581iod.1
 for <kexec@lists.infradead.org>; Wed, 02 Aug 2017 01:43:39 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH v2] x86_64: Take care of init_level4_pgt rename
 in kernel
Date: Wed,  2 Aug 2017 14:13:16 +0530
Message-Id: <38ae7bb411e2520e320548f4538431d2e9722bdc.1501662929.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org

Following commit renamed init_level4_pgt to init_top_pgt in kernel.

commit 65ade2f872b474fa8a04c2d397783350326634e6
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Tue Jun 6 14:31:27 2017 +0300

    x86/boot/64: Rename init_level4_pgt and early_level4_pgt

This patch takes care of above kernel modification in makedumpfile.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
v2 -> v1
Removed redundant 'if condition' for WRITE_SYMBOL().

 makedumpfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index f85003a33551..30230a15a2e7 100644
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
@@ -2500,6 +2502,8 @@ read_vmcoreinfo(void)
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
