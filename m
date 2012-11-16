Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE3u-00067l-EP
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:01:55 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EE9F23EE081
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:52 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D692C45DEB7
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:52 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id B509E45DEB2
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:52 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A902C1DB803B
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:52 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 540AA1DB8038
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:52 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 04/10] Add debuginfo-related processing for
 VMCOREINFO/VMLINUX
Date: Fri, 16 Nov 2012 14:01:51 +0900
Message-ID: <20121116050151.8280.31408.stgit@localhost6.localdomain6>
In-Reply-To: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 6513059..0d03716 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -914,6 +914,8 @@ get_structure_info(void)
 	OFFSET_INIT(page.flags, "page", "flags");
 	OFFSET_INIT(page._count, "page", "_count");
 	OFFSET_INIT(page.mapping, "page", "mapping");
+	OFFSET_INIT(page._mapcount, "page", "_mapcount");
+	OFFSET_INIT(page.private, "page", "private");
 
 	/*
 	 * Some vmlinux(s) don't have debugging information about
@@ -1005,6 +1007,10 @@ get_structure_info(void)
 	ENUM_NUMBER_INIT(PG_lru, "PG_lru");
 	ENUM_NUMBER_INIT(PG_private, "PG_private");
 	ENUM_NUMBER_INIT(PG_swapcache, "PG_swapcache");
+	ENUM_NUMBER_INIT(PG_buddy, "PG_buddy");
+	ENUM_NUMBER_INIT(PG_slab, "PG_slab");
+
+	ENUM_TYPE_SIZE_INIT(pageflags, "pageflags");
 
 	TYPEDEF_SIZE_INIT(nodemask_t, "nodemask_t");
 
@@ -1355,6 +1361,7 @@ write_vmcoreinfo_data(void)
 	WRITE_STRUCTURE_SIZE("list_head", list_head);
 	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
+	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
 
 	/*
 	 * write the member offset of 1st kernel
@@ -1363,6 +1370,8 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("page._count", page._count);
 	WRITE_MEMBER_OFFSET("page.mapping", page.mapping);
 	WRITE_MEMBER_OFFSET("page.lru", page.lru);
+	WRITE_MEMBER_OFFSET("page._mapcount", page._mapcount);
+	WRITE_MEMBER_OFFSET("page.private", page.private);
 	WRITE_MEMBER_OFFSET("mem_section.section_mem_map",
 	    mem_section.section_mem_map);
 	WRITE_MEMBER_OFFSET("pglist_data.node_zones", pglist_data.node_zones);
@@ -1407,6 +1416,10 @@ write_vmcoreinfo_data(void)
 	WRITE_NUMBER("PG_lru", PG_lru);
 	WRITE_NUMBER("PG_private", PG_private);
 	WRITE_NUMBER("PG_swapcache", PG_swapcache);
+	WRITE_NUMBER("PG_buddy", PG_buddy);
+	WRITE_NUMBER("PG_slab", PG_slab);
+
+	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 
 	/*
 	 * write the source file of 1st kernel
@@ -1654,11 +1667,14 @@ read_vmcoreinfo(void)
 	READ_STRUCTURE_SIZE("list_head", list_head);
 	READ_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	READ_STRUCTURE_SIZE("nodemask_t", nodemask_t);
+	READ_STRUCTURE_SIZE("pageflags", pageflags);
 
 	READ_MEMBER_OFFSET("page.flags", page.flags);
 	READ_MEMBER_OFFSET("page._count", page._count);
 	READ_MEMBER_OFFSET("page.mapping", page.mapping);
 	READ_MEMBER_OFFSET("page.lru", page.lru);
+	READ_MEMBER_OFFSET("page._mapcount", page._mapcount);
+	READ_MEMBER_OFFSET("page.private", page.private);
 	READ_MEMBER_OFFSET("mem_section.section_mem_map",
 	    mem_section.section_mem_map);
 	READ_MEMBER_OFFSET("pglist_data.node_zones", pglist_data.node_zones);
@@ -1695,9 +1711,12 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PG_lru", PG_lru);
 	READ_NUMBER("PG_private", PG_private);
 	READ_NUMBER("PG_swapcache", PG_swapcache);
-
+	READ_NUMBER("PG_slab", PG_slab);
+	READ_NUMBER("PG_buddy", PG_buddy);
 	READ_SRCFILE("pud_t", pud_t);
 
+	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
+
 	return TRUE;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
