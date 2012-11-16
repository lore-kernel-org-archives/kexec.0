Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE3z-00069Y-Pw
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:02:00 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3D8203EE081
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:58 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 24A9045DE4E
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 049D845DD74
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EAE8C1DB803A
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:57 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A4D851DB802C
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:57 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 05/10] Add hardcoded page flag values
Date: Fri, 16 Nov 2012 14:01:57 +0900
Message-ID: <20121116050157.8280.22495.stgit@localhost6.localdomain6>
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

Although these values should basically be exported from VMCOREINFO, we
cannot modify old kernels. Luckily, these values had not so frequently
been changed that it's relatively easy to determine appropreate values
for a given kernel version without any symbol or type information.

On the other hand, the mem_map logic also needs the values for some
members of page structure. But it much depends on kernel versions. We
aovid to hard code the values.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   32 ++++++++++++++++++++++++++++++++
 makedumpfile.h |    9 +++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0d03716..1a0151c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1210,6 +1210,38 @@ get_value_for_old_linux(void)
 		NUMBER(PG_private) = PG_private_ORIGINAL;
 	if (NUMBER(PG_swapcache) == NOT_FOUND_NUMBER)
 		NUMBER(PG_swapcache) = PG_swapcache_ORIGINAL;
+	if (NUMBER(PG_slab) == NOT_FOUND_NUMBER)
+		NUMBER(PG_slab) = PG_slab_ORIGINAL;
+	/*
+	 * The values from here are for free page filtering based on
+	 * mem_map array. These are minimum effort to cover old
+	 * kernels.
+	 *
+	 * The logic also needs offset values for some members of page
+	 * structure. But it much depends on kernel versions. We avoid
+	 * to hard code the values.
+	 */
+	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
+		if (info->kernel_version >= KERNEL_VERSION(2, 6, 17)
+		    && info->kernel_version <= KERNEL_VERSION(2, 6, 26))
+			NUMBER(PG_buddy) = PG_buddy_v2_6_17_to_v2_6_26;
+		if (info->kernel_version >= KERNEL_VERSION(2, 6, 27)
+		    && info->kernel_version <= KERNEL_VERSION(2, 6, 37))
+			NUMBER(PG_buddy) = PG_buddy_v2_6_27_to_v2_6_37;
+	}
+	if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER) {
+		if (info->kernel_version == KERNEL_VERSION(2, 6, 38))
+			NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) =
+				PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_38;
+		if (info->kernel_version >= KERNEL_VERSION(2, 6, 39))
+			NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) =
+			PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_39_to_latest_version;
+	}
+	if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
+		if (info->kernel_version >= KERNEL_VERSION(2, 6, 27))
+			SIZE(pageflags) =
+				PAGE_FLAGS_SIZE_v2_6_27_to_latest_version;
+	}
 	return TRUE;
 }
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 1304df0..d69bcca 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -71,9 +71,18 @@ int get_mem_type(void);
  * The following values are for linux-2.6.25 or former.
  */
 #define PG_lru_ORIGINAL	 	(5)
+#define PG_slab_ORIGINAL	(7)
 #define PG_private_ORIGINAL	(11)	/* Has something at ->private */
 #define PG_swapcache_ORIGINAL	(15)	/* Swap page: swp_entry_t in private */
 
+#define PG_buddy_v2_6_17_to_v2_6_26	(19)
+#define PG_buddy_v2_6_27_to_v2_6_37	(18)
+
+#define PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_38	(-2)
+#define PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_39_to_latest_version	(-128)
+
+#define PAGE_FLAGS_SIZE_v2_6_27_to_latest_version	(4)
+
 #define PAGE_MAPPING_ANON	(1)
 
 #define LSEEKED_BITMAP	(1)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
