Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.provo.novell.com ([137.65.250.81])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ehWZ2-0004Gv-JU
 for kexec@lists.infradead.org; Fri, 02 Feb 2018 08:19:18 +0000
Date: Fri, 2 Feb 2018 09:18:57 +0100
From: Petr Tesarik <ptesarik@suse.com>
Subject: [makedumpfile PATCH] Always use bigger SECTION_MAP_MASK
Message-ID: <20180202091857.09299610@ezekiel.suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec mailing list <kexec@lists.infradead.org>, Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>

It is not necessary to distinguish between different kernel
versions. Kernel commit 2d070eab2e82 merely reuses a previously
unused bit (see clarification in kernel commit def9b71ee651a). The
bit was always zero even before that commit, so it is safe to mask
it off even for kernel versions before 4.13, removing some of the
complexity.

More importantly, makedumpfile fails on kernels which backport the
patch on top of an older version (for example SLES15).

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 makedumpfile.c | 5 +----
 makedumpfile.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ed138d3..b180eb3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3337,10 +3337,7 @@ section_mem_map_addr(unsigned long addr)
 		return NOT_KV_ADDR;
 	}
 	map = ULONG(mem_section + OFFSET(mem_section.section_mem_map));
-	if (info->kernel_version < KERNEL_VERSION(4, 13, 0))
-		map &= SECTION_MAP_MASK_4_12;
-	else
-		map &= SECTION_MAP_MASK;
+	map &= SECTION_MAP_MASK;
 	free(mem_section);
 
 	return map;
diff --git a/makedumpfile.h b/makedumpfile.h
index 01eece2..548aab0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -186,7 +186,6 @@ isAnon(unsigned long mapping)
 #define SECTION_NR_TO_ROOT(sec)	((sec) / SECTIONS_PER_ROOT())
 #define SECTION_IS_ONLINE	(1UL<<2)
 #define SECTION_MAP_LAST_BIT	(1UL<<3)
-#define SECTION_MAP_MASK_4_12	(~(SECTION_IS_ONLINE-1))
 #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
 #define NR_SECTION_ROOTS()	divideup(num_section, SECTIONS_PER_ROOT())
 #define SECTION_NR_TO_PFN(sec)	((sec) << PFN_SECTION_SHIFT())
-- 
2.13.6

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
