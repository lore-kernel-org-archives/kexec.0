Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOit-00067Q-Aa
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:32 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E3C063EE0AE
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:29 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id CDDA645DE5B
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:29 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id ABE1E45DE56
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:29 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9E0791DB8042
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:29 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 49D6F1DB8044
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:29 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 04/10] Add debuginfo-related processing for VMCOREINFO/VMLINUX
Date: Thu, 08 Nov 2012 18:48:28 +0900
Message-ID: <20121108094828.30421.33403.stgit@localhost6.localdomain6>
In-Reply-To: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

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
