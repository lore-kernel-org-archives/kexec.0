Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WW7s5-0001r3-7e
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 17:25:42 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH v2 1/3] Pass mmd pointer to __exclude_unnecessary_pages
Date: Fri,  4 Apr 2014 19:25:07 +0200
Message-Id: <5bf492a576255fe25a1a84d6b8d105cb55c9bcec.1396632131.git.ptesarik@suse.cz>
In-Reply-To: <cover.1396632131.git.ptesarik@suse.cz>
References: <cover.1396632131.git.ptesarik@suse.cz>
In-Reply-To: <cover.1396632131.git.ptesarik@suse.cz>
References: <cover.1396632131.git.ptesarik@suse.cz>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org

Pass the mmd pointer itself instead of the individual fields, so additional
information can be kept in mem_map_data.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5e81cc5..81c687b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4658,9 +4658,11 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 }
 
 int
-__exclude_unnecessary_pages(unsigned long mem_map,
-    unsigned long long pfn_start, unsigned long long pfn_end, struct cycle *cycle)
+__exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
 {
+	unsigned long mem_map = mmd->mem_map;
+	unsigned long long pfn_start = mmd->pfn_start;
+	unsigned long long pfn_end = mmd->pfn_end;
 	unsigned long long pfn, pfn_mm, maddr;
 	unsigned long long pfn_read_start, pfn_read_end, index_pg;
 	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
@@ -4809,8 +4811,7 @@ exclude_unnecessary_pages(void)
 		if (mmd->mem_map == NOT_MEMMAP_ADDR)
 			continue;
 
-		if (!__exclude_unnecessary_pages(mmd->mem_map,
-						 mmd->pfn_start, mmd->pfn_end, NULL))
+		if (!__exclude_unnecessary_pages(mmd, NULL))
 			return FALSE;
 	}
 
@@ -4860,8 +4861,7 @@ exclude_unnecessary_pages_cyclic(struct cycle *cycle)
 
 			if (mmd->pfn_end >= cycle->start_pfn &&
 			    mmd->pfn_start <= cycle->end_pfn) {
-				if (!__exclude_unnecessary_pages(mmd->mem_map,
-								 mmd->pfn_start, mmd->pfn_end, cycle))
+				if (!__exclude_unnecessary_pages(mmd, cycle))
 					return FALSE;
 			}
 		}
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
