Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPUUw-0004Kl-M4
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 09:05:51 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r3995mFH016786
 for <kexec@lists.infradead.org>; Tue, 9 Apr 2013 18:05:48 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id r3995ma03567 for kexec@lists.infradead.org;
 Tue, 9 Apr 2013 18:05:48 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id r3995GFe007643
 for <kexec@lists.infradead.org>; Tue, 9 Apr 2013 18:05:48 +0900 (JST)
Date: Tue, 9 Apr 2013 17:27:46 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 1/4] Introduce new symbols to look at the first vmap_area.
Message-Id: <20130409172746.d1cff9900f219404f589352e@mxc.nes.nec.co.jp>
In-Reply-To: <20130409172706.d6eda15764b0ef2700588e74@mxc.nes.nec.co.jp>
References: <20130409172706.d6eda15764b0ef2700588e74@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 14 Mar 2013 11:08:57 +0900
Subject: [PATCH 1/4] Introduce new symbols to look at the first vmap_area.

struct vmlist which we used to get vmalloc_start value will be
removed from kernel soon, so we have to look at the first vmap_area
in the sorted vmap_area_list instead of vmlist.

The address which contains vmalloc_start value is represented as
below:

  vmap_area_list.next - OFFSET(vmap_area.list) + OFFSET(vmap_area.va_start)

This patch introduces these symbols.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 9 +++++++++
 makedumpfile.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 6de0581..9cf907c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -854,6 +854,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
 	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
 	SYMBOL_INIT(vmlist, "vmlist");
+	SYMBOL_INIT(vmap_area_list, "vmap_area_list");
 	SYMBOL_INIT(phys_base, "phys_base");
 	SYMBOL_INIT(node_online_map, "node_online_map");
 	SYMBOL_INIT(node_states, "node_states");
@@ -989,6 +990,8 @@ get_structure_info(void)
 	OFFSET_INIT(node_memblk_s.nid, "node_memblk_s", "nid");
 
 	OFFSET_INIT(vm_struct.addr, "vm_struct", "addr");
+	OFFSET_INIT(vmap_area.va_start, "vmap_area", "va_start");
+	OFFSET_INIT(vmap_area.list, "vmap_area", "list");
 
 	/*
 	 * Get offset of the module members.
@@ -1368,6 +1371,7 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
 	WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
 	WRITE_SYMBOL("vmlist", vmlist);
+	WRITE_SYMBOL("vmap_area_list", vmap_area_list);
 	WRITE_SYMBOL("phys_base", phys_base);
 	WRITE_SYMBOL("node_online_map", node_online_map);
 	WRITE_SYMBOL("node_states", node_states);
@@ -1430,6 +1434,8 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("node_memblk_s.size", node_memblk_s.size);
 	WRITE_MEMBER_OFFSET("node_memblk_s.nid", node_memblk_s.nid);
 	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
+	WRITE_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
+	WRITE_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
 	WRITE_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
 	WRITE_MEMBER_OFFSET("log.len", log.len);
 	WRITE_MEMBER_OFFSET("log.text_len", log.text_len);
@@ -1684,6 +1690,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("swapper_pg_dir", swapper_pg_dir);
 	READ_SYMBOL("init_level4_pgt", init_level4_pgt);
 	READ_SYMBOL("vmlist", vmlist);
+	READ_SYMBOL("vmap_area_list", vmap_area_list);
 	READ_SYMBOL("phys_base", phys_base);
 	READ_SYMBOL("node_online_map", node_online_map);
 	READ_SYMBOL("node_states", node_states);
@@ -1739,6 +1746,8 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("node_memblk_s.size", node_memblk_s.size);
 	READ_MEMBER_OFFSET("node_memblk_s.nid", node_memblk_s.nid);
 	READ_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
+	READ_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
+	READ_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
 	READ_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
 	READ_MEMBER_OFFSET("log.len", log.len);
 	READ_MEMBER_OFFSET("log.text_len", log.text_len);
diff --git a/makedumpfile.h b/makedumpfile.h
index de329f3..36cb9fd 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1096,6 +1096,7 @@ struct symbol_table {
 	unsigned long long	swapper_pg_dir;
 	unsigned long long	init_level4_pgt;
 	unsigned long long	vmlist;
+	unsigned long long	vmap_area_list;
 	unsigned long long	phys_base;
 	unsigned long long	node_online_map;
 	unsigned long long	node_states;
@@ -1233,6 +1234,10 @@ struct offset_table {
 	struct vm_struct {
 		long	addr;
 	} vm_struct;
+	struct vmap_area {
+		long	va_start;
+		long	list;
+	} vmap_area;
 
 	/*
 	 * for Xen extraction
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
