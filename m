Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1diBmO-0007Ay-KF
 for kexec@lists.infradead.org; Thu, 17 Aug 2017 03:47:35 +0000
Received: by mail-pg0-f41.google.com with SMTP id t3so5915764pgt.0
 for <kexec@lists.infradead.org>; Wed, 16 Aug 2017 20:47:11 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH v2] Fix SECTION_MAP_MASK for kernel >= v.13
Date: Thu, 17 Aug 2017 09:16:59 +0530
Message-Id: <13b8d74c1b64c5ac96497b08176a98382e5bf1e1.1502941463.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

commit 2d070eab2e82 "mm: consider zone which is not fully populated to
have holes" added a new flag SECTION_IS_ONLINE and therefore
SECTION_MAP_MASK has been changed. We are not able to find correct
mem_map in makedumpfile for kernel version v4.13-rc1 and onward because
of the above kernel change.

This patch fixes the MASK value keeping the code backward compatible

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
v1->v2: Improved kernel_version comparison to take care of stable kernel
versions as well.

 makedumpfile.c | 5 ++++-
 makedumpfile.h | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 30230a15a2e7..c975651ca357 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3304,7 +3304,10 @@ section_mem_map_addr(unsigned long addr)
 		return NOT_KV_ADDR;
 	}
 	map = ULONG(mem_section + OFFSET(mem_section.section_mem_map));
-	map &= SECTION_MAP_MASK;
+	if (info->kernel_version < KERNEL_VERSION(4, 13, 0))
+		map &= SECTION_MAP_MASK_4_12;
+	else
+		map &= SECTION_MAP_MASK;
 	free(mem_section);
 
 	return map;
diff --git a/makedumpfile.h b/makedumpfile.h
index 8a05794843fb..322f28c632b0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -183,7 +183,9 @@ isAnon(unsigned long mapping)
 #define SECTIONS_PER_ROOT()	(info->sections_per_root)
 #define SECTION_ROOT_MASK()	(SECTIONS_PER_ROOT() - 1)
 #define SECTION_NR_TO_ROOT(sec)	((sec) / SECTIONS_PER_ROOT())
-#define SECTION_MAP_LAST_BIT	(1UL<<2)
+#define SECTION_IS_ONLINE	(1UL<<2)
+#define SECTION_MAP_LAST_BIT	(1UL<<3)
+#define SECTION_MAP_MASK_4_12	(~(SECTION_IS_ONLINE-1))
 #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
 #define NR_SECTION_ROOTS()	divideup(num_section, SECTIONS_PER_ROOT())
 #define SECTION_NR_TO_PFN(sec)	((sec) << PFN_SECTION_SHIFT())
-- 
2.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
