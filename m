Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gg0-f177.google.com ([209.85.161.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIfq-0005ST-BY
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:38:34 +0000
Received: by ggcs5 with SMTP id s5so2203564ggc.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:38:33 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 04/10] Add debuginfo-related processing for
 VMCOREINFO/VMLINUX
Date: Fri, 29 Jun 2012 02:38:29 +0900
Message-ID: <20120628173829.19702.95722.stgit@fedora-machine>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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

 makedumpfile.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a6b3de7..d8da608 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -876,6 +876,8 @@ get_structure_info(void)
 	OFFSET_INIT(page._count, "page", "_count");
 
 	OFFSET_INIT(page.mapping, "page", "mapping");
+	OFFSET_INIT(page._mapcount, "page", "_mapcount");
+	OFFSET_INIT(page.private, "page", "private");
 
 	/*
 	 * On linux-2.6.16 or later, page.mapping is defined
@@ -974,6 +976,10 @@ get_structure_info(void)
 	ENUM_NUMBER_INIT(PG_lru, "PG_lru");
 	ENUM_NUMBER_INIT(PG_private, "PG_private");
 	ENUM_NUMBER_INIT(PG_swapcache, "PG_swapcache");
+	ENUM_NUMBER_INIT(PG_buddy, "PG_buddy");
+	ENUM_NUMBER_INIT(PG_slab, "PG_slab");
+
+	ENUM_TYPE_SIZE_INIT(pageflags, "pageflags");
 
 	TYPEDEF_SIZE_INIT(nodemask_t, "nodemask_t");
 
@@ -1324,6 +1330,7 @@ write_vmcoreinfo_data(void)
 	WRITE_STRUCTURE_SIZE("list_head", list_head);
 	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
+	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
 
 	/*
 	 * write the member offset of 1st kernel
@@ -1332,6 +1339,8 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("page._count", page._count);
 	WRITE_MEMBER_OFFSET("page.mapping", page.mapping);
 	WRITE_MEMBER_OFFSET("page.lru", page.lru);
+	WRITE_MEMBER_OFFSET("page._mapcount", page._mapcount);
+	WRITE_MEMBER_OFFSET("page.private", page.private);
 	WRITE_MEMBER_OFFSET("mem_section.section_mem_map",
 	    mem_section.section_mem_map);
 	WRITE_MEMBER_OFFSET("pglist_data.node_zones", pglist_data.node_zones);
@@ -1376,6 +1385,10 @@ write_vmcoreinfo_data(void)
 	WRITE_NUMBER("PG_lru", PG_lru);
 	WRITE_NUMBER("PG_private", PG_private);
 	WRITE_NUMBER("PG_swapcache", PG_swapcache);
+	WRITE_NUMBER("PG_buddy", PG_buddy);
+	WRITE_NUMBER("PG_slab", PG_slab);
+
+	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 
 	/*
 	 * write the source file of 1st kernel
@@ -1623,11 +1636,14 @@ read_vmcoreinfo(void)
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
@@ -1664,6 +1680,10 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PG_lru", PG_lru);
 	READ_NUMBER("PG_private", PG_private);
 	READ_NUMBER("PG_swapcache", PG_swapcache);
+	READ_NUMBER("PG_slab", PG_slab);
+	READ_NUMBER("PG_buddy", PG_buddy);
+
+	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 
 	READ_SRCFILE("pud_t", pud_t);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
